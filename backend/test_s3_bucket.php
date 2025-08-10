<?php
// This script tests the S3 bucket configuration and permissions

// Load the Laravel application
require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Http\Kernel::class);

// Load environment variables
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

echo "S3 Bucket Configuration Test\n";
echo "===========================\n\n";

// Get S3 configuration from environment
$accessKeyId = $_ENV['AWS_ACCESS_KEY_ID'];
$secretAccessKey = $_ENV['AWS_SECRET_ACCESS_KEY'];
$region = $_ENV['AWS_DEFAULT_REGION'];
$bucket = $_ENV['AWS_BUCKET'];

echo "AWS Configuration:\n";
echo "- Region: $region\n";
echo "- Bucket: $bucket\n";
echo "- Access Key ID: " . substr($accessKeyId, 0, 5) . "..." . substr($accessKeyId, -5) . "\n";
echo "- Secret Access Key: " . substr($secretAccessKey, 0, 3) . "..." . substr($secretAccessKey, -3) . "\n\n";

// Create a test audio file
$testAudioPath = __DIR__ . '/storage/app/public/test_audio.mp3';
$testAudioContent = str_repeat('AUDIO_DATA', 1000); // 10KB of dummy data
file_put_contents($testAudioPath, $testAudioContent);
echo "Test audio file created at: $testAudioPath\n\n";

// Create S3 client
try {
    $s3Client = new Aws\S3\S3Client([
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
    
    echo "S3 client created successfully\n";
} catch (Exception $e) {
    echo "❌ Failed to create S3 client: " . $e->getMessage() . "\n";
    exit(1);
}

// Check if bucket exists
try {
    $result = $s3Client->headBucket([
        'Bucket' => $bucket
    ]);
    echo "✅ Bucket '$bucket' exists\n";
} catch (Exception $e) {
    echo "❌ Bucket check failed: " . $e->getMessage() . "\n";
    exit(1);
}

// Get bucket policy
try {
    $policy = $s3Client->getBucketPolicy([
        'Bucket' => $bucket
    ]);
    echo "✅ Bucket policy retrieved successfully\n";
    echo "Policy: " . $policy['Policy'] . "\n\n";
} catch (Exception $e) {
    echo "⚠️ Could not retrieve bucket policy: " . $e->getMessage() . "\n";
    echo "This might be normal if no policy is set\n\n";
}

// Get bucket CORS configuration
try {
    $cors = $s3Client->getBucketCors([
        'Bucket' => $bucket
    ]);
    echo "✅ CORS configuration retrieved successfully\n";
    echo "CORS Rules: " . json_encode($cors['CORSRules'], JSON_PRETTY_PRINT) . "\n\n";
} catch (Exception $e) {
    echo "⚠️ Could not retrieve CORS configuration: " . $e->getMessage() . "\n";
    echo "This might be normal if no CORS configuration is set\n\n";
}

// Test upload WITHOUT ACL parameter
echo "Testing upload WITHOUT ACL parameter...\n";
$testKey = "test/test_upload_" . time() . ".mp3";

try {
    $result = $s3Client->putObject([
        'Bucket' => $bucket,
        'Key' => $testKey,
        'Body' => $testAudioContent,
        'ContentType' => 'audio/mpeg',
        // No ACL parameter
    ]);
    
    echo "✅ Test file uploaded successfully WITHOUT ACL\n";
    echo "URL: " . $result['ObjectURL'] . "\n\n";
    
    // Test if the file is publicly accessible
    try {
        $client = new GuzzleHttp\Client(['verify' => false]);
        $response = $client->get($result['ObjectURL'], ['timeout' => 5]);
        
        if ($response->getStatusCode() == 200) {
            echo "✅ File is publicly accessible via HTTP\n";
        } else {
            echo "❌ File is not publicly accessible (Status: " . $response->getStatusCode() . ")\n";
        }
    } catch (Exception $e) {
        echo "❌ File is not publicly accessible: " . $e->getMessage() . "\n";
    }
    
    // Clean up
    $s3Client->deleteObject([
        'Bucket' => $bucket,
        'Key' => $testKey,
    ]);
    echo "✅ Test file deleted\n\n";
} catch (Exception $e) {
    echo "❌ Upload WITHOUT ACL failed: " . $e->getMessage() . "\n\n";
}

// Test upload WITH ACL parameter
echo "Testing upload WITH ACL parameter...\n";
$testKey = "test/test_upload_acl_" . time() . ".mp3";

try {
    $result = $s3Client->putObject([
        'Bucket' => $bucket,
        'Key' => $testKey,
        'Body' => $testAudioContent,
        'ContentType' => 'audio/mpeg',
        'ACL' => 'public-read', // With ACL parameter
    ]);
    
    echo "✅ Test file uploaded successfully WITH ACL\n";
    echo "URL: " . $result['ObjectURL'] . "\n\n";
    
    // Clean up
    $s3Client->deleteObject([
        'Bucket' => $bucket,
        'Key' => $testKey,
    ]);
    echo "✅ Test file deleted\n\n";
} catch (Exception $e) {
    echo "❌ Upload WITH ACL failed: " . $e->getMessage() . "\n";
    echo "This is expected if the bucket does not allow ACLs\n\n";
}

echo "Test completed\n";
