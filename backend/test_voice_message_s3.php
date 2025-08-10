<?php
// Test script for voice message upload and access

// Load AWS SDK
require 'vendor/autoload.php';

use Aws\S3\S3Client;
use GuzzleHttp\Client as HttpClient;

echo "Voice Message S3 Test\n";
echo "===================\n\n";

// Load environment variables from .env file
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

// Get AWS credentials from .env
$accessKeyId = $_ENV['AWS_ACCESS_KEY_ID'];
$secretAccessKey = $_ENV['AWS_SECRET_ACCESS_KEY'];
$region = $_ENV['AWS_DEFAULT_REGION'];
$bucket = $_ENV['AWS_BUCKET'];

echo "AWS_ACCESS_KEY_ID: " . substr($accessKeyId, 0, 5) . "..." . substr($accessKeyId, -5) . "\n";
echo "AWS_SECRET_ACCESS_KEY: " . substr($secretAccessKey, 0, 3) . "..." . substr($secretAccessKey, -3) . "\n";
echo "AWS_DEFAULT_REGION: " . $region . "\n";
echo "AWS_BUCKET: " . $bucket . "\n\n";

// Create S3 client
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
    echo "S3 client created successfully\n\n";
} catch (Exception $e) {
    echo "Failed to create S3 client: " . $e->getMessage() . "\n";
    exit(1);
}

// Create a test audio file
$testAudioPath = __DIR__ . '/storage/app/public/test_audio.mp3';
$testAudioContent = hex2bin(
    '4944330300000000000a' . // ID3v2 header
    'fffb9000' .             // MP3 frame header
    str_repeat('00', 10000)  // Some minimal MP3 data
);
file_put_contents($testAudioPath, $testAudioContent);
echo "Test audio file created at: $testAudioPath\n\n";

// Create a unique chat ID and filename
$chatId = 'test-chat-' . time();
$filename = time() . '_' . uniqid() . '.mp3';
$s3Path = "media/voice_messages/{$chatId}/{$filename}";

echo "Chat ID: $chatId\n";
echo "Filename: $filename\n";
echo "S3 Path: $s3Path\n\n";

// Upload test file to S3
try {
    $result = $s3Client->putObject([
        'Bucket' => $bucket,
        'Key' => $s3Path,
        'Body' => file_get_contents($testAudioPath),
        'ContentType' => 'audio/mpeg',
        'CacheControl' => 'max-age=86400', // 24 hours caching
        // No ACL parameter
    ]);
    
    echo "Voice message uploaded successfully to S3\n";
    echo "URL: " . $result['ObjectURL'] . "\n\n";
    
    $s3Url = $result['ObjectURL'];
} catch (Exception $e) {
    echo "Failed to upload voice message to S3: " . $e->getMessage() . "\n";
    exit(1);
}

// Test direct access to the file
try {
    $httpClient = new HttpClient(['verify' => false]);
    $response = $httpClient->get($s3Url, ['timeout' => 5]);
    
    if ($response->getStatusCode() == 200) {
        echo "Direct URL is accessible\n";
        echo "Content-Type: " . $response->getHeaderLine('Content-Type') . "\n";
        echo "Content-Length: " . $response->getHeaderLine('Content-Length') . "\n\n";
    } else {
        echo "Direct URL returned status code: " . $response->getStatusCode() . "\n\n";
    }
} catch (Exception $e) {
    echo "Direct URL is not accessible: " . $e->getMessage() . "\n\n";
}

// Create a proxy URL
$proxyUrl = "http://192.168.0.110:8000/api/proxy/voice-message/{$chatId}/{$filename}";
echo "Proxy URL: $proxyUrl\n";
echo "To test the proxy URL, make sure the Laravel server is running and visit the URL in your browser.\n\n";

// Save the test information to a file for later reference
$testInfoPath = __DIR__ . '/storage/app/public/test_voice_info.txt';
$testInfo = "Chat ID: $chatId\n";
$testInfo .= "Filename: $filename\n";
$testInfo .= "S3 URL: $s3Url\n";
$testInfo .= "Proxy URL: $proxyUrl\n";
file_put_contents($testInfoPath, $testInfo);
echo "Test information saved to: $testInfoPath\n\n";

echo "Test completed\n";
