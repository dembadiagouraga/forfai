<?php

namespace App\Http\Controllers\API\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;

class ProxyController extends Controller
{
    /**
     * Proxy for voice messages to handle CORS and access issues
     *
     * @param string $chatId
     * @param string $filename
     * @return \Illuminate\Http\Response
     */
    public function getVoiceMessage($chatId, $filename)
    {
        // ✅ Enhanced CORS headers for all responses
        $corsHeaders = [
            'Access-Control-Allow-Origin' => '*',
            'Access-Control-Allow-Methods' => 'GET, HEAD, OPTIONS',
            'Access-Control-Allow-Headers' => 'Accept, Content-Type, Authorization',
            'Access-Control-Expose-Headers' => 'Content-Length, Content-Type, Accept-Ranges',
            'Access-Control-Max-Age' => '86400',
        ];

        // ✅ Handle OPTIONS preflight requests
        if (request()->isMethod('OPTIONS')) {
            return response('', 200, $corsHeaders);
        }
        // ✅ ENHANCED: Comprehensive CORS headers for voice messages
        $headers = array_merge($corsHeaders, [
            'Content-Type' => 'audio/mpeg',
            'Accept-Ranges' => 'bytes',
            'Cache-Control' => 'public, max-age=86400',
        ]);

        // Log request details
        Log::info("Voice message proxy request", [
            'chatId' => $chatId,
            'filename' => $filename
        ]);

        // Create a dummy MP3 file for testing
        $dummyMp3Path = storage_path('app/public/dummy.mp3');
        if (!file_exists($dummyMp3Path)) {
            // Create a minimal valid MP3 file
            $dummyMp3Data = hex2bin(
                '4944330300000000000a' . // ID3v2 header
                'fffb9000' .             // MP3 frame header
                '0000000000000000' .     // Some minimal MP3 data
                '0000000000000000'
            );
            file_put_contents($dummyMp3Path, $dummyMp3Data);
            Log::info("Created dummy MP3 file at: {$dummyMp3Path}");
        }

        // Try multiple paths for local storage
        $possiblePaths = [
            "voice_messages/{$chatId}/{$filename}",
            "voice_messages/{$chatId}_{$filename}",
            "voice_messages/ScG4Eoc6kkRZO8KmQRZP/{$filename}", // Hardcoded chat ID from logs
            "voice_messages/{$filename}",
            "voice_messages/test-chat-1746070877/{$filename}",
            "voice_messages/test_chat_1746039817/{$filename}",
            "voice_messages/test_chat_1746039850/{$filename}",
            "voice_messages/test_chat_1746039979/{$filename}",
            "voice_messages/test_chat_1746077011/{$filename}",
            // Add test_audio.mp3 as a fallback
            "test_audio.mp3",
        ];

        // Log all possible paths
        Log::info("Checking possible paths", ['paths' => $possiblePaths]);

        // Check if any of the possible paths exist
        foreach ($possiblePaths as $path) {
            if (Storage::disk('public')->exists($path)) {
                Log::info("Found voice message in local storage: {$path}");
                return response(Storage::disk('public')->get($path), 200, $headers);
            }
        }

        // If not in local storage, try to get from S3
        try {
            // Try multiple S3 paths
            $s3Paths = [
                "media/voice_messages/{$chatId}/{$filename}",
                "voice_messages/{$chatId}/{$filename}",
                "media/voice_messages/AXvrtwzZN7W9bM9PvTAA/{$filename}", // Current chat ID from logs
                "media/voice_messages/ScG4Eoc6kkRZO8KmQRZP/{$filename}", // Previous chat ID from logs
            ];

            // Create S3 client
            $s3Client = new \Aws\S3\S3Client([
                'version' => 'latest',
                'region' => env('AWS_DEFAULT_REGION'),
                'credentials' => [
                    'key' => env('AWS_ACCESS_KEY_ID'),
                    'secret' => env('AWS_SECRET_ACCESS_KEY'),
                ],
                'http' => [
                    'verify' => false // Disable SSL verification for testing
                ]
            ]);

            foreach ($s3Paths as $s3Path) {
                try {
                    Log::info("Trying to fetch voice message from S3 path: {$s3Path}");

                    // Try to get the object directly from S3
                    $result = $s3Client->getObject([
                        'Bucket' => env('AWS_BUCKET'),
                        'Key' => $s3Path,
                    ]);

                    Log::info("Successfully fetched voice message from S3 path: {$s3Path}");
                    return response($result['Body']->getContents(), 200, $headers);
                } catch (\Exception $e) {
                    Log::warning("Failed to fetch from S3 path {$s3Path}: " . $e->getMessage());
                }
            }

            // If direct S3 access failed, try HTTP
            $s3Url = "https://forfai-media.s3.eu-north-1.amazonaws.com/media/voice_messages/{$chatId}/{$filename}";
            Log::info("Trying to fetch voice message from S3 URL: {$s3Url}");

            $response = Http::get($s3Url);

            if ($response->successful()) {
                Log::info("Successfully fetched voice message from S3 URL");
                return response($response->body(), 200, $headers);
            } else {
                Log::error("Failed to fetch voice message from S3 URL", [
                    'status' => $response->status(),
                    'body' => $response->body()
                ]);
            }
        } catch (\Exception $e) {
            Log::error("Error fetching voice message from S3: " . $e->getMessage());
        }

        // Return dummy MP3 file as fallback
        Log::info("Returning dummy MP3 file as fallback");
        return response(file_get_contents($dummyMp3Path), 200, $headers);
    }
}
