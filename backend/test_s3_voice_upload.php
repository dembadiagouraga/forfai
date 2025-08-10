<?php
// Simple test script for S3 voice upload without Laravel dependencies

echo "Testing S3 Voice Upload\n";
echo "======================\n\n";

// Create a test audio file
$testAudioPath = __DIR__ . '/storage/app/public/test_voice_message.mp3';
$testAudioDir = dirname($testAudioPath);

// Create directory if it doesn't exist
if (!file_exists($testAudioDir)) {
    mkdir($testAudioDir, 0777, true);
    echo "Created directory: $testAudioDir\n";
}

// Create a simple MP3 file (this is just a placeholder, not a real MP3)
file_put_contents($testAudioPath, str_repeat('AUDIO_DATA', 1000));
echo "Test audio file created at: $testAudioPath\n\n";

// Load AWS SDK from composer autoload if available
if (file_exists(__DIR__ . '/vendor/autoload.php')) {
    require __DIR__ . '/vendor/autoload.php';
    echo "Loaded AWS SDK from composer autoload\n";
} else {
    echo "❌ AWS SDK not found. Please run 'composer require aws/aws-sdk-php'\n";
    exit(1);
}

// Load environment variables from .env file if available
if (file_exists(__DIR__ . '/.env')) {
    $lines = file(__DIR__ . '/.env', FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        if (strpos($line, '=') !== false && strpos($line, '#') !== 0) {
            list($key, $value) = explode('=', $line, 2);
            $_ENV[trim($key)] = trim($value);
        }
    }
    echo "Loaded environment variables from .env file\n";
} else {
    echo "❌ .env file not found\n";
    exit(1);
}

// Check if AWS credentials are available
if (!isset($_ENV['AWS_ACCESS_KEY_ID']) || !isset($_ENV['AWS_SECRET_ACCESS_KEY']) || !isset($_ENV['AWS_DEFAULT_REGION']) || !isset($_ENV['AWS_BUCKET'])) {
    echo "❌ AWS credentials not found in .env file\n";
    exit(1);
}

echo "AWS Credentials:\n";
echo "  Region: " . $_ENV['AWS_DEFAULT_REGION'] . "\n";
echo "  Bucket: " . $_ENV['AWS_BUCKET'] . "\n\n";

// Create S3 client
try {
    $s3Client = new Aws\S3\S3Client([
        'version' => 'latest',
        'region' => $_ENV['AWS_DEFAULT_REGION'],
        'credentials' => [
            'key' => $_ENV['AWS_ACCESS_KEY_ID'],
            'secret' => $_ENV['AWS_SECRET_ACCESS_KEY'],
        ],
        'http' => [
            'verify' => false // Disable SSL verification for testing
        ]
    ]);
    echo "Created S3 client\n";
} catch (Exception $e) {
    echo "❌ Failed to create S3 client: " . $e->getMessage() . "\n";
    exit(1);
}

// Generate a unique filename
$chatId = 'test_chat_' . uniqid();
$fileName = time() . '_' . uniqid() . '.mp3';
$path = "media/voice_messages/{$chatId}/{$fileName}";

echo "Uploading to S3 path: $path\n";

// Upload to S3
try {
    $result = $s3Client->putObject([
        'Bucket' => $_ENV['AWS_BUCKET'],
        'Key' => $path,
        'Body' => file_get_contents($testAudioPath),
        'ContentType' => 'audio/mpeg',
    ]);

    // Get the URL
    $url = $result['ObjectURL'];
    echo "✅ Upload successful!\n";
    echo "S3 URL: $url\n\n";

    // Test if the file is accessible
    echo "Testing if the file is publicly accessible...\n";
    $response = @file_get_contents($url);
    
    if ($response !== false) {
        echo "✅ File is publicly accessible!\n\n";
    } else {
        echo "❌ File is not publicly accessible. Error: " . error_get_last()['message'] . "\n\n";
    }

    // Clean up
    echo "Cleaning up test file from S3...\n";
    $s3Client->deleteObject([
        'Bucket' => $_ENV['AWS_BUCKET'],
        'Key' => $path,
    ]);
    echo "Test file deleted from S3.\n";

    echo "Cleaning up local test file...\n";
    if (file_exists($testAudioPath)) {
        unlink($testAudioPath);
        echo "Local test file deleted.\n";
    }

    echo "\nTest completed successfully!\n";
    echo "The voice chat feature should now work with MP3 format.\n";
} catch (Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}
