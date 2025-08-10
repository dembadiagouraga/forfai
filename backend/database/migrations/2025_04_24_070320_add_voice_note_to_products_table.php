<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddVoiceNoteToProductsTableV2 extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('products', function (Blueprint $table) {
            // Add voice_note_duration field if voice_note_url exists
            if (!Schema::hasColumn('products', 'voice_note_url')) {
                $table->string('voice_note_url')->nullable();
            }
            $table->integer('voice_note_duration')->nullable();
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
            $table->dropColumn('voice_note_duration');
        });
    }
}
