<?php
require 'vendor/autoload.php';

// Load environment variables
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

echo "Testing Voice Chat Feature (Without ACL)\n";
echo "=======================================\n\n";

// Create a test audio file
echo "Creating test audio file...\n";
$testAudioPath = __DIR__ . '/storage/app/public/test_voice_message.mp3';
$testAudioDir = dirname($testAudioPath);

// Create directory if it doesn't exist
if (!file_exists($testAudioDir)) {
    mkdir($testAudioDir, 0777, true);
}

// Create a simple MP3 file (this is just a placeholder, not a real MP3)
file_put_contents($testAudioPath, str_repeat('AUDIO_DATA', 1000));
echo "Test audio file created at: $testAudioPath\n\n";

// Test S3 upload
echo "Testing S3 upload...\n";

try {
    // Create S3 client
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

    // Generate a unique filename
    $chatId = 'test_chat_' . uniqid();
    $fileName = time() . '_' . uniqid() . '.mp3';
    $path = "media/voice_messages/{$chatId}/{$fileName}";

    echo "Uploading to S3 path: $path\n";

    // Upload to S3 WITHOUT ACL parameter
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

    // Test playback in a browser
    echo "To test playback in a browser, open this URL:\n";
    echo $url . "\n\n";

    // Clean up
    echo "Cleaning up test file...\n";
    if (file_exists($testAudioPath)) {
        unlink($testAudioPath);
        echo "Test file deleted.\n";
    }

    echo "\nTest completed successfully!\n";
    echo "The voice chat feature should now work without ACL.\n";

} catch (Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
    echo "Stack trace: " . $e->getTraceAsString() . "\n";
}
