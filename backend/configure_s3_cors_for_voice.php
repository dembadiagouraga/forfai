<?php
/**
 * ✅ AWS S3 CORS Configuration for Voice Messages
 * This script configures S3 bucket CORS to allow voice message playback from admin panel
 */

require __DIR__ . '/vendor/autoload.php';

use Aws\S3\S3Client;
use Aws\Exception\AwsException;

// Load environment variables
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

echo "🎵 AWS S3 CORS Configuration for Voice Messages\n";
echo "===============================================\n\n";

// Get AWS credentials
$accessKeyId = $_ENV['AWS_ACCESS_KEY_ID'];
$secretAccessKey = $_ENV['AWS_SECRET_ACCESS_KEY'];
$region = $_ENV['AWS_DEFAULT_REGION'];
$bucket = $_ENV['AWS_BUCKET'];

echo "Bucket: $bucket\n";
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
            'verify' => false // Disable SSL verification for local development
        ]
    ]);

    // ✅ ENHANCED: Voice message optimized CORS configuration
    $corsConfiguration = [
        'CORSRules' => [
            [
                'ID' => 'VoiceMessageCORS',
                'AllowedHeaders' => [
                    '*',
                    'Authorization',
                    'Content-Type',
                    'Content-Length',
                    'Content-Range',
                    'Accept',
                    'Accept-Encoding',
                    'Accept-Language',
                    'Cache-Control',
                    'Connection',
                    'Host',
                    'Origin',
                    'Pragma',
                    'Referer',
                    'User-Agent',
                    'x-requested-with'
                ],
                'AllowedMethods' => ['GET', 'HEAD'],
                'AllowedOrigins' => [
                    '*',  // Allow all origins for voice messages
                    'http://localhost:3000',  // Admin panel dev
                    'http://localhost:3001',  // Admin panel alt
                    'http://127.0.0.1:3000',  // Local IP
                    'http://192.168.0.104:3000',  // Network IP
                    'https://*.amazonaws.com', // S3 origins
                ],
                'ExposeHeaders' => [
                    'Content-Length',
                    'Content-Type',
                    'Content-Range',
                    'Accept-Ranges',
                    'Content-Disposition',
                    'Content-Encoding',
                    'Date',
                    'ETag',
                    'Last-Modified'
                ],
                'MaxAgeSeconds' => 86400  // 24 hours cache
            ],
            [
                'ID' => 'VoiceMessageUpload',
                'AllowedHeaders' => [
                    'Content-Type',
                    'Content-MD5',
                    'Authorization',
                    'x-amz-date',
                    'x-amz-content-sha256'
                ],
                'AllowedMethods' => ['PUT', 'POST', 'DELETE'],
                'AllowedOrigins' => ['*'],
                'MaxAgeSeconds' => 3600  // 1 hour cache
            ]
        ]
    ];

    echo "Applying CORS configuration...\n";
    
    $result = $s3Client->putBucketCors([
        'Bucket' => $bucket,
        'CORSConfiguration' => $corsConfiguration
    ]);

    echo "✅ CORS configuration applied successfully!\n\n";

    // Verify the configuration
    echo "Verifying CORS configuration...\n";
    $cors = $s3Client->getBucketCors(['Bucket' => $bucket]);
    
    echo "✅ CORS Rules Applied:\n";
    foreach ($cors['CORSRules'] as $rule) {
        echo "  - Rule ID: " . ($rule['ID'] ?? 'No ID') . "\n";
        echo "    Methods: " . implode(', ', $rule['AllowedMethods']) . "\n";
        echo "    Origins: " . implode(', ', $rule['AllowedOrigins']) . "\n";
        echo "    Headers: " . implode(', ', $rule['AllowedHeaders']) . "\n\n";
    }

    echo "🎉 Voice message CORS configuration completed successfully!\n";
    echo "Admin panel should now be able to play voice messages from S3.\n";

} catch (AwsException $e) {
    echo "❌ AWS Error: " . $e->getMessage() . "\n";
    echo "Error Code: " . $e->getAwsErrorCode() . "\n";
    exit(1);
} catch (Exception $e) {
    echo "❌ General Error: " . $e->getMessage() . "\n";
    exit(1);
}
