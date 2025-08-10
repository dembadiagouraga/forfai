<?php
require 'vendor/autoload.php';

use Aws\S3\S3Client;
use Aws\Exception\AwsException;

// Load environment variables from .env file
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

echo "Voice Note Upload Test\n";
echo "=====================\n\n";

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
    
    // Test uploading to AWS S3
    echo "Attempting to upload to AWS S3...\n";
    $testKey = 'media/voice-notes/test_' . time() . '.mp3';
    
    try {
        $result = $s3Client->putObject([
            'Bucket' => $bucket,
            'Key' => $testKey,
            'Body' => file_get_contents($testAudioPath),
            // No ACL parameter
        ]);
        
        $url = $result['ObjectURL'];
        echo "✅ Test file uploaded successfully to AWS S3.\n";
        echo "URL: $url\n\n";
        
        // Test if the file is publicly accessible
        echo "Testing if the file is publicly accessible...\n";
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        
        if ($httpCode === 200) {
            echo "✅ File is publicly accessible. HTTP Code: $httpCode\n\n";
        } else {
            echo "❌ File is not publicly accessible. HTTP Code: $httpCode\n\n";
        }
        
        // Test deleting the file
        echo "Cleaning up test file...\n";
        $s3Client->deleteObject([
            'Bucket' => $bucket,
            'Key' => $testKey,
        ]);
        echo "✅ Test file deleted from AWS S3.\n\n";
    } catch (AwsException $e) {
        echo "❌ AWS S3 upload failed: " . $e->getMessage() . "\n";
        echo "Trying local storage fallback...\n";
        
        // Test local storage fallback
        $localPath = 'public/voice-notes/test_' . time() . '.mp3';
        $fullPath = __DIR__ . '/' . str_replace('public/', 'public/storage/', $localPath);
        
        // Ensure directory exists
        if (!is_dir(dirname($fullPath))) {
            mkdir(dirname($fullPath), 0777, true);
        }
        
        // Save file locally
        file_put_contents($fullPath, file_get_contents($testAudioPath));
        
        // Generate URL
        $url = rtrim($_ENV['IMG_HOST'], '/') . '/storage/voice-notes/test_' . time() . '.mp3';
        
        echo "✅ Test file saved to local storage.\n";
        echo "URL: $url\n";
    }
} catch (Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}

echo "\nTest completed.\n";
