<?php
require 'vendor/autoload.php';

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;

// Load environment variables from .env file
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

echo "Local Storage Fallback Test\n";
echo "==========================\n\n";

// Test voice note storage
echo "Testing voice note storage (local fallback)...\n";

// Create a test audio file
$testAudioPath = __DIR__ . '/storage/app/public/test_audio.mp3';
$testAudioContent = str_repeat('0', 1024); // 1KB of zeros
file_put_contents($testAudioPath, $testAudioContent);

// Create an UploadedFile instance
$uploadedFile = new UploadedFile(
    $testAudioPath,
    'test_audio.mp3',
    'audio/mpeg',
    null,
    true
);

// Test voice note storage
$voiceNotePath = 'voice-notes/' . uniqid() . '.mp3';
$localPath = 'public/' . $voiceNotePath;

// Store locally
try {
    Storage::put($localPath, file_get_contents($uploadedFile->getRealPath()));
    
    // Generate URL
    $url = rtrim(config('app.img_host'), '/') . '/' . str_replace('public/', 'storage/', $localPath);
    
    echo "✅ Voice note saved to local storage.\n";
    echo "Path: $localPath\n";
    echo "URL: $url\n\n";
    
    // Check if file exists
    if (Storage::exists($localPath)) {
        echo "✅ Voice note file exists in storage.\n";
        
        // Check file content
        $content = Storage::get($localPath);
        if ($content === $testAudioContent) {
            echo "✅ Voice note content is correct.\n\n";
        } else {
            echo "❌ Voice note content is incorrect.\n\n";
        }
        
        // Delete the file
        Storage::delete($localPath);
        echo "✅ Voice note deleted from storage.\n\n";
    } else {
        echo "❌ Voice note file does not exist in storage.\n\n";
    }
} catch (Exception $e) {
    echo "❌ Error storing voice note: " . $e->getMessage() . "\n\n";
}

// Test voice message storage
echo "Testing voice message storage (local fallback)...\n";

// Create a test audio file for voice message
$testVoiceMessagePath = __DIR__ . '/storage/app/public/test_voice_message.mp3';
$testVoiceMessageContent = str_repeat('1', 1024); // 1KB of ones
file_put_contents($testVoiceMessagePath, $testVoiceMessageContent);

// Create an UploadedFile instance
$voiceMessageFile = new UploadedFile(
    $testVoiceMessagePath,
    'test_voice_message.mp3',
    'audio/mpeg',
    null,
    true
);

// Test voice message storage
$chatId = 'test-chat-' . time();
$voiceMessagePath = "voice_messages/{$chatId}/" . uniqid() . '.mp3';
$localVoiceMessagePath = 'public/' . $voiceMessagePath;

// Store locally
try {
    Storage::put($localVoiceMessagePath, file_get_contents($voiceMessageFile->getRealPath()));
    
    // Generate URL
    $voiceMessageUrl = rtrim(config('app.img_host'), '/') . '/' . str_replace('public/', 'storage/', $localVoiceMessagePath);
    
    echo "✅ Voice message saved to local storage.\n";
    echo "Path: $localVoiceMessagePath\n";
    echo "URL: $voiceMessageUrl\n\n";
    
    // Check if file exists
    if (Storage::exists($localVoiceMessagePath)) {
        echo "✅ Voice message file exists in storage.\n";
        
        // Check file content
        $content = Storage::get($localVoiceMessagePath);
        if ($content === $testVoiceMessageContent) {
            echo "✅ Voice message content is correct.\n\n";
        } else {
            echo "❌ Voice message content is incorrect.\n\n";
        }
        
        // Delete the file
        Storage::delete($localVoiceMessagePath);
        echo "✅ Voice message deleted from storage.\n\n";
    } else {
        echo "❌ Voice message file does not exist in storage.\n\n";
    }
} catch (Exception $e) {
    echo "❌ Error storing voice message: " . $e->getMessage() . "\n\n";
}

echo "Test completed.\n";
