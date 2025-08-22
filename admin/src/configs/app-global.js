export const PROJECT_NAME = 'Forfait marketplace';

// ============================================================================
// 🎯 CENTRALIZED CONFIGURATION - SINGLE SOURCE OF TRUTH
// ============================================================================
// ⚠️ DEVELOPMENT: Update DEVELOPMENT_IP when your device IP changes
// ✅ PRODUCTION: Update PRODUCTION_DOMAIN for your live domain

const DEVELOPMENT_IP = '192.168.0.102';  // 🔧 UPDATE THIS WHEN YOUR DEVICE IP CHANGES
const DEVELOPMENT_PORT = '8000';
const PRODUCTION_DOMAIN = 'https://mkkc0co0s4sw8cwkcoc48wos.208.85.21.60.sslip.io';  // 🌐 PRODUCTION BACKEND URL

// Construct URLs
const DEVELOPMENT_BASE_URL = `http://${DEVELOPMENT_IP}:${DEVELOPMENT_PORT}`;

// Smart environment detection and URL selection
const getBaseUrl = () => {
  // Check if we're in development or production
  // If NODE_ENV is undefined, default to development for local development
  const isDevelopment = process.env.NODE_ENV === 'development' || process.env.NODE_ENV === undefined;

  if (isDevelopment) {
    // Development: Use local IP configuration
    return DEVELOPMENT_BASE_URL;
  } else {
    // Production: Use environment variable or configured domain
    return process.env.REACT_APP_API_URL || PRODUCTION_DOMAIN;
  }
};

export const BASE_URL = getBaseUrl();
export const WEBSITE_URL = 'https://uzmart.org';
export const api_url = BASE_URL + '/api/v1/';
export const IMG_BASE_URL = BASE_URL; // Use same as BASE_URL for consistency
export const IMG_URL = BASE_URL; // Alias for IMG_BASE_URL for backward compatibility

// Helper function to fix double storage path issue and handle all image URL formats
export const getImageUrl = (path) => {
  if (!path) return '';

  // Normalize input (trim spaces/newlines)
  let input = String(path).trim();

  // If the input is already an absolute URL, return it (with minor fixes)
  // Covers: http, https, protocol-relative (//), data URIs
  let candidate = input;
  let isAbsolute = /^(https?:)?\/\//i.test(candidate) || candidate.startsWith('data:');

  // Handle malformed absolute URLs like "/https://..." by stripping leading slashes and re-checking
  if (!isAbsolute && candidate.startsWith('/')) {
    const stripped = candidate.replace(/^\/+/, '');
    if (/^(https?:)?\/\//i.test(stripped)) {
      candidate = stripped;
      isAbsolute = true;
    }
  }

  if (isAbsolute) {
    let fixedUrl = candidate;

    // Fix double storage in existing URLs
    if (fixedUrl.includes('/storage/storage/')) {
      fixedUrl = fixedUrl.replace('/storage/storage/', '/storage/');
    }

    // Replace old IP addresses with current BASE_URL (development leftovers)
    const oldIPs = [
      'http://192.168.0.102:8000',
      'http://127.0.0.1:8000',
      'http://localhost:8000',
    ];
    for (const oldIP of oldIPs) {
      if (fixedUrl.startsWith(oldIP)) {
        const pathPart = fixedUrl.substring(oldIP.length);
        const base = BASE_URL.endsWith('/') ? BASE_URL.slice(0, -1) : BASE_URL;
        return `${base}${pathPart}`;
      }
    }

    return fixedUrl;
  }

  // Handle relative paths → construct full URL
  let pathToUse = input;

  // Remove leading slash if present
  if (pathToUse.startsWith('/')) {
    pathToUse = pathToUse.substring(1);
  }

  // After removing leading slash, if it became an absolute URL (edge case), return it directly
  if (/^(https?:)?\/\//i.test(pathToUse)) {
    return pathToUse;
  }

  // If path starts with 'images/', prepend 'storage/'
  // If neither starts with 'storage/' nor 'images/', also prepend 'storage/'
  if (pathToUse.startsWith('images/')) {
    pathToUse = `storage/${pathToUse}`;
  } else if (!pathToUse.startsWith('storage/')) {
    pathToUse = `storage/${pathToUse}`;
  }

  // Ensure base URL doesn't end with slash
  const baseUrl = IMG_BASE_URL.endsWith('/') ? IMG_BASE_URL.slice(0, -1) : IMG_BASE_URL;
  return `${baseUrl}/${pathToUse}`;
};
export const MAP_API_KEY = 'AIzaSyDemoKeyForGoogleMaps123';
export const export_url = BASE_URL + '/storage/';
export const example = BASE_URL + '/storage/';

export const VAPID_KEY = 'BCUyUu94u65vzV9YvPqUGb1ikyHZJ3UOwZ-CDfOzTgVDQkY1pt5ArJZFnbd9QrFpUlrfozf0yemITP7hcPvdY0A';
export const API_KEY = 'AIzaSyDJ8HGVc414drZl_Ug5J4-Yuor0jgYeOWw';
export const AUTH_DOMAIN = 'forfai-74daa.firebaseapp.com';
export const PROJECT_ID = 'forfai-74daa';
export const STORAGE_BUCKET = 'forfai-74daa.firebasestorage.app';
export const MESSAGING_SENDER_ID = '586412579852';
export const APP_ID = '1:586412579852:web:6945f7ad5034af90a96229';
export const MEASUREMENT_ID = 'G-9W8T75V93D';

export const RECAPTCHASITEKEY = process.env.REACT_APP_RECAPTCHA_SITE_KEY;

export const DEMO_SELLER = 107; // seller_id
export const DEMO_SELLER_UUID = '3566bdf6-3a09-4488-8269-70a19f871bd0'; // seller_id
export const DEMO_SHOP = 501; // seller_id
export const DEMO_DELIVERYMAN = 106; // deliveryman_id
export const DEMO_MANEGER = 114; // maneger_id
export const DEMO_MODERATOR = 297; // moderator_id
export const DEMO_ADMIN = 501; // administrator_id

export const COUNTRY_CODE = '';

export const DEFAULT_LANGUAGE = 'en';

export const SUPPORTED_FORMATS = [
  'image/jpg',
  'image/jpeg',
  'image/png',
  'image/svg+xml',
  'image/svg',
];

// ============================================================================
// Configuration Export for setupProxy.js compatibility
// ============================================================================
// Export the IP configuration so setupProxy.js can access it
// This creates a single source of truth for the IP address.

// Create configuration object for export
const ipConfiguration = {
  DEVELOPMENT_IP,
  DEVELOPMENT_PORT,
  DEVELOPMENT_BASE_URL,
  PRODUCTION_DOMAIN,
  getBaseUrl,
  BASE_URL
};

// Export for both CommonJS and ES6 modules
if (typeof module !== 'undefined' && typeof module.exports !== 'undefined') {
  module.exports = ipConfiguration;
}

// Also export as named export for ES6 compatibility
export { ipConfiguration };
