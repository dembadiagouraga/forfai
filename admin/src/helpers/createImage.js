import { getImageUrl } from '../configs/app-global';

export default function createImage(name) {
  // Fix double storage issue directly
  let fixedName = name;
  if (typeof fixedName === 'string' && fixedName.includes('/storage/storage/')) {
    fixedName = fixedName.replace('/storage/storage/', '/storage/');
  }

  return {
    name: fixedName,
    url: fixedName,
  };
}
export const createImages = (items) => {
  return items
    ?.filter((item) => !item?.preview)
    ?.map((item) => ({
      uid: item.id,
      name: item.path,
      url: item.path,
    }));
};

export const createMediaFile = (items) => {
  const mediaObject = { images: [], previews: [] };

  const previews = items
    ?.filter((item) => !!item?.preview)
    ?.map((item) => ({
      uid: item.id,
      name: item.preview,
      url: item.preview,
    }));

  const videos = items
    ?.filter((item) => !!item?.preview)
    ?.map((item) => ({
      uid: item.id,
      name: item.path,
      url: item.path,
    }));

  mediaObject.previews = previews;
  mediaObject.images = videos;

  return mediaObject;
};
