import placeholder from '../assets/images/placeholder.jpeg';
import { getImageUrl } from '../configs/app-global';

export default function getImage(url) {
  if (!url) {
    return placeholder;
  }

  // Fix double storage issue directly in the helper
  let fixedUrl = url;

  // Handle double storage in URLs
  if (typeof fixedUrl === 'string' && fixedUrl.includes('/storage/storage/')) {
    fixedUrl = fixedUrl.replace('/storage/storage/', '/storage/');
  }

  return getImageUrl(fixedUrl);
}
