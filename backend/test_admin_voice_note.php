<?php
require 'vendor/autoload.php';

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use App\Services\ProductService\ProductService;

// Load environment variables from .env file
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

echo "Admin Voice Note Upload Test\n";
echo "==========================\n\n";

// Get AWS settings
$accessKeyId = $_ENV['AWS_ACCESS_KEY_ID'];
$secretAccessKey = $_ENV['AWS_SECRET_ACCESS_KEY'];
$region = $_ENV['AWS_DEFAULT_REGION'];
$bucket = $_ENV['AWS_BUCKET'];

echo "AWS Bucket: $bucket\n";
echo "AWS Region: $region\n\n";

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

// Load Laravel application
$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

// Get a test product
echo "Fetching a test product...\n";
$product = App\Models\Product::first();

if (!$product) {
    echo "❌ No products found in the database. Please create a product first.\n";
    exit;
}

echo "Using product: " . $product->title . " (ID: " . $product->id . ")\n\n";

// Create an UploadedFile instance
$uploadedFile = new UploadedFile(
    $testAudioPath,
    'test_audio.mp3',
    'audio/mpeg',
    null,
    true
);

// Simulate a request with the voice note
$_FILES['voice_note'] = [
    'name' => 'test_audio.mp3',
    'type' => 'audio/mpeg',
    'tmp_name' => $testAudioPath,
    'error' => 0,
    'size' => filesize($testAudioPath)
];

// Set up the request
$_POST['voice_note_duration'] = 5; // 5 seconds duration
$_POST['category_id'] = $product->category_id; // Use the existing category ID

// Create a request instance
$request = Illuminate\Http\Request::create(
    '/api/v1/dashboard/admin/products/' . $product->slug,
    'PUT',
    $_POST,
    [],
    $_FILES
);

// Set the uploaded file in the request
$request->files->set('voice_note', $uploadedFile);

// Call the ProductService
echo "Calling ProductService to update the product with a voice note...\n";
echo "Request has voice_note file: " . ($request->hasFile('voice_note') ? 'Yes' : 'No') . "\n";
echo "Request has voice_note_duration: " . ($request->has('voice_note_duration') ? 'Yes' : 'No') . "\n";

$productService = new ProductService();
$result = $productService->update($product->slug, $request->all());

// Check the result
if ($result['status']) {
    echo "✅ Product updated successfully with voice note.\n";

    // Get the updated product
    $updatedProduct = App\Models\Product::find($product->id);

    // Check if voice note URL is set
    if ($updatedProduct->voice_note_url) {
        echo "✅ Voice note URL is set: " . $updatedProduct->voice_note_url . "\n";

        // Check if the URL is accessible
        echo "Testing if the voice note is accessible...\n";
        $ch = curl_init($updatedProduct->voice_note_url);
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

        // Check if the URL contains the AWS S3 bucket
        if (strpos($updatedProduct->voice_note_url, $bucket) !== false) {
            echo "✅ Voice note is stored in AWS S3 bucket.\n";
        } else {
            echo "❌ Voice note is not stored in AWS S3 bucket.\n";
        }
    } else {
        echo "❌ Voice note URL is not set.\n";
    }
} else {
    echo "❌ Failed to update product: " . ($result['message'] ?? 'Unknown error') . "\n";
}

echo "\nTest completed.\n";
