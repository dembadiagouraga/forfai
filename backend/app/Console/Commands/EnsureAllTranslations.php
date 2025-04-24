<?php

namespace App\Console\Commands;

use App\Models\Translation;
use App\Models\Language;
use App\Models\Category;
use App\Models\Product;
use App\Models\Blog;
use App\Models\Faq;
use App\Models\Banner;
use App\Models\Unit;
use App\Models\ShopTag;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class EnsureAllTranslations extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'translations:ensure-all {--language= : Specific language code to ensure translations for}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Ensure that translations exist for all entities in all languages by copying from English where missing';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $this->info('Starting to ensure all translations exist...');
        
        // Get all active languages or the specific one requested
        $specificLanguage = $this->option('language');
        
        if ($specificLanguage) {
            $languages = Language::where('locale', $specificLanguage)
                ->where('active', true)
                ->get();
                
            if ($languages->isEmpty()) {
                $this->error("Language with locale '$specificLanguage' not found or not active!");
                return 1;
            }
        } else {
            $languages = Language::where('active', true)
                ->where('locale', '!=', 'en') // Skip English as it's the source
                ->get();
                
            if ($languages->isEmpty()) {
                $this->error('No active languages found besides English!');
                return 1;
            }
        }
        
        // Process UI translations
        $this->processUITranslations($languages);
        
        // Process model translations for each language
        foreach ($languages as $language) {
            $this->info("\nProcessing translations for language: {$language->title} ({$language->locale})");
            
            $this->processModelTranslations('Category', 'category_translations', 'category_id', $language->locale);
            $this->processModelTranslations('Product', 'product_translations', 'product_id', $language->locale);
            $this->processModelTranslations('Blog', 'blog_translations', 'blog_id', $language->locale);
            $this->processModelTranslations('FAQ', 'faq_translations', 'faq_id', $language->locale);
            $this->processModelTranslations('Banner', 'banner_translations', 'banner_id', $language->locale);
            $this->processModelTranslations('Unit', 'unit_translations', 'unit_id', $language->locale);
            $this->processModelTranslations('Shop Tag', 'shop_tag_translations', 'shop_tag_id', $language->locale);
        }
        
        $this->info("\nAll translations have been successfully ensured!");
        return 0;
    }
    
    /**
     * Process UI translations from the translations table
     */
    private function processUITranslations($languages)
    {
        $this->info('Processing UI Translations...');
        
        // Get all English translations
        $englishTranslations = Translation::where('locale', 'en')->get();
        
        foreach ($languages as $language) {
            $count = 0;
            
            foreach ($englishTranslations as $enTrans) {
                // Check if translation exists in target language
                $targetTrans = Translation::where('locale', $language->locale)
                    ->where('group', $enTrans->group)
                    ->where('key', $enTrans->key)
                    ->first();
                    
                if (!$targetTrans) {
                    // Create target language translation using English value
                    Translation::create([
                        'locale' => $language->locale,
                        'group' => $enTrans->group,
                        'key' => $enTrans->key,
                        'value' => $enTrans->value,
                        'status' => $enTrans->status,
                    ]);
                    $count++;
                } elseif (empty($targetTrans->value) && !empty($enTrans->value)) {
                    // Update empty target translation
                    $targetTrans->value = $enTrans->value;
                    $targetTrans->save();
                    $count++;
                }
            }
            
            $this->info("  Added/updated $count UI translations for {$language->locale}");
            
            // Clear cache for this language
            try {
                cache()->forget('language-' . $language->locale);
            } catch (\Throwable $e) {
                $this->warn("  Failed to clear cache for {$language->locale}: " . $e->getMessage());
            }
        }
    }
    
    /**
     * Process translations for a specific model
     */
    private function processModelTranslations($modelName, $translationTable, $foreignKey, $locale)
    {
        $this->info("  Processing $modelName Translations...");
        
        // Find all translation records for the model that are in English but not in the target language
        $query = "
            SELECT en.id, en.$foreignKey, en.title, en.description
            FROM $translationTable en
            LEFT JOIN $translationTable target 
                ON en.$foreignKey = target.$foreignKey AND target.locale = ?
            WHERE en.locale = 'en' AND target.id IS NULL
        ";
        
        $missingTranslations = DB::select($query, [$locale]);
        $count = count($missingTranslations);
        
        if ($count > 0) {
            $this->info("    Found $count missing $modelName translations");
            
            foreach ($missingTranslations as $item) {
                // Create translation in target language
                DB::table($translationTable)->insert([
                    $foreignKey => $item->$foreignKey,
                    'locale' => $locale,
                    'title' => $item->title,
                    'description' => $item->description ?? null,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
            
            $this->info("    Added $count translations for $modelName in $locale");
        } else {
            $this->info("    No missing translations for $modelName in $locale");
        }
    }
} 