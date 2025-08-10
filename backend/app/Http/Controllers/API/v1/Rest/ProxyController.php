<?php

namespace App\Http\Controllers\API\v1\Rest;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class ProxyController extends Controller
{
    /**
     * Proxy audio file from S3 or other external URL
     * 
     * @param Request $request
     * @return \Illuminate\Http\Response
     */
    public function proxyAudio(Request $request)
    {
        // Get the URL from the request
        $url = $request->query('url');
        
        // Log the request for debugging
        Log::info('ProxyController: Audio proxy request received', [
            'url' => $url,
            'ip' => $request->ip(),
            'user_agent' => $request->header('User-Agent')
        ]);
        
        // Validate the URL
        if (empty($url)) {
            Log::error('ProxyController: Empty URL provided');
            return response('Invalid URL', 400);
        }
        
        // For testing - if a dummy URL is provided, return a sample audio file
        $sampleAudioPath = public_path('sample-audio.mp3');
        if ($url === 'https://example.com/dummy-voice-message.mp3') {
            Log::info('ProxyController: Returning sample audio for dummy URL');
            return response(file_get_contents($sampleAudioPath))
                ->header('Content-Type', 'audio/mpeg')
                ->header('Access-Control-Allow-Origin', '*');
        }
        
        try {
            // Check if URL is from S3
            $isS3Url = strpos($url, 'amazonaws.com') !== false;
            
            // Log the URL type
            Log::info('ProxyController: URL type', [
                'is_s3_url' => $isS3Url,
                'url' => $url
            ]);
            
            // Create a new HTTP client
            $client = new \GuzzleHttp\Client([
                'verify' => false, // Disable SSL verification for development
                'timeout' => 10,   // Set a timeout
                'headers' => [
                    'User-Agent' => $request->header('User-Agent', 'ForfaiProxy/1.0'),
                ]
            ]);
            
            // Make the request to the external URL
            $response = $client->get($url);
            
            // Get the content type from the response
            $contentType = $response->getHeaderLine('Content-Type');
            if (empty($contentType) || strpos($contentType, 'audio/') === false) {
                // If content type is not audio, try to determine from URL
                if (preg_match('/\.(mp3|aac|wav|m4a|ogg)($|\?)/i', $url, $matches)) {
                    switch (strtolower($matches[1])) {
                        case 'mp3':
                            $contentType = 'audio/mpeg';
                            break;
                        case 'aac':
                            $contentType = 'audio/aac';
                            break;
                        case 'wav':
                            $contentType = 'audio/wav';
                            break;
                        case 'm4a':
                            $contentType = 'audio/mp4';
                            break;
                        case 'ogg':
                            $contentType = 'audio/ogg';
                            break;
                        default:
                            $contentType = 'audio/mpeg';
                    }
                } else {
                    $contentType = 'audio/mpeg'; // Default to MP3
                }
            }
            
            // Log the content type
            Log::info('ProxyController: Content type determined', [
                'content_type' => $contentType
            ]);
            
            // Get the body content
            $body = (string) $response->getBody();
            
            // Return the response with appropriate headers
            return response($body)
                ->header('Content-Type', $contentType)
                ->header('Access-Control-Allow-Origin', '*')
                ->header('Cache-Control', 'public, max-age=86400'); // Cache for 24 hours
                
        } catch (\Exception $e) {
            // Log the error
            Log::error('ProxyController: Error proxying audio', [
                'url' => $url,
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            
            // Return an error response
            return response('Error proxying audio: ' . $e->getMessage(), 500)
                ->header('Access-Control-Allow-Origin', '*');
        }
    }
}
