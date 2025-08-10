/**
 * ✅ COMPREHENSIVE VOICE MESSAGE CORS TESTING UTILITY
 * This utility tests voice message playback and CORS configuration
 */

export class VoiceMessageTester {
  constructor() {
    this.testResults = [];
    this.s3BaseUrl = 'https://forfai-media.s3.eu-north-1.amazonaws.com';
  }

  /**
   * Test a specific voice message URL with multiple strategies
   */
  async testVoiceMessage(voiceUrl) {
    console.log('🧪 COMPREHENSIVE VOICE MESSAGE TEST');
    console.log('=====================================');
    console.log('URL:', voiceUrl);
    console.log('');

    const tests = [
      { name: 'Direct S3 HEAD Request', method: 'HEAD', url: voiceUrl },
      { name: 'Direct S3 GET Request', method: 'GET', url: voiceUrl },
      { name: 'Proxy Endpoint Test', method: 'GET', url: this.getProxyUrl(voiceUrl) },
    ];

    for (const test of tests) {
      await this.runSingleTest(test);
    }

    return this.generateReport();
  }

  /**
   * Run a single test
   */
  async runSingleTest(test) {
    console.log(`\n🔍 Testing: ${test.name}`);
    console.log(`   URL: ${test.url}`);

    try {
      const startTime = Date.now();
      
      const response = await fetch(test.url, {
        method: test.method,
        mode: 'cors',
        credentials: 'omit',
        headers: {
          'Accept': 'audio/mpeg, audio/wav, audio/webm, */*'
        }
      });

      const endTime = Date.now();
      const duration = endTime - startTime;

      const result = {
        test: test.name,
        url: test.url,
        method: test.method,
        status: response.status,
        success: response.ok,
        duration: duration,
        contentType: response.headers.get('content-type'),
        contentLength: response.headers.get('content-length'),
        corsHeaders: {
          'access-control-allow-origin': response.headers.get('access-control-allow-origin'),
          'access-control-allow-methods': response.headers.get('access-control-allow-methods'),
          'access-control-expose-headers': response.headers.get('access-control-expose-headers'),
        },
        acceptRanges: response.headers.get('accept-ranges'),
        cacheControl: response.headers.get('cache-control'),
      };

      this.testResults.push(result);

      if (response.ok) {
        console.log(`   ✅ SUCCESS (${response.status}) - ${duration}ms`);
        console.log(`   📄 Content-Type: ${result.contentType}`);
        console.log(`   📏 Content-Length: ${result.contentLength}`);
        console.log(`   🌐 CORS Origin: ${result.corsHeaders['access-control-allow-origin']}`);
        
        if (result.acceptRanges) {
          console.log(`   📊 Accept-Ranges: ${result.acceptRanges}`);
        }
      } else {
        console.log(`   ❌ FAILED (${response.status}) - ${duration}ms`);
      }

    } catch (error) {
      console.log(`   ❌ ERROR: ${error.message}`);
      this.testResults.push({
        test: test.name,
        url: test.url,
        method: test.method,
        success: false,
        error: error.message
      });
    }
  }

  /**
   * Get proxy URL for a voice message
   */
  getProxyUrl(voiceUrl) {
    // Extract chat ID and filename from S3 URL
    const regex = /media\/voice_messages\/([^\/]+)\/([^\/]+)/;
    const match = voiceUrl.match(regex);
    
    if (match && match.length >= 3) {
      const chatId = match[1];
      const filename = match[2];
      return `${window.location.origin}/api/proxy/voice-message/${chatId}/${filename}`;
    }
    
    return null;
  }

  /**
   * Generate comprehensive test report
   */
  generateReport() {
    const successfulTests = this.testResults.filter(r => r.success);
    const failedTests = this.testResults.filter(r => !r.success);

    console.log('\n📊 TEST REPORT');
    console.log('==============');
    console.log(`Total Tests: ${this.testResults.length}`);
    console.log(`Successful: ${successfulTests.length}`);
    console.log(`Failed: ${failedTests.length}`);
    console.log('');

    if (successfulTests.length > 0) {
      console.log('✅ SUCCESSFUL TESTS:');
      successfulTests.forEach(test => {
        console.log(`   - ${test.test}: ${test.status} (${test.duration}ms)`);
      });
      console.log('');
    }

    if (failedTests.length > 0) {
      console.log('❌ FAILED TESTS:');
      failedTests.forEach(test => {
        console.log(`   - ${test.test}: ${test.error || test.status}`);
      });
      console.log('');
    }

    // Recommendations
    console.log('💡 RECOMMENDATIONS:');
    if (successfulTests.some(t => t.test.includes('Direct S3'))) {
      console.log('   ✅ S3 CORS is working - Direct access available');
    } else if (successfulTests.some(t => t.test.includes('Proxy'))) {
      console.log('   🔄 Use proxy endpoint - S3 direct access has issues');
    } else {
      console.log('   ⚠️ All tests failed - Check network and CORS configuration');
    }

    return {
      total: this.testResults.length,
      successful: successfulTests.length,
      failed: failedTests.length,
      results: this.testResults,
      recommendation: this.getRecommendation()
    };
  }

  /**
   * Get recommendation based on test results
   */
  getRecommendation() {
    const successfulTests = this.testResults.filter(r => r.success);
    
    if (successfulTests.some(t => t.test.includes('Direct S3'))) {
      return 'USE_S3_DIRECT';
    } else if (successfulTests.some(t => t.test.includes('Proxy'))) {
      return 'USE_PROXY';
    } else {
      return 'CHECK_CONFIGURATION';
    }
  }

  /**
   * Quick test for immediate feedback
   */
  static async quickTest(voiceUrl) {
    console.log('🚀 Quick Voice Message Test:', voiceUrl);
    
    try {
      const response = await fetch(voiceUrl, {
        method: 'HEAD',
        mode: 'cors',
        credentials: 'omit'
      });

      if (response.ok) {
        console.log('✅ Quick Test: Voice message is accessible!');
        return true;
      } else {
        console.log(`❌ Quick Test: Failed with status ${response.status}`);
        return false;
      }
    } catch (error) {
      console.log(`❌ Quick Test: Error - ${error.message}`);
      return false;
    }
  }
}

// Export for use in components
export default VoiceMessageTester;
