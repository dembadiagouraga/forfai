/**
 * ✅ CORS Testing & Verification Tool for Voice Messages
 * This utility helps diagnose and verify CORS issues with S3 voice messages
 */

export class CORSTestingTool {
  constructor() {
    this.testResults = [];
    this.s3BaseUrl = 'https://forfai-media.s3.eu-north-1.amazonaws.com';
  }

  /**
   * Test S3 CORS configuration with various request types
   */
  async testS3CORS(voiceMessageUrl) {
    console.log('🔍 Starting comprehensive CORS testing...');
    
    const tests = [
      { name: 'Direct S3 GET Request', method: 'GET' },
      { name: 'Direct S3 HEAD Request', method: 'HEAD' },
      { name: 'S3 with CORS Headers', method: 'GET', corsHeaders: true },
      { name: 'S3 with Audio Headers', method: 'GET', audioHeaders: true },
    ];

    for (const test of tests) {
      try {
        console.log(`\n🧪 Testing: ${test.name}`);
        
        const headers = {};
        
        if (test.corsHeaders) {
          headers['Accept'] = '*/*';
          headers['Cache-Control'] = 'no-cache';
          headers['Origin'] = window.location.origin;
        }
        
        if (test.audioHeaders) {
          headers['Accept'] = 'audio/mpeg, audio/wav, audio/webm, */*';
          headers['Range'] = 'bytes=0-1023'; // Test partial content
        }

        const response = await fetch(voiceMessageUrl, {
          method: test.method,
          mode: 'cors',
          credentials: 'omit',
          headers
        });

        const result = {
          test: test.name,
          status: response.status,
          success: response.ok,
          headers: Object.fromEntries(response.headers.entries()),
          corsHeaders: {
            'access-control-allow-origin': response.headers.get('access-control-allow-origin'),
            'access-control-allow-methods': response.headers.get('access-control-allow-methods'),
            'access-control-allow-headers': response.headers.get('access-control-allow-headers'),
            'access-control-expose-headers': response.headers.get('access-control-expose-headers'),
          }
        };

        this.testResults.push(result);
        
        if (response.ok) {
          console.log(`✅ ${test.name}: SUCCESS (${response.status})`);
          console.log(`   CORS Origin: ${result.corsHeaders['access-control-allow-origin']}`);
        } else {
          console.log(`❌ ${test.name}: FAILED (${response.status})`);
        }

      } catch (error) {
        console.log(`❌ ${test.name}: ERROR - ${error.message}`);
        this.testResults.push({
          test: test.name,
          success: false,
          error: error.message
        });
      }
    }

    return this.testResults;
  }

  /**
   * Test proxy endpoint functionality
   */
  async testProxyEndpoint(chatId, filename) {
    console.log('\n🔍 Testing proxy endpoint...');
    
    const proxyUrl = `${window.location.origin}/api/proxy/voice-message/${chatId}/${filename}`;
    
    try {
      const response = await fetch(proxyUrl, {
        method: 'GET',
        mode: 'cors',
        credentials: 'omit'
      });

      const result = {
        test: 'Proxy Endpoint',
        url: proxyUrl,
        status: response.status,
        success: response.ok,
        contentType: response.headers.get('content-type'),
        corsHeaders: {
          'access-control-allow-origin': response.headers.get('access-control-allow-origin'),
        }
      };

      if (response.ok) {
        console.log(`✅ Proxy Endpoint: SUCCESS (${response.status})`);
        console.log(`   Content-Type: ${result.contentType}`);
        console.log(`   CORS Origin: ${result.corsHeaders['access-control-allow-origin']}`);
      } else {
        console.log(`❌ Proxy Endpoint: FAILED (${response.status})`);
      }

      return result;

    } catch (error) {
      console.log(`❌ Proxy Endpoint: ERROR - ${error.message}`);
      return {
        test: 'Proxy Endpoint',
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Generate comprehensive test report
   */
  generateReport() {
    console.log('\n📊 CORS Testing Report');
    console.log('========================');
    
    const successfulTests = this.testResults.filter(r => r.success);
    const failedTests = this.testResults.filter(r => !r.success);
    
    console.log(`✅ Successful Tests: ${successfulTests.length}`);
    console.log(`❌ Failed Tests: ${failedTests.length}`);
    
    if (failedTests.length > 0) {
      console.log('\n❌ Failed Tests Details:');
      failedTests.forEach(test => {
        console.log(`   - ${test.test}: ${test.error || `Status ${test.status}`}`);
      });
    }

    if (successfulTests.length > 0) {
      console.log('\n✅ Successful Tests Details:');
      successfulTests.forEach(test => {
        console.log(`   - ${test.test}: Status ${test.status}`);
      });
    }

    // Recommendations
    console.log('\n💡 Recommendations:');
    if (successfulTests.length === 0) {
      console.log('   - All tests failed. Check S3 CORS configuration');
      console.log('   - Verify AWS credentials and bucket permissions');
      console.log('   - Use proxy endpoint as fallback');
    } else if (failedTests.length > 0) {
      console.log('   - Some tests failed. S3 CORS partially working');
      console.log('   - Use successful methods for audio playback');
      console.log('   - Implement fallback for failed methods');
    } else {
      console.log('   - All tests passed! S3 CORS is properly configured');
      console.log('   - Direct S3 access should work for voice messages');
    }

    return {
      total: this.testResults.length,
      successful: successfulTests.length,
      failed: failedTests.length,
      results: this.testResults
    };
  }

  /**
   * Quick test for a specific voice message URL
   */
  static async quickTest(voiceMessageUrl) {
    const tester = new CORSTestingTool();
    
    console.log('🚀 Quick CORS Test for:', voiceMessageUrl);
    
    try {
      const response = await fetch(voiceMessageUrl, {
        method: 'HEAD',
        mode: 'cors',
        credentials: 'omit'
      });

      if (response.ok) {
        console.log('✅ Quick Test: CORS is working!');
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
export default CORSTestingTool;
