<?php
require 'vendor/autoload.php';

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;

// Load environment variables from .env file
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

echo "Voice Message Upload Test\n";
echo "=======================\n\n";

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

// Create an UploadedFile instance
$uploadedFile = new UploadedFile(
    $testAudioPath,
    'test_audio.mp3',
    'audio/mpeg',
    null,
    true
);

// Create a request instance
$request = Illuminate\Http\Request::create(
    '/api/v1/dashboard/chat/voice-message',
    'POST',
    [
        'chat_id' => 'test-chat-' . time(),
        'duration' => 5,
    ],
    [],
    [
        'audio' => $uploadedFile,
    ],
    [
        'HTTP_ACCEPT' => 'application/json',
    ]
);

// Enable AWS in settings
$settings = App\Models\Settings::where('key', 'aws')->first();
if (!$settings) {
    $settings = new App\Models\Settings();
    $settings->key = 'aws';
    $settings->value = true;
    $settings->save();
    echo "Created AWS settings.\n";
} else {
    $settings->value = true;
    $settings->save();
    echo "Updated AWS settings.\n";
}

// Call the ChatController
echo "Calling ChatController to upload voice message...\n";
$controller = new App\Http\Controllers\API\v1\Rest\ChatController();
$response = $controller->uploadVoiceMessage($request);

// Check the response
$content = json_decode($response->getContent(), true);
echo "Response status: " . $response->getStatusCode() . "\n";
echo "Response content: " . json_encode($content, JSON_PRETTY_PRINT) . "\n\n";

if ($response->getStatusCode() === 200 && isset($content['data']['url'])) {
    $url = $content['data']['url'];
    echo "✅ Voice message uploaded successfully.\n";
    echo "URL: $url\n\n";
    
    // Test if the URL is accessible
    echo "Testing if the voice message is accessible...\n";
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    if ($httpCode === 200) {
        echo "✅ Voice message is accessible. HTTP Code: $httpCode\n";
    } else {
        echo "❌ Voice message is not accessible. HTTP Code: $httpCode\n";
    }
    
    // Check if the URL contains the AWS S3 bucket
    if (strpos($url, $bucket) !== false) {
        echo "✅ Voice message is stored in AWS S3 bucket.\n";
    } else {
        echo "❌ Voice message is not stored in AWS S3 bucket.\n";
    }
} else {
    echo "❌ Voice message upload failed.\n";
}

echo "\nTest completed.\n";
