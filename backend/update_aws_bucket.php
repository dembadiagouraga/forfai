<?php
require 'vendor/autoload.php';

// Load environment variables from .env file
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

echo "AWS S3 Bucket Update Tool\n";
echo "========================\n\n";

// Get current AWS settings
$currentBucket = $_ENV['AWS_BUCKET'];
$currentRegion = $_ENV['AWS_DEFAULT_REGION'];
$currentUrl = $_ENV['AWS_URL'];

echo "Current AWS settings:\n";
echo "Bucket: $currentBucket\n";
echo "Region: $currentRegion\n";
echo "URL: $currentUrl\n\n";

// Ask for new bucket name
echo "Enter the new bucket name (or press Enter to keep current): ";
$newBucket = trim(fgets(STDIN));
$newBucket = $newBucket ?: $currentBucket;

// Ask for new region
echo "Enter the new region (or press Enter to keep current): ";
$newRegion = trim(fgets(STDIN));
$newRegion = $newRegion ?: $currentRegion;

// Generate new URL
$newUrl = "https://$newBucket.s3.$newRegion.amazonaws.com";

echo "\nNew AWS settings:\n";
echo "Bucket: $newBucket\n";
echo "Region: $newRegion\n";
echo "URL: $newUrl\n\n";

// Confirm changes
echo "Do you want to update the .env file with these settings? (y/n): ";
$confirm = strtolower(trim(fgets(STDIN)));

if ($confirm === 'y' || $confirm === 'yes') {
    // Read the .env file
    $envFile = file_get_contents(__DIR__ . '/.env');
    
    // Replace the values
    $envFile = preg_replace('/AWS_BUCKET=.*/', "AWS_BUCKET=$newBucket", $envFile);
    $envFile = preg_replace('/AWS_DEFAULT_REGION=.*/', "AWS_DEFAULT_REGION=$newRegion", $envFile);
    $envFile = preg_replace('/AWS_URL=.*/', "AWS_URL=$newUrl", $envFile);
    
    // Write the updated .env file
    file_put_contents(__DIR__ . '/.env', $envFile);
    
    echo "✅ .env file updated successfully.\n";
} else {
    echo "❌ Update cancelled.\n";
}

echo "\nDone.\n";
