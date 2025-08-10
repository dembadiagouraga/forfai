<?php
// This script tests the complete voice message flow: upload, storage, and access

// Load the Laravel application
require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Http\Kernel::class);

echo "Voice Message Full Flow Test\n";
echo "==========================\n\n";

// Step 1: Create a test audio file
echo "STEP 1: Creating test audio file...\n";

// Create a simple MP3 file (this is just a placeholder, not a real MP3)
$testAudioPath = __DIR__ . '/storage/app/public/test_audio.mp3';
$testAudioContent = hex2bin(
    '4944330300000000000a' . // ID3v2 header
    'fffb9000' .             // MP3 frame header
    str_repeat('00', 10000)  // Some minimal MP3 data
);
file_put_contents($testAudioPath, $testAudioContent);
echo "✅ Test audio file created at: $testAudioPath\n\n";

// Step 2: Skip database settings and use environment variables directly
echo "STEP 2: Using AWS settings from environment variables...\n";
echo "AWS_ACCESS_KEY_ID: " . substr(env('AWS_ACCESS_KEY_ID'), 0, 5) . "..." . substr(env('AWS_ACCESS_KEY_ID'), -5) . "\n";
echo "AWS_SECRET_ACCESS_KEY: " . substr(env('AWS_SECRET_ACCESS_KEY'), 0, 3) . "..." . substr(env('AWS_SECRET_ACCESS_KEY'), -3) . "\n";
echo "AWS_DEFAULT_REGION: " . env('AWS_DEFAULT_REGION') . "\n";
echo "AWS_BUCKET: " . env('AWS_BUCKET') . "\n\n";

// Step 3: Upload voice message
echo "STEP 3: Uploading voice message...\n";

// Create a unique chat ID for testing
$chatId = 'test-chat-' . time();
echo "Using chat ID: $chatId\n";

// Create an uploaded file object
$uploadedFile = new Illuminate\Http\UploadedFile(
    $testAudioPath,
    'test_audio.mp3',
    'audio/mpeg',
    null,
    true
);

// Create a request instance
$request = Illuminate\Http\Request::create(
    '/api/dashboard/chat/voice-message',
    'POST',
    [
        'chat_id' => $chatId,
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

// Call the ChatController
$controller = new App\Http\Controllers\API\v1\Rest\ChatController();
$response = $controller->uploadVoiceMessage($request);

// Check the response
$content = json_decode($response->getContent(), true);
echo "Response status: " . $response->getStatusCode() . "\n";
echo "Response content: " . json_encode($content, JSON_PRETTY_PRINT) . "\n\n";

// Extract the URL and filename
if (!isset($content['data']['url'])) {
    echo "❌ No URL returned in response\n";
    exit(1);
}

$url = $content['data']['url'];
echo "Voice message URL: $url\n";

// Extract filename from URL
$filename = basename(parse_url($url, PHP_URL_PATH));
echo "Filename: $filename\n\n";

// Step 4: Test direct access to the file
echo "STEP 4: Testing direct access to the file...\n";

try {
    $client = new GuzzleHttp\Client(['verify' => false]);
    $response = $client->get($url, ['timeout' => 5]);

    if ($response->getStatusCode() == 200) {
        echo "✅ Direct URL is accessible\n";
        echo "Content-Type: " . $response->getHeaderLine('Content-Type') . "\n";
        echo "Content-Length: " . $response->getHeaderLine('Content-Length') . "\n\n";
    } else {
        echo "❌ Direct URL returned status code: " . $response->getStatusCode() . "\n\n";
    }
} catch (Exception $e) {
    echo "❌ Direct URL is not accessible: " . $e->getMessage() . "\n\n";
}

// Step 5: Test proxy access to the file
echo "STEP 5: Testing proxy access to the file...\n";

// Construct proxy URL
$proxyUrl = rtrim(config('app.img_host'), '/') . "/api/proxy/voice-message/{$chatId}/{$filename}";
echo "Proxy URL: $proxyUrl\n";

try {
    $client = new GuzzleHttp\Client(['verify' => false]);
    $response = $client->get($proxyUrl, ['timeout' => 5]);

    if ($response->getStatusCode() == 200) {
        echo "✅ Proxy URL is accessible\n";
        echo "Content-Type: " . $response->getHeaderLine('Content-Type') . "\n";
        echo "Content-Length: " . $response->getHeaderLine('Content-Length') . "\n\n";
    } else {
        echo "❌ Proxy URL returned status code: " . $response->getStatusCode() . "\n\n";
    }
} catch (Exception $e) {
    echo "❌ Proxy URL is not accessible: " . $e->getMessage() . "\n\n";
}

// Step 6: Check local storage
echo "STEP 6: Checking local storage...\n";

// Check if file exists in local storage
$localPath = "voice_messages/{$chatId}/{$filename}";
$fullLocalPath = storage_path("app/public/{$localPath}");
echo "Local path: $fullLocalPath\n";

if (file_exists($fullLocalPath)) {
    echo "✅ File exists in local storage\n";
    echo "File size: " . filesize($fullLocalPath) . " bytes\n\n";
} else {
    echo "❌ File does not exist in local storage\n\n";
}

// Step 7: Check S3 storage
echo "STEP 7: Checking S3 storage...\n";

// Create S3 client
$s3Client = new Aws\S3\S3Client([
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

// Check if file exists in S3
$s3Path = "media/voice_messages/{$chatId}/{$filename}";
echo "S3 path: $s3Path\n";

try {
    $result = $s3Client->headObject([
        'Bucket' => env('AWS_BUCKET'),
        'Key' => $s3Path,
    ]);

    echo "✅ File exists in S3\n";
    echo "Content-Type: " . $result['ContentType'] . "\n";
    echo "Content-Length: " . $result['ContentLength'] . " bytes\n\n";
} catch (Exception $e) {
    echo "❌ File does not exist in S3: " . $e->getMessage() . "\n\n";
}

echo "Test completed\n";
