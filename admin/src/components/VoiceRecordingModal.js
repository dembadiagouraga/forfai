import React, { useState } from 'react';
import { Modal } from 'antd';
import { FaMicrophone } from 'react-icons/fa';
import RecordRTCVoiceRecorder from './RecordRTCVoiceRecorder';
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
  // 🔧 ADD UPLOAD STATE MANAGEMENT
  const [isUploading, setIsUploading] = useState(false);

  // Handle recording complete
  const handleRecordingComplete = async (audioBlob, duration) => {
    console.log('VoiceRecordingModal: handleRecordingComplete called with:', {
      audioBlobExists: !!audioBlob,
      audioBlobSize: audioBlob?.size,
      audioBlobType: audioBlob?.type,
      duration
    });

    // If no blob was provided, close modal and return early
    if (!audioBlob) {
      console.warn('VoiceRecordingModal: No audio blob provided');
      onClose();
      return;
    }

    // 🔧 SET UPLOADING STATE TO PREVENT MODAL CLOSING
    setIsUploading(true);

    try {
      // Convert to number and use actual duration
      const durationNum = typeof duration === 'number' ? duration : parseInt(duration) || 0;

      console.log('VoiceRecordingModal: Using actual duration:', durationNum, 'from original:', duration);

      // Log the final blob details
      console.log('VoiceRecordingModal: Final blob details:', {
        exists: !!audioBlob,
        size: audioBlob?.size,
        type: audioBlob?.type,
        duration: durationNum
      });

      // Call the onComplete callback with the actual blob and duration
      if (onComplete) {
        // 🔧 CRITICAL FIX: Don't await the onComplete callback to prevent blocking
        // This ensures the modal closes immediately after starting the upload process
        onComplete(audioBlob, durationNum).catch(error => {
          console.error('VoiceRecordingModal: Error in onComplete callback:', error);
        });
        console.log('VoiceRecordingModal: onComplete callback initiated');
      }
    } catch (error) {
      console.error('VoiceRecordingModal: Error during upload:', error);
    } finally {
      // 🔧 RESET UPLOADING STATE AND CLOSE MODAL IMMEDIATELY
      setIsUploading(false);
      console.log('VoiceRecordingModal: Closing modal now');
      onClose();
    }
  };

  return (
    <Modal
      title={<div className="voice-recording-modal__title"><FaMicrophone /> Record Voice Note</div>}
      visible={visible}
      onCancel={() => {
        // 🔧 PREVENT CLOSING DURING UPLOAD
        if (isUploading) {
          console.log('Upload in progress, preventing modal close');
          return;
        }

        // Make sure to stop any ongoing recording before closing
        console.log('Modal closing, ensuring recording is stopped');
        onClose();
      }}
      maskClosable={!isUploading} // Prevent accidental closing during upload
      keyboard={!isUploading} // Prevent closing with ESC key during upload
      destroyOnClose={false} // 🔧 CRITICAL FIX: Don't destroy component during upload
      footer={null}
      centered
      className="voice-recording-modal"
      width={400}
    >
      <div className="voice-recording-modal__content">
        <RecordRTCVoiceRecorder
          onRecordingComplete={handleRecordingComplete}
          whatsAppStyle={true}
          autoStart={true}
        />
      </div>
    </Modal>
  );
};

export default VoiceRecordingModal;
