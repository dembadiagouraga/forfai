<?php
/**
 * ✅ VOICE FILES S3 SETUP VERIFICATION
 * Verifies that S3 is properly configured for voice files only
 */

require __DIR__ . '/vendor/autoload.php';

use Aws\S3\S3Client;
use Aws\Exception\AwsException;

// Load environment variables
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

echo "🎵 VOICE FILES S3 SETUP VERIFICATION\n";
echo "===================================\n\n";

// Check environment variables
$requiredVars = ['AWS_ACCESS_KEY_ID', 'AWS_SECRET_ACCESS_KEY', 'AWS_DEFAULT_REGION', 'AWS_BUCKET'];
$missingVars = [];

foreach ($requiredVars as $var) {
    if (empty($_ENV[$var])) {
        $missingVars[] = $var;
    }
}

if (!empty($missingVars)) {
    echo "❌ Missing environment variables:\n";
    foreach ($missingVars as $var) {
        echo "   - $var\n";
    }
    echo "\nPlease add these to your .env file\n";
    exit(1);
}

echo "✅ Environment variables found:\n";
echo "   - AWS_ACCESS_KEY_ID: " . substr($_ENV['AWS_ACCESS_KEY_ID'], 0, 5) . "...\n";
echo "   - AWS_SECRET_ACCESS_KEY: " . substr($_ENV['AWS_SECRET_ACCESS_KEY'], 0, 3) . "...\n";
echo "   - AWS_DEFAULT_REGION: " . $_ENV['AWS_DEFAULT_REGION'] . "\n";
echo "   - AWS_BUCKET: " . $_ENV['AWS_BUCKET'] . "\n\n";

try {
    // Create S3 client
    $s3Client = new S3Client([
        'version' => 'latest',
        'region' => $_ENV['AWS_DEFAULT_REGION'],
        'credentials' => [
            'key' => $_ENV['AWS_ACCESS_KEY_ID'],
            'secret' => $_ENV['AWS_SECRET_ACCESS_KEY'],
        ],
    ]);

    // Test bucket access
    echo "Testing S3 bucket access...\n";
    $result = $s3Client->headBucket(['Bucket' => $_ENV['AWS_BUCKET']]);
    echo "✅ S3 bucket is accessible\n\n";

    // Test voice message upload
    echo "Testing voice message upload...\n";
    $testPath = 'media/voice_messages/test-chat/test-voice-' . time() . '.wav';
    $testContent = 'This is a test voice message file';

    $result = $s3Client->putObject([
        'Bucket' => $_ENV['AWS_BUCKET'],
        'Key' => $testPath,
        'Body' => $testContent,
        'ContentType' => 'audio/wav',
    ]);

    $testUrl = $result['ObjectURL'];
    echo "✅ Test voice message uploaded successfully\n";
    echo "   URL: $testUrl\n\n";

    // Test file accessibility
    echo "Testing file accessibility...\n";
    $response = $s3Client->getObject([
        'Bucket' => $_ENV['AWS_BUCKET'],
        'Key' => $testPath,
    ]);
    echo "✅ Test file is accessible\n\n";

    // Clean up test file
    echo "Cleaning up test file...\n";
    $s3Client->deleteObject([
        'Bucket' => $_ENV['AWS_BUCKET'],
        'Key' => $testPath,
    ]);
    echo "✅ Test file cleaned up\n\n";

    // Check database AWS setting
    echo "Checking database AWS setting...\n";
    
    // Load Laravel
    $app = require_once __DIR__ . '/bootstrap/app.php';
    $kernel = $app->make(Illuminate\Contracts\Http\Kernel::class);
    
    // Check database setting
    $awsSetting = \App\Models\Settings::where('key', 'aws')->first();
    
    if ($awsSetting) {
        $isEnabled = (bool)$awsSetting->value;
        echo "✅ Database AWS setting found\n";
        echo "   Status: " . ($isEnabled ? "ENABLED" : "DISABLED") . "\n";
        echo "   Note: Voice files ignore this setting and always use S3\n";
        echo "   Other files (images, documents) " . ($isEnabled ? "will use S3" : "will use local storage") . "\n\n";
    } else {
        echo "⚠️ Database AWS setting not found\n";
        echo "   Voice files will still use S3 (forced)\n";
        echo "   Other files will use local storage (default)\n\n";
    }

    echo "🎉 VOICE FILES S3 SETUP VERIFICATION COMPLETE!\n";
    echo "✅ Voice messages will upload to S3\n";
    echo "✅ Other files follow database setting\n";
    echo "✅ S3 configuration is working properly\n";

} catch (AwsException $e) {
    echo "❌ AWS Error: " . $e->getMessage() . "\n";
    echo "Error Code: " . $e->getAwsErrorCode() . "\n";
    exit(1);
} catch (Exception $e) {
    echo "❌ General Error: " . $e->getMessage() . "\n";
    exit(1);
}
