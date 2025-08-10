const { createProxyMiddleware } = require('http-proxy-middleware');

// Import centralized configuration from app-global.js (single source of truth)
const appGlobalConfig = require('./configs/app-global.js');

// Smart environment-aware URL selection
// Priority: Environment Variable > Centralized Config (auto-detects dev/prod)
const BASE_URL = process.env.REACT_APP_API_URL || appGlobalConfig.ipConfiguration.getBaseUrl();

module.exports = function(app) {
  console.log('Setting up proxy middleware for audio files');
  console.log('Backend URL:', BASE_URL);

  // Create a proxy middleware for API requests
  const apiProxy = createProxyMiddleware({
    target: BASE_URL,
    changeOrigin: true,
    secure: false,
    logLevel: 'debug',
    onProxyReq: (proxyReq, req, res) => {
      // Log the proxy request for debugging
      console.log(`Proxying ${req.method} request to: ${req.path}`);
    },
    onProxyRes: (proxyRes, req, res) => {
      // ✅ ENHANCED: Comprehensive CORS headers for voice messages
      proxyRes.headers['Access-Control-Allow-Origin'] = '*';
      proxyRes.headers['Access-Control-Allow-Methods'] = 'GET, HEAD, POST, OPTIONS';
      proxyRes.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, Cache-Control, Pragma';
      proxyRes.headers['Access-Control-Expose-Headers'] = 'Content-Length, Content-Type, Content-Range, Accept-Ranges';

      // ✅ Audio-specific headers
      if (req.path.includes('voice-message') || req.path.includes('proxy-audio')) {
        proxyRes.headers['Accept-Ranges'] = 'bytes';
        proxyRes.headers['Cache-Control'] = 'public, max-age=3600';

        // Ensure proper content type for audio
        if (!proxyRes.headers['content-type'] || proxyRes.headers['content-type'].includes('text')) {
          proxyRes.headers['Content-Type'] = 'audio/mpeg';
        }
      }

      // Log the proxy response status for debugging
      console.log(`Proxy response status: ${proxyRes.statusCode}`);

      // If the response is an error, log it
      if (proxyRes.statusCode >= 400) {
        console.error(`Proxy error: ${proxyRes.statusCode} for ${req.path}`);
      }
    },
    onError: (err, req, res) => {
      console.error('Proxy error:', err);
      
      // Send a friendly error response
      res.writeHead(500, {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      });
      
      res.end(JSON.stringify({ 
        error: 'Proxy error', 
        message: err.message,
        path: req.path
      }));
    }
  });

  // Apply the proxy middleware to all API routes
  app.use('/api', apiProxy);
  
  // ✅ ENHANCED: Specific proxy for audio files and voice messages
  app.use('/api/v1/dashboard/proxy-audio', apiProxy);
  app.use('/api/v1/proxy-audio', apiProxy);
  app.use('/api/proxy-audio', apiProxy);
  app.use('/api/proxy/voice-message', apiProxy); // Voice message proxy endpoint
};
