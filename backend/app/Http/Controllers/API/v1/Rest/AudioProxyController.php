<?php

namespace App\Http\Controllers\API\v1\Rest;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class AudioProxyController extends Controller
{
    /**
     * Proxy audio files to avoid CORS issues
     *
     * @param Request $request
     * @return \Illuminate\Http\Response
     */
    public function proxyAudio(Request $request)
    {
        $url = $request->query('url');
        
        if (empty($url)) {
            return response()->json(['error' => 'URL parameter is required'], 400);
        }
        
        try {
            // Get file contents with a timeout to prevent hanging
            $context = stream_context_create([
                'http' => [
                    'timeout' => 10, // 10 seconds timeout
                    'header' => [
                        'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
                    ]
                ]
            ]);
            
            $content = @file_get_contents($url, false, $context);
            
            if ($content === false) {
                return response()->json([
                    'error' => 'Could not fetch audio file', 
                    'url' => $url,
                    'php_error' => error_get_last()
                ], 404);
            }
            
            // Determine content type (default to audio/mpeg)
            $contentType = 'audio/mpeg';
            
            // If URL ends with a specific extension, set appropriate content type
            if (str_ends_with(strtolower($url), '.mp3')) {
                $contentType = 'audio/mpeg';
            } elseif (str_ends_with(strtolower($url), '.wav')) {
                $contentType = 'audio/wav';
            } elseif (str_ends_with(strtolower($url), '.ogg')) {
                $contentType = 'audio/ogg';
            } elseif (str_ends_with(strtolower($url), '.aac')) {
                $contentType = 'audio/aac';
            }
            
            // Return the audio file with appropriate headers
            return response($content)
                ->header('Content-Type', $contentType)
                ->header('Access-Control-Allow-Origin', '*')
                ->header('Cache-Control', 'public, max-age=86400'); // Cache for 1 day
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Error processing audio file',
                'message' => $e->getMessage(),
                'url' => $url
            ], 500);
        }
    }
}
