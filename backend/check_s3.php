<?php
// Simple script to check S3 bucket

// Load AWS SDK
require __DIR__ . '/vendor/autoload.php';

use Aws\S3\S3Client;

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

// Check if bucket exists
try {
    $result = $s3Client->headBucket([
        'Bucket' => $bucket
    ]);
    echo "Bucket '$bucket' exists\n";
} catch (Exception $e) {
    echo "Bucket check failed: " . $e->getMessage() . "\n";
    exit(1);
}

// List objects in bucket
try {
    $result = $s3Client->listObjects([
        'Bucket' => $bucket,
        'MaxKeys' => 5
    ]);
    
    echo "\nObjects in bucket:\n";
    foreach ($result['Contents'] as $object) {
        echo "- " . $object['Key'] . " (" . $object['Size'] . " bytes)\n";
    }
} catch (Exception $e) {
    echo "Failed to list objects: " . $e->getMessage() . "\n";
}

echo "\nCheck completed\n";
