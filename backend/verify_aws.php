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

echo "Verifying AWS credentials...\n";
echo "Access Key ID: " . substr($accessKeyId, 0, 5) . "..." . substr($accessKeyId, -5) . "\n";
echo "Secret Access Key: " . substr($secretAccessKey, 0, 5) . "..." . substr($secretAccessKey, -5) . "\n";
echo "Region: $region\n";
echo "Bucket: $bucket\n\n";

try {
    // Get SSL verification setting
    $verifySSL = isset($_ENV['AWS_VERIFY_SSL']) ? filter_var($_ENV['AWS_VERIFY_SSL'], FILTER_VALIDATE_BOOLEAN) : true;
    echo "SSL Verification: " . ($verifySSL ? "Enabled" : "Disabled") . "\n\n";

    // Create an S3 client
    $s3Client = new S3Client([
        'version' => 'latest',
        'region' => $region,
        'credentials' => [
            'key' => $accessKeyId,
            'secret' => $secretAccessKey,
        ],
        'http' => [
            'verify' => $verifySSL
        ]
    ]);

    // Check if the specific bucket exists
    try {
        $bucketExists = $s3Client->doesBucketExist($bucket);
        echo "AWS credentials are valid!\n";

        // Test uploading a file
        echo "\nTesting file upload to bucket '$bucket'...\n";
        $testFilePath = 'voice-notes/test-file-' . time() . '.txt';
        $testFileContent = 'This is a test file to verify AWS S3 configuration.';

        try {
            $result = $s3Client->putObject([
                'Bucket' => $bucket,
                'Key' => $testFilePath,
                'Body' => $testFileContent,
                'ACL' => 'public-read',
            ]);

            $url = $result['ObjectURL'];
            echo "✅ Test file uploaded successfully.\n";
            echo "URL: $url\n";

            // Delete the test file
            try {
                $s3Client->deleteObject([
                    'Bucket' => $bucket,
                    'Key' => $testFilePath,
                ]);

                echo "✅ Test file deleted successfully.\n";
            } catch (AwsException $e) {
                echo "❌ Failed to delete test file: " . $e->getMessage() . "\n";
            }
        } catch (AwsException $e) {
            echo "❌ Failed to upload test file: " . $e->getMessage() . "\n";
        }
    } catch (AwsException $e) {
        echo "Error checking bucket: " . $e->getMessage() . "\n";
        exit(1);
    }

    if ($bucketExists) {
        echo "\nThe bucket '$bucket' exists and is accessible.\n";

        // Try to list objects in the bucket
        echo "\nListing some objects in the bucket:\n";
        try {
            $objects = $s3Client->listObjects([
                'Bucket' => $bucket,
                'MaxKeys' => 5
            ]);

            if (isset($objects['Contents']) && count($objects['Contents']) > 0) {
                foreach ($objects['Contents'] as $object) {
                    echo "- {$object['Key']}\n";
                }
            } else {
                echo "No objects found in the bucket.\n";
            }
        } catch (AwsException $e) {
            echo "Error listing objects: " . $e->getMessage() . "\n";
        }
    } else {
        echo "\nWARNING: The bucket '$bucket' does not exist or is not accessible with these credentials.\n";

        // Try to create the bucket
        echo "\nAttempting to create bucket '$bucket'...\n";
        try {
            $result = $s3Client->createBucket([
                'Bucket' => $bucket,
                'CreateBucketConfiguration' => [
                    'LocationConstraint' => $region,
                ],
            ]);

            echo "✅ Bucket '$bucket' created successfully.\n";

            // Set bucket policy to allow public read access
            try {
                $s3Client->putBucketPolicy([
                    'Bucket' => $bucket,
                    'Policy' => json_encode([
                        'Version' => '2012-10-17',
                        'Statement' => [
                            [
                                'Sid' => 'PublicReadGetObject',
                                'Effect' => 'Allow',
                                'Principal' => '*',
                                'Action' => 's3:GetObject',
                                'Resource' => "arn:aws:s3:::$bucket/*",
                            ],
                        ],
                    ]),
                ]);

                echo "✅ Bucket policy set to allow public read access.\n";
            } catch (AwsException $e) {
                echo "❌ Failed to set bucket policy: " . $e->getMessage() . "\n";
            }
        } catch (AwsException $e) {
            echo "❌ Failed to create bucket: " . $e->getMessage() . "\n";
        }
    }

} catch (AwsException $e) {
    echo "Error: " . $e->getMessage() . "\n";
    echo "AWS credentials are invalid or there's a configuration issue.\n";
}
