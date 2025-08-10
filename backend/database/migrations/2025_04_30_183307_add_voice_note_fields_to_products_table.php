<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddVoiceNoteFieldsToProductsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('products', function (Blueprint $table) {
            // Add voice_note_url field if it doesn't exist
            if (!Schema::hasColumn('products', 'voice_note_url')) {
                $table->string('voice_note_url')->nullable();
            }

            // Add voice_note_duration field
            if (!Schema::hasColumn('products', 'voice_note_duration')) {
                $table->integer('voice_note_duration')->nullable();
            }
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('products', function (Blueprint $table) {
            // Drop voice_note_duration field
            if (Schema::hasColumn('products', 'voice_note_duration')) {
                $table->dropColumn('voice_note_duration');
            }

            // We don't drop voice_note_url to maintain backward compatibility
        });
    }
}
