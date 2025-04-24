<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class EnsureTranslationCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'translations:ensure {--language= : Specific language code to ensure translations for}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Ensures all translations are available in all languages';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $language = $this->option('language');
        $languageOption = $language ? "--language=$language" : '';
        
        $this->info('Starting translation ensure process...');
        
        // First run the French translations command for backward compatibility
        if (!$language || $language === 'fr') {
            $this->info('Running French translations ensure...');
            $this->call('translations:ensure-french');
        }
        
        // Then run the all translations command
        $this->info('Running all translations ensure...');
        $this->call('translations:ensure-all', [
            '--language' => $language
        ]);
        
        $this->info('All translations have been ensured!');
        
        return Command::SUCCESS;
    }
} 