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

echo "Simple AWS S3 Test (No ACL)\n";
echo "==========================\n\n";
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
    
    echo "S3 client created successfully.\n\n";
    
    // Test bucket existence
    echo "Testing bucket existence...\n";
    try {
        $exists = $s3Client->doesBucketExist($bucket);
        if ($exists) {
            echo "✅ Bucket '$bucket' exists and is accessible.\n\n";
            
            // Test uploading a file without ACL
            echo "Testing file upload (without ACL)...\n";
            $testKey = 'test-simple-' . time() . '.txt';
            $testContent = 'This is a test file. Created at ' . date('Y-m-d H:i:s');
            
            try {
                $result = $s3Client->putObject([
                    'Bucket' => $bucket,
                    'Key' => $testKey,
                    'Body' => $testContent,
                    // No ACL parameter
                ]);
                
                $url = $result['ObjectURL'];
                echo "✅ Test file uploaded successfully.\n";
                echo "URL: $url\n\n";
                
                // Test if the file is publicly accessible
                echo "Testing if the file is publicly accessible...\n";
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
