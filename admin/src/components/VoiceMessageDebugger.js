import React, { useState } from 'react';
import VoiceMessageTester from '../utils/voiceMessageTester';

/**
 * 🔧 Voice Message CORS Debugger Component
 * Add this component to any page for immediate CORS testing
 */
const VoiceMessageDebugger = () => {
  const [testUrl, setTestUrl] = useState('');
  const [testResults, setTestResults] = useState(null);
  const [isLoading, setIsLoading] = useState(false);

  const runTest = async () => {
    if (!testUrl) {
      alert('Please enter a voice message URL');
      return;
    }

    setIsLoading(true);
    setTestResults(null);

    try {
      const tester = new VoiceMessageTester();
      const results = await tester.testVoiceMessage(testUrl);
      setTestResults(results);
    } catch (error) {
      console.error('Test error:', error);
      setTestResults({ error: error.message });
    } finally {
      setIsLoading(false);
    }
  };

  const runQuickTest = async () => {
    if (!testUrl) {
      alert('Please enter a voice message URL');
      return;
    }

    setIsLoading(true);
    
    try {
      const isWorking = await VoiceMessageTester.quickTest(testUrl);
      alert(isWorking ? '✅ Quick Test: SUCCESS!' : '❌ Quick Test: FAILED');
    } catch (error) {
      alert(`❌ Quick Test Error: ${error.message}`);
    } finally {
      setIsLoading(false);
    }
  };

  const testS3Sample = () => {
    setTestUrl('https://forfai-media.s3.eu-north-1.amazonaws.com/media/voice_messages/AXvrtwzZN7W9bM9PvTAA/1752864904_687a988002a1.wav');
  };

  return (
    <div style={{ 
      position: 'fixed', 
      top: '10px', 
      right: '10px', 
      background: 'white', 
      border: '2px solid #007bff', 
      borderRadius: '8px', 
      padding: '15px', 
      zIndex: 9999,
      maxWidth: '400px',
      boxShadow: '0 4px 8px rgba(0,0,0,0.1)'
    }}>
      <h4 style={{ margin: '0 0 10px 0', color: '#007bff' }}>
        🔧 Voice Message CORS Debugger
      </h4>
      
      <div style={{ marginBottom: '10px' }}>
        <input
          type="text"
          placeholder="Enter voice message URL..."
          value={testUrl}
          onChange={(e) => setTestUrl(e.target.value)}
          style={{ 
            width: '100%', 
            padding: '8px', 
            border: '1px solid #ddd', 
            borderRadius: '4px',
            fontSize: '12px'
          }}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <button 
          onClick={testS3Sample}
          style={{ 
            padding: '6px 12px', 
            marginRight: '5px', 
            backgroundColor: '#28a745', 
            color: 'white', 
            border: 'none', 
            borderRadius: '4px',
            fontSize: '12px',
            cursor: 'pointer'
          }}
        >
          Use S3 Sample
        </button>
        
        <button 
          onClick={runQuickTest}
          disabled={isLoading}
          style={{ 
            padding: '6px 12px', 
            marginRight: '5px', 
            backgroundColor: '#ffc107', 
            color: 'black', 
            border: 'none', 
            borderRadius: '4px',
            fontSize: '12px',
            cursor: 'pointer'
          }}
        >
          {isLoading ? 'Testing...' : 'Quick Test'}
        </button>
        
        <button 
          onClick={runTest}
          disabled={isLoading}
          style={{ 
            padding: '6px 12px', 
            backgroundColor: '#007bff', 
            color: 'white', 
            border: 'none', 
            borderRadius: '4px',
            fontSize: '12px',
            cursor: 'pointer'
          }}
        >
          {isLoading ? 'Testing...' : 'Full Test'}
        </button>
      </div>

      {testResults && (
        <div style={{ 
          marginTop: '10px', 
          padding: '10px', 
          backgroundColor: '#f8f9fa', 
          borderRadius: '4px',
          fontSize: '12px'
        }}>
          {testResults.error ? (
            <div style={{ color: 'red' }}>
              ❌ Error: {testResults.error}
            </div>
          ) : (
            <div>
              <div style={{ fontWeight: 'bold', marginBottom: '5px' }}>
                📊 Test Results:
              </div>
              <div>Total: {testResults.total}</div>
              <div style={{ color: 'green' }}>✅ Successful: {testResults.successful}</div>
              <div style={{ color: 'red' }}>❌ Failed: {testResults.failed}</div>
              <div style={{ marginTop: '5px', fontWeight: 'bold' }}>
                💡 Recommendation: {testResults.recommendation}
              </div>
              
              {testResults.results && testResults.results.length > 0 && (
                <div style={{ marginTop: '10px' }}>
                  <div style={{ fontWeight: 'bold', marginBottom: '5px' }}>
                    📋 Detailed Results:
                  </div>
                  {testResults.results.map((result, index) => (
                    <div key={index} style={{ 
                      marginBottom: '3px',
                      padding: '3px',
                      backgroundColor: result.success ? '#d4edda' : '#f8d7da',
                      borderRadius: '3px'
                    }}>
                      {result.success ? '✅' : '❌'} {result.test}: {result.status || result.error}
                    </div>
                  ))}
                </div>
              )}
            </div>
          )}
        </div>
      )}

      <div style={{ 
        marginTop: '10px', 
        fontSize: '11px', 
        color: '#666',
        borderTop: '1px solid #eee',
        paddingTop: '8px'
      }}>
        💡 <strong>Usage:</strong> Enter a voice message URL and click "Full Test" to diagnose CORS issues.
        Check browser console for detailed logs.
      </div>
    </div>
  );
};

export default VoiceMessageDebugger;
