import React from 'react';
import { Modal } from 'antd';
import VoiceRecorderWidget from './VoiceRecorderWidget';
import { FaMicrophone } from 'react-icons/fa';
import '../assets/scss/components/voice-recording-modal.scss';

/**
 * Modal for recording voice messages
 *
 * @param {Object} props - Component props
 * @param {boolean} props.visible - Whether the modal is visible
 * @param {Function} props.onClose - Callback when the modal is closed
 * @param {Function} props.onComplete - Callback when recording is complete
 */
const VoiceRecordingModal = ({ visible, onClose, onComplete }) => {
  // Handle recording complete
  const handleRecordingComplete = (audioBlob, duration) => {
    console.log('VoiceRecordingModal: handleRecordingComplete called with:', {
      audioBlobExists: !!audioBlob,
      audioBlobSize: audioBlob?.size,
      duration
    });

    try {
      // If audioBlob is null and duration is 0, it means there was an error
      if (!audioBlob && duration === 0) {
        console.log('VoiceRecordingModal: Recording failed or was cancelled');
        onClose(); // Close the modal
        return;
      }

      onComplete(audioBlob, duration);
      console.log('VoiceRecordingModal: onComplete callback executed successfully');
    } catch (error) {
      console.error('VoiceRecordingModal: Error in onComplete callback:', error);
      onClose(); // Close the modal on error
    }
  };

  return (
    <Modal
      title={<div className="voice-recording-modal__title"><FaMicrophone /> Record Voice Message</div>}
      visible={visible}
      onCancel={onClose}
      footer={null}
      centered
      className="voice-recording-modal"
      width={400}
    >
      <div className="voice-recording-modal__content">
        <VoiceRecorderWidget
          onRecordingComplete={handleRecordingComplete}
          whatsAppStyle={true}
          autoStart={true}
        />
      </div>
    </Modal>
  );
};

export default VoiceRecordingModal;
