/**
 * 🔍 COMPREHENSIVE VOICE MESSAGE DIAGNOSTIC TOOL
 * Deep analysis and debugging utility for voice message loading issues
 */

export class VoiceMessageDiagnostic {
  
  /**
   * Run comprehensive diagnostic on a voice message
   * @param {Object} message - Voice message object from Firebase
   * @param {string} audioUrl - S3 URL of the voice message
   * @param {number} duration - Duration from Firebase
   */
  static async runComprehensiveDiagnostic(message, audioUrl, duration) {
    console.group('🔍 COMPREHENSIVE VOICE MESSAGE DIAGNOSTIC');
    console.log('📋 Message Details:', {
      id: message.id,
      audioUrl,
      duration,
      type: message.type,
      senderId: message.senderId,
      time: message.time
    });

    const diagnosticResults = {
      messageId: message.id,
      audioUrl,
      duration,
      tests: {},
      issues: [],
      recommendations: []
    };

    // Test 1: URL Accessibility
    console.log('\n🌐 Test 1: URL Accessibility');
    try {
      const response = await fetch(audioUrl, { 
        method: 'HEAD',
        mode: 'cors',
        cache: 'no-cache'
      });
      
      diagnosticResults.tests.urlAccessibility = {
        passed: response.ok,
        status: response.status,
        statusText: response.statusText,
        headers: {
          contentType: response.headers.get('content-type'),
          contentLength: response.headers.get('content-length'),
          corsOrigin: response.headers.get('access-control-allow-origin')
        }
      };

      if (response.ok) {
        console.log('✅ URL is accessible');
        console.log('📄 Content-Type:', response.headers.get('content-type'));
        console.log('📏 Content-Length:', response.headers.get('content-length'));
      } else {
        console.error('❌ URL not accessible:', response.status, response.statusText);
        diagnosticResults.issues.push('URL_NOT_ACCESSIBLE');
      }
    } catch (error) {
      console.error('❌ URL accessibility test failed:', error);
      diagnosticResults.tests.urlAccessibility = { passed: false, error: error.message };
      diagnosticResults.issues.push('URL_FETCH_ERROR');
    }

    // Test 2: Duration Validation
    console.log('\n⏱️ Test 2: Duration Validation');
    if (duration <= 1) {
      console.error('❌ Invalid duration detected:', duration);
      diagnosticResults.tests.durationValidation = { 
        passed: false, 
        duration,
        issue: 'Duration <= 1 second indicates metadata corruption'
      };
      diagnosticResults.issues.push('INVALID_DURATION');
      diagnosticResults.recommendations.push('Re-upload voice message or fix backend duration extraction');
    } else {
      console.log('✅ Duration is valid:', duration, 'seconds');
      diagnosticResults.tests.durationValidation = { passed: true, duration };
    }

    // Test 3: Audio Format Analysis
    console.log('\n🎵 Test 3: Audio Format Analysis');
    const fileExtension = audioUrl.split('.').pop().toLowerCase();
    const supportedFormats = ['mp3', 'wav', 'm4a', 'aac', 'ogg'];
    
    if (supportedFormats.includes(fileExtension)) {
      console.log('✅ Audio format is supported:', fileExtension);
      diagnosticResults.tests.formatValidation = { passed: true, format: fileExtension };
    } else {
      console.warn('⚠️ Unsupported or unknown audio format:', fileExtension);
      diagnosticResults.tests.formatValidation = { passed: false, format: fileExtension };
      diagnosticResults.issues.push('UNSUPPORTED_FORMAT');
    }

    // Test 4: Howler.js Compatibility Test
    console.log('\n🎧 Test 4: Howler.js Compatibility Test');
    try {
      const { Howl } = await import('howler');
      
      const testHowl = new Howl({
        src: [audioUrl],
        format: [fileExtension],
        html5: true,
        preload: false
      });

      // Test if Howler can create the instance
      diagnosticResults.tests.howlerCompatibility = { 
        passed: true, 
        instance: 'created successfully'
      };
      console.log('✅ Howler.js can create instance for this URL');

      // Clean up
      testHowl.unload();
    } catch (error) {
      console.error('❌ Howler.js compatibility test failed:', error);
      diagnosticResults.tests.howlerCompatibility = { passed: false, error: error.message };
      diagnosticResults.issues.push('HOWLER_COMPATIBILITY_ERROR');
    }

    // Test 5: S3 Metadata Analysis
    console.log('\n📊 Test 5: S3 Metadata Analysis');
    if (audioUrl.includes('amazonaws.com') || audioUrl.includes('s3.')) {
      // Extract S3 details
      const s3Match = audioUrl.match(/https:\/\/([^.]+)\.s3\.([^.]+)\.amazonaws\.com\/(.+)/);
      if (s3Match) {
        const [, bucket, region, key] = s3Match;
        console.log('🪣 S3 Bucket:', bucket);
        console.log('🌍 S3 Region:', region);
        console.log('🔑 S3 Key:', key);
        
        diagnosticResults.tests.s3Analysis = {
          passed: true,
          bucket,
          region,
          key,
          isS3Url: true
        };
      } else {
        console.warn('⚠️ S3 URL format not recognized');
        diagnosticResults.tests.s3Analysis = { passed: false, issue: 'Unrecognized S3 URL format' };
      }
    } else {
      console.log('ℹ️ Not an S3 URL');
      diagnosticResults.tests.s3Analysis = { passed: true, isS3Url: false };
    }

    // Generate Final Report
    console.log('\n📋 DIAGNOSTIC SUMMARY');
    console.log('🆔 Message ID:', diagnosticResults.messageId);
    console.log('🔗 Audio URL:', diagnosticResults.audioUrl);
    console.log('⏱️ Duration:', diagnosticResults.duration, 'seconds');
    
    const passedTests = Object.values(diagnosticResults.tests).filter(test => test.passed).length;
    const totalTests = Object.keys(diagnosticResults.tests).length;
    console.log('✅ Tests Passed:', passedTests, '/', totalTests);
    
    if (diagnosticResults.issues.length > 0) {
      console.log('❌ Issues Found:', diagnosticResults.issues);
    } else {
      console.log('🎉 No issues detected!');
    }
    
    if (diagnosticResults.recommendations.length > 0) {
      console.log('💡 Recommendations:', diagnosticResults.recommendations);
    }

    console.groupEnd();
    return diagnosticResults;
  }

