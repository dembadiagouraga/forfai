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
use App\Models\StorySaved;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class EnsureFrenchTranslations extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'translations:ensure-french';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Ensure that French translations exist for all entities by copying from English where missing';

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
        $this->info('Starting to ensure French translations exist...');
        
        // Check if French language exists and is active
        $french = Language::where('locale', 'fr')->first();
        if (!$french) {
            $this->error('French language does not exist in the system!');
            
            // Ask if we should create it
            if ($this->confirm('Do you want to create French language in the system?')) {
                Language::create([
                    'locale' => 'fr',
                    'title' => 'French',
                    'active' => true,
                    'default' => false,
                    'backward' => false
                ]);
                $this->info('French language created successfully!');
            } else {
                return 1;
            }
        } elseif (!$french->active) {
            if ($this->confirm('French language exists but is not active. Do you want to activate it?')) {
                $french->active = true;
                $french->save();
                $this->info('French language activated successfully!');
            }
        }
        
        // Process UI translations
        $this->processUITranslations();
        
        // Process model translations
        $this->processModelTranslations('Category', 'category_translations', 'category_id');
        $this->processModelTranslations('Product', 'product_translations', 'product_id');
        $this->processModelTranslations('Blog', 'blog_translations', 'blog_id');
        $this->processModelTranslations('FAQ', 'faq_translations', 'faq_id');
        $this->processModelTranslations('Banner', 'banner_translations', 'banner_id');
        $this->processModelTranslations('Unit', 'unit_translations', 'unit_id');
        $this->processModelTranslations('Shop Tag', 'shop_tag_translations', 'shop_tag_id');
        
        $this->info('French translations have been successfully ensured!');
        return 0;
    }
    
    /**
     * Process UI translations from the translations table
     */
    private function processUITranslations()
    {
        $this->info('Processing UI Translations...');
        
        // Get all English translations
        $englishTranslations = Translation::where('locale', 'en')->get();
        $count = 0;
        
        foreach ($englishTranslations as $enTrans) {
            // Check if French translation exists
            $frTrans = Translation::where('locale', 'fr')
                ->where('group', $enTrans->group)
                ->where('key', $enTrans->key)
                ->first();
                
            if (!$frTrans) {
                // Create French translation using English value
                Translation::create([
                    'locale' => 'fr',
                    'group' => $enTrans->group,
                    'key' => $enTrans->key,
                    'value' => $enTrans->value,
                    'status' => $enTrans->status,
                ]);
                $count++;
            } elseif (empty($frTrans->value) && !empty($enTrans->value)) {
                // Update empty French translation
                $frTrans->value = $enTrans->value;
                $frTrans->save();
                $count++;
            }
        }
        
        $this->info("Added/updated $count UI translations");
    }
    
    /**
     * Process translations for a specific model
     */
    private function processModelTranslations($modelName, $translationTable, $foreignKey)
    {
        $this->info("Processing $modelName Translations...");
        
        // Find all translation records for the model that are in English but not in French
        $query = "
            SELECT en.id, en.$foreignKey, en.title, en.description
            FROM $translationTable en
            LEFT JOIN $translationTable fr 
                ON en.$foreignKey = fr.$foreignKey AND fr.locale = 'fr'
            WHERE en.locale = 'en' AND fr.id IS NULL
        ";
        
        $missingTranslations = DB::select($query);
        $count = count($missingTranslations);
        
        if ($count > 0) {
            $this->info("Found $count missing $modelName translations");
            
            foreach ($missingTranslations as $item) {
                // Create French translation
                DB::table($translationTable)->insert([
                    $foreignKey => $item->$foreignKey,
                    'locale' => 'fr',
                    'title' => $item->title,
                    'description' => $item->description ?? null,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
            
            $this->info("Added $count French translations for $modelName");
        } else {
            $this->info("No missing translations for $modelName");
        }
    }
}
