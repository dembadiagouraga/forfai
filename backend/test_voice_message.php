<?php
require 'vendor/autoload.php';

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;

// Load environment variables from .env file
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

// Get AWS credentials from .env
$accessKeyId = $_ENV['AWS_ACCESS_KEY_ID'];
$secretAccessKey = $_ENV['AWS_SECRET_ACCESS_KEY'];
$region = $_ENV['AWS_DEFAULT_REGION'];
$bucket = $_ENV['AWS_BUCKET'];

echo "Testing voice message upload...\n";
echo "AWS Bucket: $bucket\n";
echo "AWS Region: $region\n\n";

// Create a test audio file
$testAudioPath = __DIR__ . '/storage/app/public/voice_messages/test_audio.mp3';
$testAudioContent = file_get_contents(__DIR__ . '/public/assets/audio/test_audio.mp3');

if (!$testAudioContent) {
    // If test audio file doesn't exist, create a dummy one
    echo "Creating dummy test audio file...\n";
    $testAudioContent = str_repeat('0', 1024); // 1KB of zeros
    file_put_contents($testAudioPath, $testAudioContent);
} else {
    echo "Using existing test audio file...\n";
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

// Test uploading to S3
try {
    echo "Attempting to upload to AWS S3...\n";

    // Create S3 client
    $s3 = new Aws\S3\S3Client([
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

    // Check if bucket exists
    $bucketExists = $s3->doesBucketExist($bucket);

    if ($bucketExists) {
        echo "Bucket '$bucket' exists.\n";

        // Upload test file
        $chatId = 'test_chat_' . time();
        $fileName = 'test_audio_' . time() . '.mp3';
        $path = "voice_messages/{$chatId}/{$fileName}";

        try {
            $result = $s3->putObject([
                'Bucket' => $bucket,
                'Key' => $path,
                'Body' => $testAudioContent,
                // No ACL parameter
            ]);

            $url = $result['ObjectURL'];
            echo "✅ Test file uploaded successfully to S3.\n";
            echo "URL: $url\n";

            // Delete the test file
            $s3->deleteObject([
                'Bucket' => $bucket,
                'Key' => $path,
            ]);

            echo "✅ Test file deleted from S3.\n";
        } catch (Exception $e) {
            echo "❌ Failed to upload to S3: " . $e->getMessage() . "\n";
            echo "Trying local storage fallback...\n";

            // Test local storage fallback
            $localPath = "public/voice_messages/{$chatId}/{$fileName}";
            $fullPath = __DIR__ . '/storage/app/' . $localPath;

            // Create directory if it doesn't exist
            if (!is_dir(dirname($fullPath))) {
                mkdir(dirname($fullPath), 0777, true);
            }

            // Save file
            file_put_contents($fullPath, $testAudioContent);

            // Generate URL
            $url = rtrim($_ENV['APP_URL'], '/') . '/storage/voice_messages/' . $chatId . '/' . $fileName;

            echo "✅ Test file saved to local storage.\n";
            echo "URL: $url\n";
        }
    } else {
        echo "❌ Bucket '$bucket' does not exist.\n";
        echo "Trying local storage fallback...\n";

        // Test local storage fallback
        $chatId = 'test_chat_' . time();
        $fileName = 'test_audio_' . time() . '.mp3';
        $localPath = "public/voice_messages/{$chatId}/{$fileName}";
        $fullPath = __DIR__ . '/storage/app/' . $localPath;

        // Create directory if it doesn't exist
        if (!is_dir(dirname($fullPath))) {
            mkdir(dirname($fullPath), 0777, true);
        }

        // Save file
        file_put_contents($fullPath, $testAudioContent);

        // Generate URL
        $url = rtrim($_ENV['APP_URL'], '/') . '/storage/voice_messages/' . $chatId . '/' . $fileName;

        echo "✅ Test file saved to local storage.\n";
        echo "URL: $url\n";
    }
} catch (Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}
