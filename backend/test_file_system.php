<?php
require 'vendor/autoload.php';

// Load environment variables from .env file
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

echo "File System Test\n";
echo "===============\n\n";

// Test voice note storage
echo "Testing voice note storage...\n";

// Create test directories
$publicPath = __DIR__ . '/public';
$storagePath = __DIR__ . '/storage';
$publicStoragePath = $publicPath . '/storage';
$voiceNotesDir = $publicStoragePath . '/voice-notes';
$voiceMessagesDir = $publicStoragePath . '/voice_messages';

// Ensure directories exist
if (!is_dir($publicStoragePath)) {
    echo "Creating public storage directory...\n";
    mkdir($publicStoragePath, 0777, true);
}

if (!is_dir($voiceNotesDir)) {
    echo "Creating voice notes directory...\n";
    mkdir($voiceNotesDir, 0777, true);
}

if (!is_dir($voiceMessagesDir)) {
    echo "Creating voice messages directory...\n";
    mkdir($voiceMessagesDir, 0777, true);
}

// Test voice note storage
$voiceNoteFilename = 'test_voice_note_' . time() . '.mp3';
$voiceNotePath = $voiceNotesDir . '/' . $voiceNoteFilename;
$voiceNoteContent = str_repeat('0', 1024); // 1KB of zeros

try {
    // Write test file
    file_put_contents($voiceNotePath, $voiceNoteContent);
    
    // Generate URL
    $baseUrl = rtrim($_ENV['IMG_HOST'], '/');
    $voiceNoteUrl = $baseUrl . '/storage/voice-notes/' . $voiceNoteFilename;
    
    echo "✅ Voice note saved to local storage.\n";
    echo "Path: $voiceNotePath\n";
    echo "URL: $voiceNoteUrl\n\n";
    
    // Check if file exists
    if (file_exists($voiceNotePath)) {
        echo "✅ Voice note file exists in storage.\n";
        
        // Check file content
        $content = file_get_contents($voiceNotePath);
        if ($content === $voiceNoteContent) {
            echo "✅ Voice note content is correct.\n\n";
        } else {
            echo "❌ Voice note content is incorrect.\n\n";
        }
        
        // Delete the file
        unlink($voiceNotePath);
        echo "✅ Voice note deleted from storage.\n\n";
    } else {
        echo "❌ Voice note file does not exist in storage.\n\n";
    }
} catch (Exception $e) {
    echo "❌ Error storing voice note: " . $e->getMessage() . "\n\n";
}

// Test voice message storage
echo "Testing voice message storage...\n";

// Create chat directory
$chatId = 'test-chat-' . time();
$chatDir = $voiceMessagesDir . '/' . $chatId;
if (!is_dir($chatDir)) {
    echo "Creating chat directory...\n";
    mkdir($chatDir, 0777, true);
}

// Test voice message storage
$voiceMessageFilename = 'test_voice_message_' . time() . '.mp3';
$voiceMessagePath = $chatDir . '/' . $voiceMessageFilename;
$voiceMessageContent = str_repeat('1', 1024); // 1KB of ones

try {
    // Write test file
    file_put_contents($voiceMessagePath, $voiceMessageContent);
    
    // Generate URL
    $baseUrl = rtrim($_ENV['IMG_HOST'], '/');
    $voiceMessageUrl = $baseUrl . '/storage/voice_messages/' . $chatId . '/' . $voiceMessageFilename;
    
    echo "✅ Voice message saved to local storage.\n";
    echo "Path: $voiceMessagePath\n";
    echo "URL: $voiceMessageUrl\n\n";
    
    // Check if file exists
    if (file_exists($voiceMessagePath)) {
        echo "✅ Voice message file exists in storage.\n";
        
        // Check file content
        $content = file_get_contents($voiceMessagePath);
        if ($content === $voiceMessageContent) {
            echo "✅ Voice message content is correct.\n\n";
        } else {
            echo "❌ Voice message content is incorrect.\n\n";
        }
        
        // Delete the file
        unlink($voiceMessagePath);
        echo "✅ Voice message deleted from storage.\n\n";
    } else {
        echo "❌ Voice message file does not exist in storage.\n\n";
    }
} catch (Exception $e) {
    echo "❌ Error storing voice message: " . $e->getMessage() . "\n\n";
}

echo "Test completed.\n";
