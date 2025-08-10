<?php
require 'vendor/autoload.php';

use Aws\S3\S3Client;
use Aws\Exception\AwsException;

// Load environment variables from .env file
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

echo "AWS S3 Integration Test\n";
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
    
    // Test bucket existence
    echo "Testing bucket existence...\n";
    try {
        $exists = $s3Client->doesBucketExist($bucket);
        if ($exists) {
            echo "✅ Bucket '$bucket' exists and is accessible.\n\n";
            
            // Test 1: Voice Note Upload
            echo "Test 1: Voice Note Upload\n";
            echo "------------------------\n";
            $voiceNoteKey = 'media/voice-notes/test_' . time() . '.mp3';
            
            try {
                $result = $s3Client->putObject([
                    'Bucket' => $bucket,
                    'Key' => $voiceNoteKey,
                    'Body' => file_get_contents($testAudioPath),
                    // No ACL parameter
                ]);
                
                $voiceNoteUrl = $result['ObjectURL'];
                echo "✅ Voice note uploaded successfully.\n";
                echo "URL: $voiceNoteUrl\n\n";
                
                // Test if the file is publicly accessible
                echo "Testing if the voice note is publicly accessible...\n";
                $ch = curl_init($voiceNoteUrl);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                $response = curl_exec($ch);
                $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
                curl_close($ch);
                
                if ($httpCode === 200) {
                    echo "✅ Voice note is publicly accessible. HTTP Code: $httpCode\n\n";
                } else {
                    echo "❌ Voice note is not publicly accessible. HTTP Code: $httpCode\n\n";
                }
                
                // Test deleting the voice note
                echo "Cleaning up voice note...\n";
                $s3Client->deleteObject([
                    'Bucket' => $bucket,
                    'Key' => $voiceNoteKey,
                ]);
                echo "✅ Voice note deleted.\n\n";
            } catch (AwsException $e) {
                echo "❌ Voice note upload failed: " . $e->getMessage() . "\n\n";
            }
            
            // Test 2: Voice Message Upload
            echo "Test 2: Voice Message Upload\n";
            echo "---------------------------\n";
            $chatId = 'test-chat-' . time();
            $voiceMessageKey = "media/voice_messages/{$chatId}/test_" . time() . '.mp3';
            
            try {
                $result = $s3Client->putObject([
                    'Bucket' => $bucket,
                    'Key' => $voiceMessageKey,
                    'Body' => file_get_contents($testAudioPath),
                    // No ACL parameter
                ]);
                
                $voiceMessageUrl = $result['ObjectURL'];
                echo "✅ Voice message uploaded successfully.\n";
                echo "URL: $voiceMessageUrl\n\n";
                
                // Test if the file is publicly accessible
                echo "Testing if the voice message is publicly accessible...\n";
                $ch = curl_init($voiceMessageUrl);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                $response = curl_exec($ch);
                $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
                curl_close($ch);
                
                if ($httpCode === 200) {
                    echo "✅ Voice message is publicly accessible. HTTP Code: $httpCode\n\n";
                } else {
                    echo "❌ Voice message is not publicly accessible. HTTP Code: $httpCode\n\n";
                }
                
                // Test deleting the voice message
                echo "Cleaning up voice message...\n";
                $s3Client->deleteObject([
                    'Bucket' => $bucket,
                    'Key' => $voiceMessageKey,
                ]);
                echo "✅ Voice message deleted.\n\n";
            } catch (AwsException $e) {
                echo "❌ Voice message upload failed: " . $e->getMessage() . "\n\n";
            }
        } else {
            echo "❌ Bucket '$bucket' does not exist or is not accessible.\n\n";
        }
    } catch (AwsException $e) {
        echo "❌ Error checking bucket: " . $e->getMessage() . "\n\n";
    }
} catch (Exception $e) {
    echo "❌ Failed to create S3 client: " . $e->getMessage() . "\n\n";
}

echo "Test completed.\n";
