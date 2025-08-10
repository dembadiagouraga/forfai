/**
 * 🧪 Voice Message Debug Test Script
 * Run this in browser console to test voice message functionality
 */

// Test URLs
const TEST_URLS = {
  s3Direct: 'https://forfai-media.s3.eu-north-1.amazonaws.com/media/voice_messages/AXvrtwzZN7W9bM9PvTAA/1752864904_687a988002a1.wav',
  proxy: 'http://localhost:3000/api/v1/proxy/voice-message/AXvrtwzZN7W9bM9PvTAA/1752864904_687a988002a1.wav'
};

/**
 * Test S3 Direct Access
 */
async function testS3DirectAccess() {
  console.log('🔍 Testing S3 Direct Access...');
  
  try {
    const response = await fetch(TEST_URLS.s3Direct, {
      method: 'HEAD',
      mode: 'cors',
      credentials: 'omit'
    });

    console.log(`S3 Direct Access: ${response.ok ? '✅ SUCCESS' : '❌ FAILED'} (${response.status})`);
    console.log('CORS Origin:', response.headers.get('access-control-allow-origin'));
    console.log('Content-Type:', response.headers.get('content-type'));
    
    return response.ok;
  } catch (error) {
    console.log(`❌ S3 Direct Access Error: ${error.message}`);
    return false;
  }
}

/**
 * Test Proxy Endpoint
 */
async function testProxyEndpoint() {
  console.log('🔍 Testing Proxy Endpoint...');
  
  try {
    const response = await fetch(TEST_URLS.proxy, {
      method: 'HEAD',
      mode: 'cors',
      credentials: 'omit'
    });

    console.log(`Proxy Endpoint: ${response.ok ? '✅ SUCCESS' : '❌ FAILED'} (${response.status})`);
    console.log('CORS Origin:', response.headers.get('access-control-allow-origin'));
    console.log('Content-Type:', response.headers.get('content-type'));
    console.log('Accept-Ranges:', response.headers.get('accept-ranges'));
    
    return response.ok;
  } catch (error) {
    console.log(`❌ Proxy Endpoint Error: ${error.message}`);
    return false;
  }
}

/**
 * Test Howler.js Compatibility
 */
function testHowlerCompatibility() {
  console.log('🔍 Testing Howler.js Compatibility...');
  
  if (typeof Howl === 'undefined') {
    console.log('⚠️ Howler.js not available in this context');
    return false;
  }

  try {
    const sound = new Howl({
      src: [TEST_URLS.s3Direct, TEST_URLS.proxy],
      html5: true,
      format: ['wav', 'mp3', 'webm'],
      xhr: {
        method: 'GET',
        headers: {
          'Accept': 'audio/mpeg, audio/wav, audio/webm, */*'
        },
        withCredentials: false
      },
      onload: () => {
        console.log('✅ Howler.js: Audio loaded successfully');
        sound.unload();
      },
      onloaderror: (id, error) => {
        console.log(`❌ Howler.js: Load error - ${error}`);
      }
    });

    console.log('✅ Howler.js: Instance created successfully');
    return true;
  } catch (error) {
    console.log(`❌ Howler.js Error: ${error.message}`);
    return false;
  }
}

/**
 * Test Network Requests (for CORS verification)
 */
async function testNetworkRequests() {
  console.log('🔍 Testing Network Requests for CORS...');
  
  const tests = [
    { name: 'S3 GET Request', url: TEST_URLS.s3Direct, method: 'GET' },
    { name: 'S3 HEAD Request', url: TEST_URLS.s3Direct, method: 'HEAD' },
    { name: 'Proxy GET Request', url: TEST_URLS.proxy, method: 'GET' },
    { name: 'Proxy HEAD Request', url: TEST_URLS.proxy, method: 'HEAD' }
  ];

  const results = [];

  for (const test of tests) {
    try {
      const response = await fetch(test.url, {
        method: test.method,
        mode: 'cors',
        credentials: 'omit'
      });

      const result = {
        name: test.name,
        success: response.ok,
        status: response.status,
        corsOrigin: response.headers.get('access-control-allow-origin')
      };

      results.push(result);
      console.log(`${result.success ? '✅' : '❌'} ${test.name}: ${result.status} (CORS: ${result.corsOrigin})`);
    } catch (error) {
      results.push({
        name: test.name,
        success: false,
        error: error.message
      });
      console.log(`❌ ${test.name}: ${error.message}`);
    }
  }

  return results;
}

/**
 * Run All Tests
 */
async function runAllVoiceMessageTests() {
  console.log('🚀 Starting Comprehensive Voice Message Tests');
  console.log('==============================================');
  
  const results = {
    s3Direct: await testS3DirectAccess(),
    proxy: await testProxyEndpoint(),
    howler: testHowlerCompatibility(),
    network: await testNetworkRequests()
  };

  console.log('\n📊 TEST SUMMARY');
  console.log('===============');
  console.log(`S3 Direct Access: ${results.s3Direct ? '✅ WORKING' : '❌ FAILED'}`);
  console.log(`Proxy Endpoint: ${results.proxy ? '✅ WORKING' : '❌ FAILED'}`);
  console.log(`Howler.js Compatibility: ${results.howler ? '✅ WORKING' : '❌ FAILED'}`);
  
  const networkSuccess = results.network.filter(r => r.success).length;
  const networkTotal = results.network.length;
  console.log(`Network Requests: ${networkSuccess}/${networkTotal} successful`);

  console.log('\n💡 RECOMMENDATIONS');
  console.log('==================');
  
  if (results.s3Direct) {
    console.log('✅ S3 CORS is working - Direct access available');
  } else if (results.proxy) {
    console.log('🔄 Use proxy endpoint - S3 direct access has issues');
  } else {
    console.log('⚠️ Both S3 and proxy failed - Check configuration');
  }

  if (results.howler) {
    console.log('✅ Howler.js is compatible with current configuration');
  } else {
    console.log('⚠️ Howler.js may have compatibility issues');
  }

  return results;
}

/**
 * Quick Test Function
 */
async function quickVoiceTest() {
  console.log('🚀 Quick Voice Message Test');
  
  const s3Result = await testS3DirectAccess();
  const proxyResult = await testProxyEndpoint();
  
  if (s3Result || proxyResult) {
    console.log('✅ Voice message system is working!');
  } else {
    console.log('❌ Voice message system has issues');
  }
  
  return s3Result || proxyResult;
}

// Export functions for use
window.voiceMessageTests = {
  runAll: runAllVoiceMessageTests,
  quick: quickVoiceTest,
  s3: testS3DirectAccess,
  proxy: testProxyEndpoint,
  howler: testHowlerCompatibility,
  network: testNetworkRequests
};

console.log('🎯 Voice Message Test Functions Loaded');
console.log('Usage:');
console.log('  voiceMessageTests.runAll() - Run comprehensive tests');
console.log('  voiceMessageTests.quick() - Quick test');
console.log('  voiceMessageTests.s3() - Test S3 direct access');
console.log('  voiceMessageTests.proxy() - Test proxy endpoint');
