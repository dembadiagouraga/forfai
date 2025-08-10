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

echo "AWS S3 Debug Tool\n";
echo "================\n\n";
echo "Access Key ID: " . substr($accessKeyId, 0, 5) . "..." . substr($accessKeyId, -5) . "\n";
echo "Secret Access Key: " . substr($secretAccessKey, 0, 5) . "..." . substr($secretAccessKey, -5) . "\n";
echo "Region: $region\n";
echo "Bucket: $bucket\n\n";

// Create S3 client with debug mode
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
        ],
        'debug' => true // Enable debug mode
    ]);
    
    echo "S3 client created successfully.\n\n";
    
    // Test bucket existence with detailed error handling
    echo "Testing bucket existence...\n";
    try {
        $exists = $s3Client->doesBucketExist($bucket);
        if ($exists) {
            echo "✅ Bucket '$bucket' exists and is accessible.\n\n";
            
            // Test uploading a file with detailed error handling
            echo "Testing file upload...\n";
            $testKey = 'test-debug-' . time() . '.txt';
            $testContent = 'This is a test file for debugging. Created at ' . date('Y-m-d H:i:s');
            
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
                    
                    // Test deleting the file
                    echo "Testing file deletion...\n";
                    try {
                        $s3Client->deleteObject([
                            'Bucket' => $bucket,
                            'Key' => $testKey,
                        ]);
                        
                        echo "✅ Test file deleted successfully.\n\n";
                    } catch (AwsException $e) {
                        echo "❌ Failed to delete test file.\n";
                        echo "Error: " . $e->getMessage() . "\n";
                        echo "AWS Error Type: " . $e->getAwsErrorType() . "\n";
                        echo "AWS Error Code: " . $e->getAwsErrorCode() . "\n";
                        echo "Request ID: " . $e->getAwsRequestId() . "\n\n";
                    }
                } catch (AwsException $e) {
                    echo "❌ Failed to download test file.\n";
                    echo "Error: " . $e->getMessage() . "\n";
                    echo "AWS Error Type: " . $e->getAwsErrorType() . "\n";
                    echo "AWS Error Code: " . $e->getAwsErrorCode() . "\n";
                    echo "Request ID: " . $e->getAwsRequestId() . "\n\n";
                }
            } catch (AwsException $e) {
                echo "❌ Failed to upload test file.\n";
                echo "Error: " . $e->getMessage() . "\n";
                echo "AWS Error Type: " . $e->getAwsErrorType() . "\n";
                echo "AWS Error Code: " . $e->getAwsErrorCode() . "\n";
                echo "Request ID: " . $e->getAwsRequestId() . "\n\n";
            }
        } else {
            echo "❌ Bucket '$bucket' does not exist or is not accessible.\n\n";
            
            // Try to list all buckets to see what's available
            echo "Attempting to list all buckets...\n";
            try {
                $buckets = $s3Client->listBuckets();
                echo "✅ Successfully listed buckets. You have access to " . count($buckets['Buckets']) . " bucket(s):\n";
                foreach ($buckets['Buckets'] as $b) {
                    echo "- " . $b['Name'] . " (Created: " . $b['CreationDate'] . ")\n";
                }
                echo "\n";
            } catch (AwsException $e) {
                echo "❌ Cannot list buckets.\n";
                echo "Error: " . $e->getMessage() . "\n";
                echo "AWS Error Type: " . $e->getAwsErrorType() . "\n";
                echo "AWS Error Code: " . $e->getAwsErrorCode() . "\n";
                echo "Request ID: " . $e->getAwsRequestId() . "\n\n";
            }
        }
    } catch (AwsException $e) {
        echo "❌ Error checking bucket existence.\n";
        echo "Error: " . $e->getMessage() . "\n";
        echo "AWS Error Type: " . $e->getAwsErrorType() . "\n";
        echo "AWS Error Code: " . $e->getAwsErrorCode() . "\n";
        echo "Request ID: " . $e->getAwsRequestId() . "\n\n";
    }
} catch (Exception $e) {
    echo "❌ Failed to create S3 client.\n";
    echo "Error: " . $e->getMessage() . "\n\n";
}

// Test with different bucket name formats
echo "Testing with different bucket name formats...\n";
$possibleBucketNames = [
    $bucket,
    strtolower($bucket),
    str_replace('-', '_', $bucket),
    str_replace('_', '-', $bucket),
    'forfai-media',
    'forfaimedia',
    'forfai.media',
    'forfai_media',
    'media-forfai',
    'mediaforfai'
];

foreach ($possibleBucketNames as $testBucket) {
    if ($testBucket === $bucket) {
        continue; // Already tested
    }
    
    echo "Testing bucket name: $testBucket\n";
    try {
        $exists = $s3Client->doesBucketExist($testBucket);
        if ($exists) {
            echo "✅ Bucket '$testBucket' exists and is accessible!\n";
            echo "This might be the correct bucket name to use in your .env file.\n\n";
        } else {
            echo "❌ Bucket '$testBucket' does not exist or is not accessible.\n\n";
        }
    } catch (AwsException $e) {
        echo "❌ Error checking bucket '$testBucket'.\n";
        echo "Error: " . $e->getMessage() . "\n\n";
    }
}

// Test with different regions
echo "Testing with different regions...\n";
$possibleRegions = [
    $region,
    'us-east-1',
    'us-east-2',
    'us-west-1',
    'us-west-2',
    'eu-west-1',
    'eu-west-2',
    'eu-west-3',
    'eu-central-1',
    'eu-north-1',
    'ap-south-1',
    'ap-northeast-1',
    'ap-northeast-2',
    'ap-northeast-3',
    'ap-southeast-1',
    'ap-southeast-2',
    'sa-east-1',
    'ca-central-1',
    'cn-north-1',
    'cn-northwest-1'
];

foreach ($possibleRegions as $testRegion) {
    if ($testRegion === $region) {
        continue; // Already tested
    }
    
    echo "Testing region: $testRegion\n";
    try {
        $testS3Client = new S3Client([
            'version' => 'latest',
            'region' => $testRegion,
            'credentials' => [
                'key' => $accessKeyId,
                'secret' => $secretAccessKey,
            ],
            'http' => [
                'verify' => false
            ]
        ]);
        
        $exists = $testS3Client->doesBucketExist($bucket);
        if ($exists) {
            echo "✅ Bucket '$bucket' exists in region '$testRegion'!\n";
            echo "This might be the correct region to use in your .env file.\n\n";
        } else {
            echo "❌ Bucket '$bucket' does not exist in region '$testRegion'.\n\n";
        }
    } catch (AwsException $e) {
        echo "❌ Error checking bucket in region '$testRegion'.\n";
        echo "Error: " . $e->getMessage() . "\n\n";
    }
}

echo "Debug completed.\n";