  /**
   * Quick diagnostic for immediate debugging
   * @param {string} audioUrl - S3 URL to test
   * @param {number} duration - Duration to validate
   */
  static async quickDiagnostic(audioUrl, duration) {
    console.log('🚀 Quick Voice Message Diagnostic');
    console.log('🔗 URL:', audioUrl);
    console.log('⏱️ Duration:', duration);

    // Quick checks
    const issues = [];
    
    if (!audioUrl || audioUrl === 'Voice message') {
      issues.push('PLACEHOLDER_URL');
    }
    
    if (duration <= 1) {
      issues.push('INVALID_DURATION');
    }
    
    if (!audioUrl.includes('amazonaws.com') && !audioUrl.includes('s3.')) {
      issues.push('NOT_S3_URL');
    }

    if (issues.length > 0) {
      console.warn('⚠️ Quick diagnostic found issues:', issues);
      return { passed: false, issues };
    } else {
      console.log('✅ Quick diagnostic passed');
      return { passed: true, issues: [] };
    }
  }

  /**
   * Test all voice messages in current chat
   * @param {Array} messages - Array of messages from Redux state
   */
  static async testAllVoiceMessages(messages) {
    console.group('🔍 TESTING ALL VOICE MESSAGES IN CHAT');
    
    const voiceMessages = messages.filter(msg => msg.type === 'voice');
    console.log('📊 Found', voiceMessages.length, 'voice messages');

    const results = [];
    
    for (const message of voiceMessages) {
      const result = await this.runComprehensiveDiagnostic(
        message, 
        message.message, 
        message.duration
      );
      results.push(result);
    }

    // Summary report
    console.log('\n📋 BATCH TESTING SUMMARY');
    const totalMessages = results.length;
    const messagesWithIssues = results.filter(r => r.issues.length > 0).length;
    const healthyMessages = totalMessages - messagesWithIssues;

    console.log('📊 Total Voice Messages:', totalMessages);
    console.log('✅ Healthy Messages:', healthyMessages);
    console.log('❌ Messages with Issues:', messagesWithIssues);

    if (messagesWithIssues > 0) {
      console.log('\n🚨 MESSAGES WITH ISSUES:');
      results.forEach(result => {
        if (result.issues.length > 0) {
          console.log(`- ${result.messageId}: ${result.issues.join(', ')}`);
        }
      });
    }

    console.groupEnd();
    return results;
  }
}

// Export for global access
window.VoiceMessageDiagnostic = VoiceMessageDiagnostic;

export default VoiceMessageDiagnostic;
