import React from 'react';
import { FaPlay, FaPause, FaUpload, FaExclamationTriangle, FaRedo } from 'react-icons/fa';
import { Spin } from 'antd';
import { LoadingOutlined } from '@ant-design/icons';

/**
 * Upload progress states for voice messages
 */
export const UPLOAD_STATES = {
  UPLOADING: 'uploading',
  SUCCESS: 'success', 
  FAILED: 'failed',
  RETRYING: 'retrying'
};

/**
 * Component for showing voice message upload progress and states
 * 
 * @param {Object} props - Component props
 * @param {string} props.uploadState - Current upload state (uploading, success, failed, retrying)
 * @param {number} props.uploadProgress - Upload progress percentage (0-100)
 * @param {boolean} props.isPlaying - Whether audio is currently playing
 * @param {Function} props.onPlayPause - Callback for play/pause button click
 * @param {Function} props.onRetry - Callback for retry button click
 * @param {boolean} props.disabled - Whether the button should be disabled
 */
const VoiceUploadProgress = ({
  uploadState = UPLOAD_STATES.SUCCESS,
  uploadProgress = 0,
  isPlaying = false,
  onPlayPause,
  onRetry,
  disabled = false
}) => {
  
  // Custom loading icon for upload progress
  const uploadingIcon = <LoadingOutlined style={{ fontSize: 16, color: 'inherit' }} spin />;

  const renderButtonContent = () => {
    switch (uploadState) {
      case UPLOAD_STATES.UPLOADING:
        return (
          <div className="voice-upload-progress__uploading">
            <div className="voice-upload-progress__upload-indicator">
              <Spin 
                indicator={uploadingIcon} 
                size="small"
              />
              <FaUpload className="voice-upload-progress__upload-icon" />
            </div>
            {uploadProgress > 0 && (
              <div className="voice-upload-progress__progress-ring">
                <svg className="voice-upload-progress__progress-svg" viewBox="0 0 36 36">
                  <path
                    className="voice-upload-progress__progress-bg"
                    d="M18 2.0845
                      a 15.9155 15.9155 0 0 1 0 31.831
                      a 15.9155 15.9155 0 0 1 0 -31.831"
                  />
                  <path
                    className="voice-upload-progress__progress-bar"
                    strokeDasharray={`${uploadProgress}, 100`}
                    d="M18 2.0845
                      a 15.9155 15.9155 0 0 1 0 31.831
                      a 15.9155 15.9155 0 0 1 0 -31.831"
                  />
                </svg>
                <span className="voice-upload-progress__percentage">
                  {Math.round(uploadProgress)}%
                </span>
              </div>
            )}
          </div>
        );

      case UPLOAD_STATES.RETRYING:
        return (
          <div className="voice-upload-progress__retrying">
            <div className="voice-upload-progress__retry-indicator">
              <Spin 
                indicator={uploadingIcon} 
                size="small"
              />
              <FaRedo className="voice-upload-progress__retry-spinning" />
            </div>
          </div>
        );

      case UPLOAD_STATES.FAILED:
        return (
          <div className="voice-upload-progress__failed">
            <FaExclamationTriangle className="voice-upload-progress__error-icon" />
            <FaRedo 
              className="voice-upload-progress__retry-icon"
              title="Click to retry upload"
            />
          </div>
        );

      case UPLOAD_STATES.SUCCESS:
      default:
        return (
          <div className="voice-upload-progress__success">
            {isPlaying ? <FaPause /> : <FaPlay />}
          </div>
        );
    }
  };

  const handleClick = () => {
    if (disabled) return;

    switch (uploadState) {
      case UPLOAD_STATES.FAILED:
        if (onRetry) onRetry();
        break;
      
      case UPLOAD_STATES.SUCCESS:
        if (onPlayPause) onPlayPause();
        break;
      
      case UPLOAD_STATES.UPLOADING:
      case UPLOAD_STATES.RETRYING:
      default:
        // Do nothing during upload states
        break;
    }
  };

  const getButtonClass = () => {
    const baseClass = 'voice-upload-progress__button';
    const stateClass = `voice-upload-progress__button--${uploadState}`;
    const disabledClass = disabled ? 'voice-upload-progress__button--disabled' : '';
    
    return `${baseClass} ${stateClass} ${disabledClass}`.trim();
  };

  const getAriaLabel = () => {
    switch (uploadState) {
      case UPLOAD_STATES.UPLOADING:
        return `Uploading voice message... ${Math.round(uploadProgress)}%`;
      case UPLOAD_STATES.RETRYING:
        return 'Retrying upload...';
      case UPLOAD_STATES.FAILED:
        return 'Upload failed. Click to retry';
      case UPLOAD_STATES.SUCCESS:
      default:
        return isPlaying ? 'Pause voice message' : 'Play voice message';
    }
  };

  return (
    <button
      className={getButtonClass()}
      onClick={handleClick}
      disabled={disabled || uploadState === UPLOAD_STATES.UPLOADING || uploadState === UPLOAD_STATES.RETRYING}
      aria-label={getAriaLabel()}
      title={getAriaLabel()}
    >
      {renderButtonContent()}
    </button>
  );
};

export default VoiceUploadProgress;
