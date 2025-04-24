import { Image } from 'antd';
import { getImageUrl } from '../../configs/app-global';

const ColumnImage = ({ image, row, size = 100 }) => {
  // Fix double storage issue directly
  let fixedImage = image;
  if (typeof fixedImage === 'string' && fixedImage.includes('/storage/storage/')) {
    fixedImage = fixedImage.replace('/storage/storage/', '/storage/');
  }

  return (
    <Image
      src={fixedImage ? getImageUrl(fixedImage) : 'https://via.placeholder.com/150'}
      alt='img_gallery'
      width={size}
      height={size}
      className='rounded border'
      preview
      placeholder={!image}
      key={image + row?.id}
      style={{ objectFit: 'contain' }}
      onError={(e) => {
        // Try alternative URL if image fails to load
        if (image && image.includes('/storage/storage/')) {
          e.target.src = image.replace('/storage/storage/', '/storage/');
        }
      }}
    />
  );
};

export default ColumnImage;
