import { useNavigate } from 'react-router-dom';
import { useParams } from 'react-router-dom';
import productService from 'services/product';
import ProductForm from './components/form';

const ProductsEdit = () => {
  const navigate = useNavigate();
  const { uuid } = useParams();

  const handleSubmit = (body, step = 1) => {
    return productService.update(uuid, body).then((res) => {
      navigate(`/product/${res?.data?.slug}/?step=${step}`);
      return res;
    });
  };

  return <ProductForm handleSubmit={handleSubmit} type='edit' />;
};
export default ProductsEdit;
