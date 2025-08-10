import { Row, Col, Card, Form, Input, Button } from 'antd';
import { useTranslation } from 'react-i18next';
import { shallowEqual, useSelector } from 'react-redux';
import TextArea from 'antd/es/input/TextArea';
import { useState, useRef, useEffect } from 'react';
import { FaMicrophone, FaPlay, FaPause, FaTrash } from 'react-icons/fa';
import VoiceRecordingModal from 'components/VoiceRecordingModal';
import AudioWaveform from 'components/AudioWaveform';

const BasicInfo = ({ loading = false, form }) => {
  const { t } = useTranslation();
  const { defaultLang, languages } = useSelector(
    (state) => state.formLang,
    shallowEqual,
  );
  const [voiceModalVisible, setVoiceModalVisible] = useState(false);
  const [voiceNoteUrl, setVoiceNoteUrl] = useState(null);
  const [voiceNoteBlob, setVoiceNoteBlob] = useState(null);
  const [isPlaying, setIsPlaying] = useState(false);
  const audioRef = useRef(null);

  // Handle voice note recording complete
  const handleVoiceNoteRecorded = (blob, duration) => {
    console.log('handleVoiceNoteRecorded called with:', {
      blobExists: !!blob,
      blobSize: blob?.size,
      blobType: blob?.type,
      duration
    });

    // Set duration state for the waveform
    setDuration(duration || 1);

    if (!blob) {
      console.log('No blob provided, skipping voice note setup');
      return;
    }

    try {
      // Ensure the blob has the correct MIME type for AWS S3
      let finalBlob = blob;

      // If the blob is not MP3, convert it to MP3 format
      if (blob.type !== 'audio/mpeg') {
        console.log('Converting blob to MP3 format for AWS S3 compatibility');
        finalBlob = new Blob([blob], { type: 'audio/mpeg' });
      }

      // Create a blob URL for the audio
      const blobUrl = URL.createObjectURL(finalBlob);
      console.log('Created voice note blob URL:', blobUrl);

      // Set the blob and URL
      setVoiceNoteBlob(finalBlob);
      setVoiceNoteUrl(blobUrl);

      // Update form values with the blob and duration
      form.setFieldsValue({
        voice_note: {
          blob: finalBlob,
          duration: duration || 1,
        }
      });

      // Set up audio element for playback
      if (audioRef.current) {
        audioRef.current.src = blobUrl;
        audioRef.current.load();

        // Test if the audio is playable
        const testPlayPromise = audioRef.current.play();
        if (testPlayPromise !== undefined) {
          testPlayPromise
            .then(() => {
              // Audio is playable, pause it immediately
              console.log('Voice note is playable');
              audioRef.current.pause();
              audioRef.current.currentTime = 0;
            })
            .catch(error => {
              console.error('Voice note playback test failed:', error);
              // The audio might still be valid, just not playable in this context
            });
        }

        // Set up event handlers
        audioRef.current.onended = () => {
          setIsPlaying(false);
          setCurrentPosition(0);
        };

        audioRef.current.ontimeupdate = () => {
          setCurrentPosition(audioRef.current.currentTime);
        };
      }
    } catch (error) {
      console.error('Error handling voice note recording:', error);

      // Show error message to user
      alert('Error processing voice note. Please try again.');
    }
  };

  const [currentPosition, setCurrentPosition] = useState(0);
  const [duration, setDuration] = useState(0);

  // Play/pause voice note
  const togglePlayVoiceNote = () => {
    if (!audioRef.current) return;

    if (isPlaying) {
      audioRef.current.pause();
      setIsPlaying(false);
    } else {
      try {
        // First, make sure the audio element is properly set up
        if (!audioRef.current.src && voiceNoteUrl) {
          audioRef.current.src = voiceNoteUrl;
          audioRef.current.load();
        }

        // Play the audio with proper error handling
        const playPromise = audioRef.current.play();

        if (playPromise !== undefined) {
          playPromise
            .then(() => {
              console.log('Voice note playback started successfully');
              setIsPlaying(true);
            })
            .catch(error => {
              console.error('Error playing voice note:', error);

              // Try creating a new blob URL as a fallback
              if (voiceNoteBlob) {
                console.log('Trying to create a new blob URL');
                const newUrl = URL.createObjectURL(voiceNoteBlob);
                audioRef.current.src = newUrl;
                audioRef.current.load();

                audioRef.current.play()
                  .then(() => {
                    console.log('Voice note playback started with new URL');
                    setIsPlaying(true);
                  })
                  .catch(secondError => {
                    console.error('Error playing voice note with new URL:', secondError);
                    setIsPlaying(false);
                  });
              } else {
                setIsPlaying(false);
              }
            });
        } else {
          // For older browsers that don't return a promise
          setIsPlaying(true);
        }
      } catch (error) {
        console.error('Error in togglePlayVoiceNote:', error);
        setIsPlaying(false);
      }
    }
  };

  // Update audio position
  useEffect(() => {
    if (audioRef.current) {
      const updatePosition = () => {
        setCurrentPosition(audioRef.current.currentTime);
      };

      const handleDurationChange = () => {
        setDuration(audioRef.current.duration);
      };

      const handleEnded = () => {
        setIsPlaying(false);
        setCurrentPosition(0);
      };

      audioRef.current.addEventListener('timeupdate', updatePosition);
      audioRef.current.addEventListener('durationchange', handleDurationChange);
      audioRef.current.addEventListener('ended', handleEnded);

      return () => {
        if (audioRef.current) {
          audioRef.current.removeEventListener('timeupdate', updatePosition);
          audioRef.current.removeEventListener('durationchange', handleDurationChange);
          audioRef.current.removeEventListener('ended', handleEnded);
        }
      };
    }
  }, [audioRef.current]);

  // Format time for display
  const formatTime = (timeInSeconds) => {
    const minutes = Math.floor(timeInSeconds / 60);
    const seconds = Math.floor(timeInSeconds % 60);
    return `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
  };

  // Delete voice note
  const deleteVoiceNote = () => {
    setVoiceNoteUrl(null);
    setVoiceNoteBlob(null);
    setIsPlaying(false);
    setCurrentPosition(0);
    setDuration(0);
    form.setFieldsValue({
      voice_note: null,
    });
  };

  return (
    <Card title={t('basic.info')} loading={loading}>
      <Row gutter={12}>
        <Col span={24}>
          {languages.map((item) => (
            <Form.Item
              label={t('name')}
              name={`title[${item?.locale || 'en'}]`}
              key={item?.locale}
              hidden={item?.locale !== defaultLang}
              rules={[
                {
                  required: item?.locale === defaultLang,
                  message: t('required'),
                },
                {
                  type: 'string',
                  min: 12,
                  max: 255,
                  message: t('min.12.max.255.chars'),
                },
              ]}
            >
              <Input />
            </Form.Item>
          ))}
        </Col>
        <Col span={24}>
          {languages.map((item) => (
            <Form.Item
              label={t('description')}
              name={`description[${item?.locale || 'en'}]`}
              key={item?.locale}
              hidden={item?.locale !== defaultLang}
              rules={[
                {
                  required: false,
                  message: t('required'),
                },
                {
                  type: 'string',
                  min: 2,
                  message: t('min.2.chars'),
                },
              ]}
            >
              <TextArea rows={2} />
            </Form.Item>
          ))}
        </Col>

        {/* Voice Note field */}
        <Col span={24}>
          <Form.Item
            label={t('voice.note')}
            name="voice_note"
            rules={[
              {
                required: false,
              },
            ]}
          >
            <div className="voice-note-container">
              {!voiceNoteUrl ? (
                <Button
                  type="primary"
                  icon={<FaMicrophone />}
                  onClick={() => setVoiceModalVisible(true)}
                >
                  {t('record.voice.note')}
                </Button>
              ) : (
                <div className="voice-note-container">
                  <div className="voice-note-player">
                    {/* Audio element */}
                    <audio
                      ref={audioRef}
                      style={{ display: 'none' }}
                      preload="auto"
                      controls={false}
                      onEnded={() => setIsPlaying(false)}
                      onTimeUpdate={() => audioRef.current && setCurrentPosition(audioRef.current.currentTime)}
                      onError={(e) => console.error('Audio element error:', e)}
                      onCanPlay={() => console.log('Audio can play')}
                      onLoadedData={() => console.log('Audio data loaded')}
                      onLoadedMetadata={() => {
                        console.log('Audio metadata loaded, duration:', audioRef.current?.duration);
                        if (audioRef.current?.duration) {
                          setDuration(audioRef.current.duration);
                        }
                      }}
                    />
                    <Button
                      type="link"
                      icon={isPlaying ? <FaPause /> : <FaPlay />}
                      onClick={togglePlayVoiceNote}
                      size="large"
                    />

                    <div className="voice-note-waveform-container">
                      <div className="voice-note-waveform">
                        <AudioWaveform
                          durationSeconds={duration || 1}
                          color="#ffffff"
                          isPlaying={isPlaying}
                          currentPosition={currentPosition}
                        />
                      </div>
                    </div>

                    <div className="voice-note-duration">
                      {formatTime(currentPosition)} / {formatTime(duration || 0)}
                    </div>
                  </div>

                  <Button
                    danger
                    icon={<FaTrash />}
                    onClick={deleteVoiceNote}
                  />
                </div>
              )}
            </div>
          </Form.Item>
        </Col>
      </Row>

      {/* Voice Recording Modal */}
      <VoiceRecordingModal
        visible={voiceModalVisible}
        onClose={() => setVoiceModalVisible(false)}
        onComplete={(blob, duration) => {
          handleVoiceNoteRecorded(blob, duration);
          setVoiceModalVisible(false);
        }}
      />
    </Card>
  );
};

export default BasicInfo;
