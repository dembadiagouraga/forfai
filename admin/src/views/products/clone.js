import productService from 'services/product';
import { useNavigate } from 'react-router-dom';
import ProductForm from './components/form';

const ProductsClone = () => {
  const navigate = useNavigate();

  const handleSubmit = (body, step = 1) => {
    return productService.create(body).then((res) => {
      navigate(`/product/${res?.data?.slug}/?step=${step}`);
      return res;
    });
  };

  return <ProductForm handleSubmit={handleSubmit} type='clone' />;
};
export default ProductsClone;
