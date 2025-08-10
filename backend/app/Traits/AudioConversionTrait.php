<?php

namespace App\Traits;

use Illuminate\Support\Facades\Log;

trait AudioConversionTrait
{
    /**
     * Convert audio file to MP3 format using FFmpeg
     */
    protected function convertAudioToMp3($inputPath, $inputFormat)
    {
        try {
            Log::info("Starting audio conversion from {$inputFormat} to MP3");

            // Check if FFmpeg is available
            $ffmpegPath = $this->findFFmpegPath();
            if (!$ffmpegPath) {
                return [
                    'success' => false,
                    'error' => 'FFmpeg not found on system'
                ];
            }

            // Create temporary output file
            $tempDir = sys_get_temp_dir();
            $outputPath = $tempDir . '/converted_' . uniqid() . '.mp3';

            // Build FFmpeg command for high-quality MP3 conversion
            // -acodec libmp3lame: Use LAME MP3 encoder
            // -ab 128k: Audio bitrate 128kbps (matches customer side)
            // -ar 44100: Sample rate 44.1kHz (matches customer side)
            // -ac 1: Mono audio (matches customer side)
            // -f mp3: Force MP3 output format
            $command = sprintf(
                '%s -i %s -acodec libmp3lame -ab 128k -ar 44100 -ac 1 -f mp3 %s 2>&1',
                escapeshellarg($ffmpegPath),
                escapeshellarg($inputPath),
                escapeshellarg($outputPath)
            );

            Log::info("Executing FFmpeg command: " . $command);

            // Execute conversion
            $output = [];
            $returnCode = 0;
            exec($command, $output, $returnCode);

            if ($returnCode === 0 && file_exists($outputPath) && filesize($outputPath) > 0) {
                Log::info("Audio conversion successful. Output file size: " . filesize($outputPath) . " bytes");
                return [
                    'success' => true,
                    'converted_path' => $outputPath,
                    'output' => implode("\n", $output)
                ];
            } else {
                Log::error("Audio conversion failed. Return code: {$returnCode}");
                Log::error("FFmpeg output: " . implode("\n", $output));

                // Clean up failed conversion file
                if (file_exists($outputPath)) {
                    unlink($outputPath);
                }

                return [
                    'success' => false,
                    'error' => 'FFmpeg conversion failed',
                    'return_code' => $returnCode,
                    'output' => implode("\n", $output)
                ];
            }

        } catch (\Exception $e) {
            Log::error("Audio conversion exception: " . $e->getMessage());
            return [
                'success' => false,
                'error' => 'Conversion exception: ' . $e->getMessage()
            ];
        }
    }

    /**
     * Find FFmpeg executable path
     */
    protected function findFFmpegPath()
    {
        // Common FFmpeg paths for different operating systems
        $possiblePaths = [
            // Linux/Unix paths
            '/usr/bin/ffmpeg',
            '/usr/local/bin/ffmpeg',
            '/opt/homebrew/bin/ffmpeg',
            '/snap/bin/ffmpeg',
            // Windows paths
            'C:\\ffmpeg\\bin\\ffmpeg.exe',
            'C:\\Program Files\\ffmpeg\\bin\\ffmpeg.exe',
            'C:\\Program Files (x86)\\ffmpeg\\bin\\ffmpeg.exe',
            // System PATH
            'ffmpeg',
        ];

        foreach ($possiblePaths as $path) {
            if ($path === 'ffmpeg') {
                // Check if ffmpeg is in system PATH
                $output = [];
                $returnCode = 0;

                // Use different commands for Windows vs Unix
                if (PHP_OS_FAMILY === 'Windows') {
                    exec('where ffmpeg 2>nul', $output, $returnCode);
                } else {
                    exec('which ffmpeg 2>/dev/null', $output, $returnCode);
                }

                if ($returnCode === 0 && !empty($output[0])) {
                    Log::info("Found FFmpeg in system PATH: " . $output[0]);
                    return 'ffmpeg';
                }
            } else {
                // Check specific path
                if (file_exists($path) && is_executable($path)) {
                    Log::info("Found FFmpeg at: " . $path);
                    return $path;
                }
            }
        }

        Log::warning("FFmpeg not found in any common locations. Audio conversion will be skipped.");
        Log::info("To enable audio conversion, please install FFmpeg:");
        Log::info("- Windows: Download from https://ffmpeg.org/download.html");
        Log::info("- Ubuntu/Debian: sudo apt install ffmpeg");
        Log::info("- CentOS/RHEL: sudo yum install ffmpeg");
        Log::info("- macOS: brew install ffmpeg");

        return null;
    }

    /**
     * Detect if audio file needs conversion to MP3
     */
    protected function needsAudioConversion($extension, $mimeType = null)
    {
        $needsConversion = in_array(strtolower($extension), ['m4a', 'aac', 'webm', 'ogg']);

        // Also check MIME type for additional detection
        if ($mimeType) {
            $needsConversionMime = in_array($mimeType, [
                'audio/mp4',
                'audio/m4a',
                'audio/aac',
                'audio/webm',
                'audio/ogg'
            ]);
            $needsConversion = $needsConversion || $needsConversionMime;
        }

        return $needsConversion;
    }

    /**
     * Get audio format info for conversion
     */
    protected function getAudioFormatInfo($mimeType, $extension)
    {
        // Priority: MIME type first, then extension as fallback
        switch ($mimeType) {
            case 'audio/mpeg':
            case 'audio/mp3':
                return ['extension' => 'mp3', 'content_type' => 'audio/mpeg', 'needs_conversion' => false];

            case 'audio/aac':
            case 'audio/aacp':
            case 'audio/x-aac':
                return ['extension' => 'aac', 'content_type' => 'audio/aac', 'needs_conversion' => true];

            case 'audio/mp4':
            case 'audio/m4a':
                return ['extension' => 'm4a', 'content_type' => 'audio/mp4', 'needs_conversion' => true];

            case 'audio/wav':
            case 'audio/wave':
            case 'audio/x-wav':
                return ['extension' => 'wav', 'content_type' => 'audio/wav', 'needs_conversion' => false];

            case 'audio/ogg':
                return ['extension' => 'ogg', 'content_type' => 'audio/ogg', 'needs_conversion' => true];

            case 'audio/webm':
                return ['extension' => 'webm', 'content_type' => 'audio/webm', 'needs_conversion' => true];
        }

        // Fallback to extension
        switch (strtolower($extension)) {
            case 'mp3':
            case 'mpeg':
            case 'mpga':
                return ['extension' => 'mp3', 'content_type' => 'audio/mpeg', 'needs_conversion' => false];

            case 'aac':
                return ['extension' => 'aac', 'content_type' => 'audio/aac', 'needs_conversion' => true];

            case 'm4a':
            case 'mp4':
                return ['extension' => 'm4a', 'content_type' => 'audio/mp4', 'needs_conversion' => true];

            case 'wav':
                return ['extension' => 'wav', 'content_type' => 'audio/wav', 'needs_conversion' => false];

            case 'ogg':
                return ['extension' => 'ogg', 'content_type' => 'audio/ogg', 'needs_conversion' => true];

            case 'webm':
                return ['extension' => 'webm', 'content_type' => 'audio/webm', 'needs_conversion' => true];

            default:
                // Default fallback - assume MP3 for compatibility
                Log::warning("Unknown audio format: MIME={$mimeType}, Extension={$extension}. Defaulting to MP3.");
                return ['extension' => 'mp3', 'content_type' => 'audio/mpeg', 'needs_conversion' => false];
        }
    }
}
