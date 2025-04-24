import { getImageUrl } from '../configs/app-global';
import avatar from '../assets/images/1.png';

export default function getAvatar(url) {
  if (!url) {
    return avatar;
  }

  // Fix double storage issue directly in the helper
  let fixedUrl = url;

  // Handle double storage in URLs
  if (typeof fixedUrl === 'string' && fixedUrl.includes('/storage/storage/')) {
    fixedUrl = fixedUrl.replace('/storage/storage/', '/storage/');
  }

  return getImageUrl(fixedUrl);
}
