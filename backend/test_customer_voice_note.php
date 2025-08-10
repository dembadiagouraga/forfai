<?php
require 'vendor/autoload.php';

// Load environment variables from .env file
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

echo "Customer Voice Note Test\n";
echo "======================\n\n";

// Load Laravel application
$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

// Get a test product with voice note
echo "Fetching a product with voice note...\n";
$product = App\Models\Product::whereNotNull('voice_note_url')->first();

if (!$product) {
    echo "❌ No products with voice notes found in the database.\n";
    echo "Creating a test product with voice note...\n";
    
    // Get any product
    $product = App\Models\Product::first();
    
    if (!$product) {
        echo "❌ No products found in the database. Please create a product first.\n";
        exit;
    }
    
    // Create a test audio file
    $testAudioPath = __DIR__ . '/storage/app/public/test_audio.mp3';
    $testAudioContent = str_repeat('0', 1024); // 1KB of zeros
    
    // Check if test audio file already exists
    if (!file_exists($testAudioPath)) {
        // Ensure directory exists
        if (!is_dir(dirname($testAudioPath))) {
            mkdir(dirname($testAudioPath), 0777, true);
        }
        file_put_contents($testAudioPath, $testAudioContent);
    }
    
    // Upload to S3 using AWS SDK
    $s3Client = new \Aws\S3\S3Client([
        'version' => 'latest',
        'region' => env('AWS_DEFAULT_REGION'),
        'credentials' => [
            'key' => env('AWS_ACCESS_KEY_ID'),
            'secret' => env('AWS_SECRET_ACCESS_KEY'),
        ],
        'http' => [
            'verify' => false // Disable SSL verification for testing
        ]
    ]);
    
    // Upload to S3
    $voiceNotePath = 'media/voice-notes/' . uniqid() . '.mp3';
    $result = $s3Client->putObject([
        'Bucket' => env('AWS_BUCKET'),
        'Key' => $voiceNotePath,
        'Body' => file_get_contents($testAudioPath),
        // No ACL parameter
    ]);
    
    // Get the URL
    $url = $result['ObjectURL'];
    
    // Update the product
    $product->update([
        'voice_note_url' => $url,
        'voice_note_duration' => 5,
    ]);
    
    echo "✅ Created test product with voice note.\n";
}

echo "Using product: " . $product->id . "\n";
echo "Voice note URL: " . $product->voice_note_url . "\n";
echo "Voice note duration: " . $product->voice_note_duration . " seconds\n\n";

// Test if the voice note URL is accessible
echo "Testing if the voice note is accessible...\n";
$ch = curl_init($product->voice_note_url);
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
$bucket = $_ENV['AWS_BUCKET'];
if (strpos($product->voice_note_url, $bucket) !== false) {
    echo "✅ Voice note is stored in AWS S3 bucket.\n";
} else {
    echo "❌ Voice note is not stored in AWS S3 bucket.\n";
}

// Create a test API endpoint to simulate customer app
echo "\nCreating a test API endpoint for customer app...\n";

// Create a route for testing
$router = $app->make('router');
$router->get('/api/test/product/{id}', function ($id) {
    $product = App\Models\Product::find($id);
    if (!$product) {
        return response()->json(['error' => 'Product not found'], 404);
    }
    
    return response()->json([
        'id' => $product->id,
        'title' => $product->title,
        'voice_note_url' => $product->voice_note_url,
        'voice_note_duration' => $product->voice_note_duration,
    ]);
});

// Test the API endpoint
$response = $app->make('router')->dispatch(
    Illuminate\Http\Request::create("/api/test/product/{$product->id}", 'GET')
);

$content = json_decode($response->getContent(), true);
echo "API response: " . json_encode($content, JSON_PRETTY_PRINT) . "\n\n";

echo "Test completed.\n";
