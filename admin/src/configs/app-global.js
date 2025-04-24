export const PROJECT_NAME = 'Forfai marketplace';
export const BASE_URL = 'http://192.168.0.107:8000';
export const WEBSITE_URL = 'https://uzmart.org';
export const api_url = BASE_URL + '/api/v1/';
export const IMG_URL = BASE_URL + '/storage/'; // Make sure this matches backend's IMG_HOST

// Helper function to fix double storage path issue
export const getImageUrl = (path) => {
  if (!path) return '';

  // If it's already a full URL, just return it
  if (path.startsWith('http')) {
    // Fix double storage in existing URLs
    if (path.includes('/storage/storage/')) {
      return path.replace('/storage/storage/', '/storage/');
    }
    return path;
  }

  // Remove leading slash if present
  let pathToUse = path.startsWith('/') ? path.substring(1) : path;

  // Fix double storage path issue
  if (pathToUse.startsWith('storage/')) {
    pathToUse = pathToUse.replace('storage/', '');
  }

  // Make sure we don't have double slashes
  const baseUrl = IMG_URL.endsWith('/') ? IMG_URL.slice(0, -1) : IMG_URL;
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
export const MEASUREMENT_ID = '';

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







