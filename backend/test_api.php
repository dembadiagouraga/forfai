<?php
// This script tests the API endpoints for voice message and voice note uploads

// Create a test audio file
$testAudioPath = __DIR__ . '/public/assets/audio/test_audio.mp3';
$testAudioContent = str_repeat('0', 1024); // 1KB of zeros
file_put_contents($testAudioPath, $testAudioContent);

echo "API Test\n";
echo "========\n\n";

// Get the base URL from .env
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();
$baseUrl = rtrim($_ENV['IMG_HOST'], '/');

echo "Base URL: $baseUrl\n\n";

// Test the voice message upload API
echo "Testing voice message upload API...\n";
echo "This test requires a running Laravel server. Make sure to run 'php artisan serve' in another terminal.\n";
echo "Press Enter to continue or Ctrl+C to cancel...\n";
fgets(STDIN);

// Get a valid token
echo "Enter a valid API token: ";
$token = trim(fgets(STDIN));

// Test the voice message upload API
$chatId = 'test-chat-' . time();
$duration = 5;

$command = "curl -X POST \"$baseUrl/api/v1/dashboard/chat/voice-message\" " .
           "-H \"Authorization: Bearer $token\" " .
           "-H \"Accept: application/json\" " .
           "-F \"chat_id=$chatId\" " .
           "-F \"duration=$duration\" " .
           "-F \"audio=@$testAudioPath\"";

echo "Running command: $command\n\n";
$output = shell_exec($command);
echo "Response: $output\n\n";

// Test the voice note upload API
echo "Testing voice note upload API...\n";

// Get a valid product ID
echo "Enter a valid product ID: ";
$productId = trim(fgets(STDIN));

$command = "curl -X POST \"$baseUrl/api/v1/dashboard/admin/products/$productId\" " .
           "-H \"Authorization: Bearer $token\" " .
           "-H \"Accept: application/json\" " .
           "-F \"_method=PUT\" " .
           "-F \"voice_note_duration=$duration\" " .
           "-F \"voice_note=@$testAudioPath\"";

echo "Running command: $command\n\n";
$output = shell_exec($command);
echo "Response: $output\n\n";

echo "Test completed.\n";
