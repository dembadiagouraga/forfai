import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import '@testing-library/jest-dom';
import VoiceMessageBubble from '../VoiceMessageBubble';

// Mock fetch
global.fetch = jest.fn();

// Mock AudioPlayer component
jest.mock('../AudioPlayer', () => {
  return function MockAudioPlayer({ audioUrl, duration, onError }) {
    return (
      <div data-testid="audio-player">
        <div>Audio URL: {audioUrl}</div>
        <div>Duration: {duration}</div>
        <button onClick={() => onError && onError(new Error('Test error'))}>
          Trigger Error
        </button>
      </div>
    );
  };
});

describe('VoiceMessageBubble', () => {
  beforeEach(() => {
    // Reset mocks
    global.fetch.mockReset();
    
    // Mock successful fetch by default
    global.fetch.mockResolvedValue({
      ok: true,
      status: 200
    });
  });

  test('renders loading state initially', () => {
    render(<VoiceMessageBubble audioUrl="https://example.com/test.mp3" duration={10} />);
    
    expect(screen.getByText('Loading audio...')).toBeInTheDocument();
  });

  test('renders AudioPlayer when URL is valid and accessible', async () => {
    render(<VoiceMessageBubble audioUrl="https://example.com/test.mp3" duration={10} />);
    
    await waitFor(() => {
      expect(screen.getByTestId('audio-player')).toBeInTheDocument();
    });
    
    expect(screen.getByText('Audio URL: https://example.com/test.mp3')).toBeInTheDocument();
    expect(screen.getByText('Duration: 10')).toBeInTheDocument();
  });

  test('converts AAC URL to MP3', async () => {
    render(<VoiceMessageBubble audioUrl="https://example.com/test.aac" duration={10} />);
    
    await waitFor(() => {
      expect(screen.getByTestId('audio-player')).toBeInTheDocument();
    });
    
    expect(screen.getByText('Audio URL: https://example.com/test.mp3')).toBeInTheDocument();
  });

  test('shows error when URL is not accessible', async () => {
    // Mock failed fetch
    global.fetch.mockResolvedValue({
      ok: false,
      status: 404
    });
    
    render(<VoiceMessageBubble audioUrl="https://example.com/not-found.mp3" duration={10} />);
    
    await waitFor(() => {
      expect(screen.getByText('Error loading audio file')).toBeInTheDocument();
    });
  });

  test('shows error when URL is invalid', async () => {
    render(<VoiceMessageBubble audioUrl="invalid-url" duration={10} />);
    
    await waitFor(() => {
      expect(screen.getByText('Invalid URL format: invalid-url')).toBeInTheDocument();
    });
  });

  test('shows error when no URL is provided', async () => {
    render(<VoiceMessageBubble audioUrl="" duration={10} />);
    
    await waitFor(() => {
      expect(screen.getByText('No audio URL provided')).toBeInTheDocument();
    });
  });

  test('handles error from AudioPlayer', async () => {
    render(<VoiceMessageBubble audioUrl="https://example.com/test.mp3" duration={10} />);
    
    await waitFor(() => {
      expect(screen.getByTestId('audio-player')).toBeInTheDocument();
    });
    
    // Trigger error from AudioPlayer
    fireEvent.click(screen.getByText('Trigger Error'));
    
    await waitFor(() => {
      expect(screen.getByText('Error loading audio file')).toBeInTheDocument();
    });
  });
});
