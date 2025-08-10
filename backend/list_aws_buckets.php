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

echo "AWS S3 Bucket List\n";
echo "=================\n\n";
echo "Access Key ID: " . substr($accessKeyId, 0, 5) . "..." . substr($accessKeyId, -5) . "\n";
echo "Secret Access Key: " . substr($secretAccessKey, 0, 5) . "..." . substr($secretAccessKey, -5) . "\n";
echo "Region: $region\n\n";

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
    
    // Try to list buckets
    echo "Attempting to list buckets...\n";
    try {
        $buckets = $s3Client->listBuckets();
        echo "✅ Successfully listed buckets. You have access to " . count($buckets['Buckets']) . " bucket(s):\n";
        foreach ($buckets['Buckets'] as $bucket) {
            echo "- " . $bucket['Name'] . " (Created: " . $bucket['CreationDate'] . ")\n";
        }
        echo "\n";
    } catch (AwsException $e) {
        echo "❌ Cannot list buckets: " . $e->getMessage() . "\n";
        echo "This is normal if your IAM user doesn't have s3:ListAllMyBuckets permission.\n\n";
    }
    
    // Try to check specific buckets
    $possibleBuckets = [
        'forfai-media',
        'forfai-voice-messages',
        'forfai-voice-notes',
        'forfai',
        'forfai-storage',
        'forfai-app',
        'forfai-app-media'
    ];
    
    echo "Checking specific bucket names...\n";
    foreach ($possibleBuckets as $bucketName) {
        echo "Checking if bucket '$bucketName' exists...\n";
        try {
            $exists = $s3Client->doesBucketExist($bucketName);
            if ($exists) {
                echo "✅ Bucket '$bucketName' exists and is accessible.\n";
                
                // Try to list objects in the bucket
                try {
                    $objects = $s3Client->listObjects([
                        'Bucket' => $bucketName,
                        'MaxKeys' => 5
                    ]);
                    
                    if (isset($objects['Contents']) && count($objects['Contents']) > 0) {
                        echo "  ✅ Successfully listed objects. The bucket contains " . count($objects['Contents']) . " object(s).\n";
                    } else {
                        echo "  ✅ Successfully listed objects. The bucket is empty.\n";
                    }
                } catch (AwsException $e) {
                    echo "  ❌ Cannot list objects in the bucket: " . $e->getMessage() . "\n";
                }
            } else {
                echo "❌ Bucket '$bucketName' does not exist or is not accessible.\n";
            }
        } catch (AwsException $e) {
            echo "❌ Error checking bucket '$bucketName': " . $e->getMessage() . "\n";
        }
    }
} catch (AwsException $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}

echo "\nTest completed.\n";
