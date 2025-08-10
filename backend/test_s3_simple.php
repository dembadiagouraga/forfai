<?php
// Simple script to test S3 upload and access

// Load AWS SDK
require 'vendor/autoload.php';

use Aws\S3\S3Client;
use GuzzleHttp\Client as HttpClient;

echo "S3 Simple Test\n";
echo "=============\n\n";

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

// Create a test file
$testContent = "This is a test file - " . date('Y-m-d H:i:s');
$testKey = "test/test_file_" . time() . ".txt";

// Upload test file to S3
try {
    $result = $s3Client->putObject([
        'Bucket' => $bucket,
        'Key' => $testKey,
        'Body' => $testContent,
        'ContentType' => 'text/plain',
        // No ACL parameter
    ]);
    
    echo "File uploaded successfully to S3\n";
    echo "URL: " . $result['ObjectURL'] . "\n\n";
    
    $s3Url = $result['ObjectURL'];
} catch (Exception $e) {
    echo "Failed to upload file to S3: " . $e->getMessage() . "\n";
    exit(1);
}

// Test direct access to the file
try {
    $httpClient = new HttpClient(['verify' => false]);
    $response = $httpClient->get($s3Url, ['timeout' => 5]);
    
    if ($response->getStatusCode() == 200) {
        echo "Direct URL is accessible\n";
        echo "Content: " . $response->getBody() . "\n\n";
    } else {
        echo "Direct URL returned status code: " . $response->getStatusCode() . "\n\n";
    }
} catch (Exception $e) {
    echo "Direct URL is not accessible: " . $e->getMessage() . "\n\n";
}

// Clean up
try {
    $s3Client->deleteObject([
        'Bucket' => $bucket,
        'Key' => $testKey,
    ]);
    echo "Test file deleted from S3\n\n";
} catch (Exception $e) {
    echo "Failed to delete test file from S3: " . $e->getMessage() . "\n\n";
}

echo "Test completed\n";
