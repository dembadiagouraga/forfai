<?php
// This script simulates a voice message upload request to the ChatController

// Load the Laravel application
require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Http\Kernel::class);

// Create a test audio file
$testAudioPath = __DIR__ . '/storage/app/public/test_audio.mp3';
$testAudioContent = str_repeat('0', 1024); // 1KB of zeros
file_put_contents($testAudioPath, $testAudioContent);

// Create a test request
$request = Illuminate\Http\Request::create(
    '/api/v1/dashboard/chat/voice-message',
    'POST',
    [
        'chat_id' => 'test-chat-' . time(),
        'duration' => 5,
    ],
    [],
    [
        'audio' => new Illuminate\Http\UploadedFile(
            $testAudioPath,
            'test_audio.mp3',
            'audio/mpeg',
            null,
            true
        ),
    ],
    [
        'HTTP_ACCEPT' => 'application/json',
    ]
);

// Add authentication
$user = App\Models\User::first();
if ($user) {
    $token = $user->createToken('test-token')->plainTextToken;
    $request->headers->set('Authorization', 'Bearer ' . $token);
} else {
    die("No user found in the database. Please create a user first.\n");
}

// Handle the request
$response = $kernel->handle($request);

// Get the response content
$content = $response->getContent();

// Output the response
echo "Response Status: " . $response->getStatusCode() . "\n";
echo "Response Content: " . $content . "\n";

// Clean up
$kernel->terminate($request, $response);
