# Step 1: Create Database Migration

## Overview
First, we need to add voice note fields to the products table in the database.

## Instructions

### 1.1. Create Migration File
Run this command in the backend directory:
```bash
php artisan make:migration add_voice_note_to_products_table --table=products
```

### 1.2. Edit Migration File
Open the newly created migration file in `backend/database/migrations/XXXX_XX_XX_XXXXXX_add_voice_note_to_products_table.php` and add the following code:

```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddVoiceNoteToProductsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('products', function (Blueprint $table) {
            $table->string('voice_note_url')->nullable();
            $table->integer('voice_note_duration')->nullable(); // Duration in seconds
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
            $table->dropColumn('voice_note_url');
            $table->dropColumn('voice_note_duration');
        });
    }
}
```

### 1.3. Run Migration
Execute the migration:
```bash
php artisan migrate
```

### 1.4. Verify Migration
Check the database to ensure the new columns have been added to the products table.

## Expected Result
The products table should now have two new columns:
- `voice_note_url` (string, nullable)
- `voice_note_duration` (integer, nullable)

## Notes
- This migration is safe to run on a production database as it only adds nullable columns
- No existing functionality will be affected by this change
