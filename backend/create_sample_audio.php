<?php

// Create a directory for the sample audio file
$directory = __DIR__ . '/storage/app/public';
if (!file_exists($directory)) {
    mkdir($directory, 0777, true);
}

// Path to the sample audio file
$sampleAudioPath = $directory . '/sample_audio.mp3';

// Create a simple MP3 file (this is just a placeholder, not a real MP3)
// In a real scenario, you would use a library to generate a proper MP3 file
$mp3Header = hex2bin('FFFB9064000420000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
$mp3Data = str_repeat($mp3Header, 100); // Repeat the header to create a larger file

// Write the MP3 data to the file
file_put_contents($sampleAudioPath, $mp3Data);

echo "Sample audio file created at: $sampleAudioPath\n";
echo "File size: " . filesize($sampleAudioPath) . " bytes\n";
