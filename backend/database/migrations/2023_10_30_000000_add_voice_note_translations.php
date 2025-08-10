<?php

use Illuminate\Database\Migrations\Migration;
use App\Models\Translation;

class AddVoiceNoteTranslations extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // Add translations for voice note feature
        $translations = [
            // English translations
            [
                'key' => 'voice.note',
                'group' => 'web',
                'value' => 'Voice Note',
                'locale' => 'en'
            ],
            [
                'key' => 'record.voice.note',
                'group' => 'web',
                'value' => 'Record Voice Note',
                'locale' => 'en'
            ],
            [
                'key' => 'play',
                'group' => 'web',
                'value' => 'Play',
                'locale' => 'en'
            ],
            [
                'key' => 'pause',
                'group' => 'web',
                'value' => 'Pause',
                'locale' => 'en'
            ],
            [
                'key' => 'delete',
                'group' => 'web',
                'value' => 'Delete',
                'locale' => 'en'
            ],

            // French translations
            [
                'key' => 'voice.note',
                'group' => 'web',
                'value' => 'Note Vocale',
                'locale' => 'fr'
            ],
            [
                'key' => 'record.voice.note',
                'group' => 'web',
                'value' => 'Enregistrer une Note Vocale',
                'locale' => 'fr'
            ],
            [
                'key' => 'play',
                'group' => 'web',
                'value' => 'Lire',
                'locale' => 'fr'
            ],
            [
                'key' => 'pause',
                'group' => 'web',
                'value' => 'Pause',
                'locale' => 'fr'
            ],
            [
                'key' => 'delete',
                'group' => 'web',
                'value' => 'Supprimer',
                'locale' => 'fr'
            ]
        ];

        foreach ($translations as $translation) {
            try {
                // Check if translation already exists
                $exists = Translation::where('key', $translation['key'])
                    ->where('locale', $translation['locale'])
                    ->where('group', $translation['group'])
                    ->exists();

                if (!$exists) {
                    Translation::create([
                        'key' => $translation['key'],
                        'locale' => $translation['locale'],
                        'group' => $translation['group'],
                        'value' => $translation['value'],
                        'status' => 1
                    ]);
                }
            } catch (\Exception $e) {
                // Log error but continue with other translations
                \Log::error('Error adding translation: ' . $e->getMessage());
            }
        }
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        // Remove translations for voice note feature
        $keys = ['voice.note', 'record.voice.note', 'play', 'pause', 'delete'];

        foreach ($keys as $key) {
            Translation::where('key', $key)->delete();
        }
    }
}
