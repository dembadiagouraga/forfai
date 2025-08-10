<?php
require 'vendor/autoload.php';

use Aws\S3\S3Client;
use Aws\Exception\AwsException;

// Load environment variables from .env file
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

echo "AWS SDK Direct Test\n";
echo "==================\n\n";

// Get AWS settings
$accessKeyId = $_ENV['AWS_ACCESS_KEY_ID'];
$secretAccessKey = $_ENV['AWS_SECRET_ACCESS_KEY'];
$region = $_ENV['AWS_DEFAULT_REGION'];
$bucket = $_ENV['AWS_BUCKET'];

echo "AWS Bucket: $bucket\n";
echo "AWS Region: $region\n\n";

// Load Laravel application
$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

// Create a test audio file
$testAudioPath = __DIR__ . '/storage/app/public/test_audio.mp3';
$testAudioContent = str_repeat('0', 1024); // 1KB of zeros

// Check if test audio file already exists
if (file_exists($testAudioPath)) {
    echo "Using existing test audio file...\n";
} else {
    echo "Creating test audio file...\n";
    // Ensure directory exists
    if (!is_dir(dirname($testAudioPath))) {
        mkdir(dirname($testAudioPath), 0777, true);
    }
    file_put_contents($testAudioPath, $testAudioContent);
}

// Get a test product
echo "Fetching a test product...\n";
$product = App\Models\Product::first();

if (!$product) {
    echo "❌ No products found in the database. Please create a product first.\n";
    exit;
}

echo "Using product: " . $product->id . "\n\n";

// Test direct upload to S3 using AWS SDK
echo "Testing direct upload to S3 using AWS SDK...\n";
$voiceNotePath = 'media/voice-notes/' . uniqid() . '.mp3';

try {
    // Create S3 client
    $s3Client = new S3Client([
        'version' => 'latest',
        'region' => $region,
        'credentials' => [
            'key' => $accessKeyId,
            'secret' => $secretAccessKey,
        ],
        'http' => [
            'verify' => false // Disable SSL verification for testing
        ]
    ]);
    
    // Upload to S3
    $result = $s3Client->putObject([
        'Bucket' => $bucket,
        'Key' => $voiceNotePath,
        'Body' => file_get_contents($testAudioPath),
        // No ACL parameter
    ]);
    
    // Get the URL
    $url = $result['ObjectURL'];
    
    echo "✅ Voice note uploaded successfully to S3.\n";
    echo "URL: $url\n\n";
    
    // Update the product
    $product->update([
        'voice_note_url' => $url,
        'voice_note_duration' => 5,
    ]);
    
    echo "✅ Product updated with voice note URL.\n";
    
    // Verify the update
    $updatedProduct = App\Models\Product::find($product->id);
    
    if ($updatedProduct->voice_note_url === $url) {
        echo "✅ Product voice_note_url field updated correctly.\n";
    } else {
        echo "❌ Product voice_note_url field not updated correctly.\n";
        echo "Expected: $url\n";
        echo "Actual: " . $updatedProduct->voice_note_url . "\n";
    }
    
    if ($updatedProduct->voice_note_duration === 5) {
        echo "✅ Product voice_note_duration field updated correctly.\n";
    } else {
        echo "❌ Product voice_note_duration field not updated correctly.\n";
        echo "Expected: 5\n";
        echo "Actual: " . $updatedProduct->voice_note_duration . "\n";
    }
    
    // Test if the file is accessible
    echo "\nTesting if the voice note is accessible...\n";
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    if ($httpCode === 200) {
        echo "✅ Voice note is accessible. HTTP Code: $httpCode\n";
    } else {
        echo "❌ Voice note is not accessible. HTTP Code: $httpCode\n";
    }
} catch (Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}

echo "\nTest completed.\n";
