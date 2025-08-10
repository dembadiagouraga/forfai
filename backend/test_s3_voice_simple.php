<?php
// This script tests S3 voice message upload and access without Laravel dependencies

// Load AWS SDK
require __DIR__ . '/vendor/autoload.php';

use Aws\S3\S3Client;
use GuzzleHttp\Client as HttpClient;

echo "S3 Voice Message Upload Test\n";
echo "==========================\n\n";

// Load environment variables from .env file
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

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

// Step 2: Get AWS credentials from .env
echo "STEP 2: Getting AWS credentials...\n";
$accessKeyId = $_ENV['AWS_ACCESS_KEY_ID'];
$secretAccessKey = $_ENV['AWS_SECRET_ACCESS_KEY'];
$region = $_ENV['AWS_DEFAULT_REGION'];
$bucket = $_ENV['AWS_BUCKET'];

echo "AWS_ACCESS_KEY_ID: " . substr($accessKeyId, 0, 5) . "..." . substr($accessKeyId, -5) . "\n";
echo "AWS_SECRET_ACCESS_KEY: " . substr($secretAccessKey, 0, 3) . "..." . substr($secretAccessKey, -3) . "\n";
echo "AWS_DEFAULT_REGION: " . $region . "\n";
echo "AWS_BUCKET: " . $bucket . "\n\n";

// Step 3: Create S3 client
echo "STEP 3: Creating S3 client...\n";
try {
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
    echo "✅ S3 client created successfully\n\n";
} catch (Exception $e) {
    echo "❌ Failed to create S3 client: " . $e->getMessage() . "\n";
    exit(1);
}

// Step 4: Upload test file to S3
echo "STEP 4: Uploading test file to S3...\n";

// Create a unique chat ID and filename
$chatId = 'test-chat-' . time();
$filename = time() . '_' . uniqid() . '.mp3';
$s3Path = "media/voice_messages/{$chatId}/{$filename}";

echo "Chat ID: $chatId\n";
echo "Filename: $filename\n";
echo "S3 Path: $s3Path\n";

try {
    // Upload to S3 without ACL parameter
    $result = $s3Client->putObject([
        'Bucket' => $bucket,
        'Key' => $s3Path,
        'Body' => file_get_contents($testAudioPath),
        'ContentType' => 'audio/mpeg',
        'CacheControl' => 'max-age=86400', // 24 hours caching
        // No ACL parameter
    ]);
    
    echo "✅ File uploaded successfully to S3\n";
    echo "URL: " . $result['ObjectURL'] . "\n\n";
    
    $s3Url = $result['ObjectURL'];
} catch (Exception $e) {
    echo "❌ Failed to upload file to S3: " . $e->getMessage() . "\n";
    exit(1);
}

// Step 5: Test direct access to the file
echo "STEP 5: Testing direct access to the file...\n";

try {
    $httpClient = new HttpClient(['verify' => false]);
    $response = $httpClient->get($s3Url, ['timeout' => 5]);
    
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

// Step 6: Create a proxy URL
echo "STEP 6: Creating a proxy URL...\n";

// Construct proxy URL (using localhost for testing)
$proxyUrl = "http://192.168.0.110:8000/api/proxy/voice-message/{$chatId}/{$filename}";
echo "Proxy URL: $proxyUrl\n";

echo "\nTo test the proxy URL, make sure the Laravel server is running and visit:\n";
echo $proxyUrl . "\n\n";

// Step 7: Clean up
echo "STEP 7: Cleaning up...\n";

try {
    // Delete the test file from S3
    $s3Client->deleteObject([
        'Bucket' => $bucket,
        'Key' => $s3Path,
    ]);
    echo "✅ Test file deleted from S3\n\n";
} catch (Exception $e) {
    echo "❌ Failed to delete test file from S3: " . $e->getMessage() . "\n\n";
}

echo "Test completed\n";
