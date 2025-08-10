<?php
require 'vendor/autoload.php';

use Aws\S3\S3Client;
use Aws\Exception\AwsException;

// Load environment variables from .env file
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

// Get AWS credentials from .env
$accessKeyId = $_ENV['AWS_ACCESS_KEY_ID'];
$secretAccessKey = $_ENV['AWS_SECRET_ACCESS_KEY'];
$region = $_ENV['AWS_DEFAULT_REGION'];
$bucket = $_ENV['AWS_BUCKET'];

echo "AWS S3 Bucket Access Test\n";
echo "========================\n\n";
echo "Access Key ID: " . substr($accessKeyId, 0, 5) . "..." . substr($accessKeyId, -5) . "\n";
echo "Secret Access Key: " . substr($secretAccessKey, 0, 5) . "..." . substr($secretAccessKey, -5) . "\n";
echo "Region: $region\n";
echo "Bucket: $bucket\n\n";

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
    
    // Check if the bucket exists
    echo "Checking if bucket '$bucket' exists...\n";
    $bucketExists = $s3Client->doesBucketExist($bucket);
    
    if ($bucketExists) {
        echo "✅ Bucket '$bucket' exists and is accessible.\n\n";
        
        // Test uploading a file
        echo "Testing file upload to bucket...\n";
        $testKey = 'test-files/test-' . time() . '.txt';
        $testContent = 'This is a test file to verify AWS S3 bucket access. Created at ' . date('Y-m-d H:i:s');
        
        try {
            $result = $s3Client->putObject([
                'Bucket' => $bucket,
                'Key' => $testKey,
                'Body' => $testContent,
                'ACL' => 'public-read',
            ]);
            
            $url = $result['ObjectURL'];
            echo "✅ Test file uploaded successfully.\n";
            echo "URL: $url\n\n";
            
            // Test downloading the file
            echo "Testing file download...\n";
            try {
                $result = $s3Client->getObject([
                    'Bucket' => $bucket,
                    'Key' => $testKey,
                ]);
                
                $content = $result['Body']->getContents();
                if ($content === $testContent) {
                    echo "✅ Test file downloaded successfully. Content matches.\n\n";
                } else {
                    echo "❌ Test file downloaded, but content doesn't match.\n";
                    echo "Expected: $testContent\n";
                    echo "Actual: $content\n\n";
                }
            } catch (AwsException $e) {
                echo "❌ Failed to download test file: " . $e->getMessage() . "\n\n";
            }
            
            // Test public access
            echo "Testing public access to the file...\n";
            $ch = curl_init($url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            $response = curl_exec($ch);
            $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
            curl_close($ch);
            
            if ($httpCode === 200 && $response === $testContent) {
                echo "✅ File is publicly accessible. HTTP Code: $httpCode\n\n";
            } else {
                echo "❌ File is not publicly accessible. HTTP Code: $httpCode\n";
                echo "Response: $response\n\n";
            }
            
            // Test deleting the file
            echo "Testing file deletion...\n";
            try {
                $s3Client->deleteObject([
                    'Bucket' => $bucket,
                    'Key' => $testKey,
                ]);
                
                echo "✅ Test file deleted successfully.\n\n";
            } catch (AwsException $e) {
                echo "❌ Failed to delete test file: " . $e->getMessage() . "\n\n";
            }
        } catch (AwsException $e) {
            echo "❌ Failed to upload test file: " . $e->getMessage() . "\n\n";
        }
        
        // Test voice note upload (simulating the actual app usage)
        echo "Testing voice note upload (simulating app usage)...\n";
        $voiceNoteKey = 'media/voice-notes/' . uniqid() . '.mp3';
        $voiceNoteContent = str_repeat('0', 1024); // 1KB of zeros
        
        try {
            $result = $s3Client->putObject([
                'Bucket' => $bucket,
                'Key' => $voiceNoteKey,
                'Body' => $voiceNoteContent,
                'ACL' => 'public-read',
                'ContentType' => 'audio/mpeg',
            ]);
            
            $voiceNoteUrl = $result['ObjectURL'];
            echo "✅ Voice note uploaded successfully.\n";
            echo "URL: $voiceNoteUrl\n\n";
            
            // Test deleting the voice note
            echo "Testing voice note deletion...\n";
            try {
                $s3Client->deleteObject([
                    'Bucket' => $bucket,
                    'Key' => $voiceNoteKey,
                ]);
                
                echo "✅ Voice note deleted successfully.\n\n";
            } catch (AwsException $e) {
                echo "❌ Failed to delete voice note: " . $e->getMessage() . "\n\n";
            }
        } catch (AwsException $e) {
            echo "❌ Failed to upload voice note: " . $e->getMessage() . "\n\n";
        }
        
        // Test voice message upload (simulating the actual app usage)
        echo "Testing voice message upload (simulating app usage)...\n";
        $chatId = 'test-chat-' . time();
        $voiceMessageKey = 'media/voice_messages/' . $chatId . '/' . uniqid() . '.mp3';
        $voiceMessageContent = str_repeat('1', 1024); // 1KB of ones
        
        try {
            $result = $s3Client->putObject([
                'Bucket' => $bucket,
                'Key' => $voiceMessageKey,
                'Body' => $voiceMessageContent,
                'ACL' => 'public-read',
                'ContentType' => 'audio/mpeg',
            ]);
            
            $voiceMessageUrl = $result['ObjectURL'];
            echo "✅ Voice message uploaded successfully.\n";
            echo "URL: $voiceMessageUrl\n\n";
            
            // Test deleting the voice message
            echo "Testing voice message deletion...\n";
            try {
                $s3Client->deleteObject([
                    'Bucket' => $bucket,
                    'Key' => $voiceMessageKey,
                ]);
                
                echo "✅ Voice message deleted successfully.\n\n";
            } catch (AwsException $e) {
                echo "❌ Failed to delete voice message: " . $e->getMessage() . "\n\n";
            }
        } catch (AwsException $e) {
            echo "❌ Failed to upload voice message: " . $e->getMessage() . "\n\n";
        }
    } else {
        echo "❌ Bucket '$bucket' does not exist or is not accessible.\n";
        echo "Please check the following:\n";
        echo "1. The bucket name is correct in your .env file\n";
        echo "2. The bucket has been created in the AWS S3 console\n";
        echo "3. Your IAM user has permission to access the bucket\n";
    }
} catch (AwsException $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}

echo "Test completed.\n";
