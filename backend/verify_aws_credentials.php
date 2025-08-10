<?php
require 'vendor/autoload.php';

use Aws\S3\S3Client;
use Aws\Sts\StsClient;
use Aws\Exception\AwsException;

// Load environment variables from .env file
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

// Get AWS credentials from .env
$accessKeyId = $_ENV['AWS_ACCESS_KEY_ID'];
$secretAccessKey = $_ENV['AWS_SECRET_ACCESS_KEY'];
$region = $_ENV['AWS_DEFAULT_REGION'];
$bucket = $_ENV['AWS_BUCKET'];

echo "AWS Credentials Verification Tool\n";
echo "================================\n\n";
echo "Access Key ID: " . substr($accessKeyId, 0, 5) . "..." . substr($accessKeyId, -5) . "\n";
echo "Secret Access Key: " . substr($secretAccessKey, 0, 5) . "..." . substr($secretAccessKey, -5) . "\n";
echo "Region: $region\n";
echo "Bucket: $bucket\n\n";

// Step 1: Verify credentials using STS GetCallerIdentity
echo "Step 1: Verifying AWS credentials using STS GetCallerIdentity...\n";
try {
    $stsClient = new StsClient([
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
    
    $result = $stsClient->getCallerIdentity();
    
    echo "✅ AWS credentials are valid!\n";
    echo "Account ID: " . $result['Account'] . "\n";
    echo "User ARN: " . $result['Arn'] . "\n";
    echo "User ID: " . $result['UserId'] . "\n\n";
} catch (AwsException $e) {
    echo "❌ AWS credentials verification failed: " . $e->getMessage() . "\n\n";
    exit(1);
}

// Step 2: Check S3 permissions
echo "Step 2: Checking S3 permissions...\n";
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
    
    // Check if the specific bucket exists
    echo "Checking if bucket '$bucket' exists...\n";
    try {
        $exists = $s3Client->doesBucketExist($bucket);
        if ($exists) {
            echo "✅ Bucket '$bucket' exists and is accessible.\n";
            
            // Try to list objects in the bucket
            echo "Attempting to list objects in the bucket...\n";
            try {
                $objects = $s3Client->listObjects([
                    'Bucket' => $bucket,
                    'MaxKeys' => 5
                ]);
                
                if (isset($objects['Contents']) && count($objects['Contents']) > 0) {
                    echo "✅ Successfully listed objects. The bucket contains " . count($objects['Contents']) . " object(s).\n";
                    echo "First 5 objects:\n";
                    foreach ($objects['Contents'] as $object) {
                        echo "- " . $object['Key'] . " (Size: " . $object['Size'] . " bytes, Last Modified: " . $object['LastModified'] . ")\n";
                    }
                } else {
                    echo "✅ Successfully listed objects. The bucket is empty.\n";
                }
            } catch (AwsException $e) {
                echo "❌ Cannot list objects in the bucket: " . $e->getMessage() . "\n";
                echo "This is normal if your IAM user doesn't have s3:ListBucket permission.\n";
            }
            
            // Try to upload a test object
            echo "\nAttempting to upload a test object...\n";
            $testKey = 'test-' . time() . '.txt';
            $testContent = 'This is a test file to verify AWS S3 permissions. Created at ' . date('Y-m-d H:i:s');
            
            try {
                $s3Client->putObject([
                    'Bucket' => $bucket,
                    'Key' => $testKey,
                    'Body' => $testContent,
                    'ACL' => 'public-read',
                ]);
                
                echo "✅ Successfully uploaded test object.\n";
                
                // Try to get the test object
                echo "Attempting to get the test object...\n";
                try {
                    $object = $s3Client->getObject([
                        'Bucket' => $bucket,
                        'Key' => $testKey
                    ]);
                    
                    echo "✅ Successfully retrieved test object.\n";
                    
                    // Try to delete the test object
                    echo "Attempting to delete the test object...\n";
                    try {
                        $s3Client->deleteObject([
                            'Bucket' => $bucket,
                            'Key' => $testKey
                        ]);
                        
                        echo "✅ Successfully deleted test object.\n";
                    } catch (AwsException $e) {
                        echo "❌ Cannot delete test object: " . $e->getMessage() . "\n";
                        echo "This is normal if your IAM user doesn't have s3:DeleteObject permission.\n";
                    }
                } catch (AwsException $e) {
                    echo "❌ Cannot get test object: " . $e->getMessage() . "\n";
                    echo "This is normal if your IAM user doesn't have s3:GetObject permission.\n";
                }
            } catch (AwsException $e) {
                echo "❌ Cannot upload test object: " . $e->getMessage() . "\n";
                echo "This is normal if your IAM user doesn't have s3:PutObject permission.\n";
            }
        } else {
            echo "❌ Bucket '$bucket' does not exist or is not accessible.\n";
            
            // Try to create the bucket
            echo "Attempting to create bucket '$bucket'...\n";
            try {
                $s3Client->createBucket([
                    'Bucket' => $bucket,
                    'CreateBucketConfiguration' => [
                        'LocationConstraint' => $region,
                    ],
                ]);
                
                echo "✅ Successfully created bucket '$bucket'.\n";
            } catch (AwsException $e) {
                echo "❌ Cannot create bucket: " . $e->getMessage() . "\n";
                echo "This is normal if your IAM user doesn't have s3:CreateBucket permission.\n";
            }
        }
    } catch (AwsException $e) {
        echo "❌ Error checking bucket: " . $e->getMessage() . "\n";
    }
} catch (AwsException $e) {
    echo "❌ Error initializing S3 client: " . $e->getMessage() . "\n";
}

echo "\nSummary of AWS Permissions:\n";
echo "==========================\n";
echo "1. AWS Credentials: Valid\n";
echo "2. S3 Access: " . (isset($buckets) ? "Full" : "Limited") . "\n";
echo "3. Bucket '$bucket': " . (isset($exists) && $exists ? "Exists" : "Does not exist or not accessible") . "\n";
echo "4. Upload Permission: " . (isset($testKey) ? "Yes" : "No or Limited") . "\n";
echo "5. Download Permission: " . (isset($object) ? "Yes" : "No or Limited") . "\n";
echo "6. Delete Permission: " . (isset($object) && isset($testKey) ? "Yes" : "No or Limited") . "\n";

echo "\nRecommendations:\n";
echo "===============\n";
if (!isset($exists) || !$exists) {
    echo "- The bucket '$bucket' does not exist. You need to create it in the AWS Management Console or ask your AWS administrator to create it for you.\n";
}

if (!isset($testKey)) {
    echo "- Your IAM user may not have sufficient permissions to upload files to S3. Check your IAM policy and make sure it includes s3:PutObject permission for the bucket '$bucket'.\n";
}

echo "\nFor more information on AWS S3 permissions, visit: https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-access-control.html\n";
