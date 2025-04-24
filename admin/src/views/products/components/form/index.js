import { lazy, Suspense, useEffect, useMemo } from 'react';
import { Card, Steps } from 'antd';
import LanguageList from 'components/language-list';
import { useTranslation } from 'react-i18next';
import { useQueryParams } from 'helpers/useQueryParams';
import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import { fetchProductById } from 'redux/slices/product';
import { disableRefetch, setRefetch } from 'redux/slices/menu';
import useDidUpdate from 'helpers/useDidUpdate';
import { useParams } from 'react-router-dom';
import Loading from 'components/loading';
import { steps } from '../../steps';
// import Details from './steps/details';
// import Finish from './steps/finish';
// import Attributes from './steps/attributes';

const Details = lazy(() => import('./steps/details'));
const Finish = lazy(() => import('./steps/finish'));
const Attributes = lazy(() => import('./steps/attributes'));

const { Step } = Steps;

const ProductForm = ({ handleSubmit, type = 'add' }) => {
  const { t } = useTranslation();
  const queryParams = useQueryParams();
  const dispatch = useDispatch();
  const { uuid } = useParams();

  const { loading } = useSelector(
    (state) => state.product.productDetails,
    shallowEqual,
  );
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);

  const currentStep = useMemo(
    () => Number(queryParams.values?.step) || 0,
    [queryParams.values?.step],
  );

  const prev = () => {
    const step = currentStep - 1;
    queryParams.set('step', step);
  };

  const onChange = (step) => {
    if (type === 'add') {
      return;
    }
    queryParams.set('step', step);
  };

  const fetch = (uuid) => {
    batch(() => {
      dispatch(fetchProductById({ id: uuid }));
      dispatch(disableRefetch(activeMenu));
    });
  };

  useDidUpdate(() => {
    if (activeMenu.refetch && uuid && !loading) {
      fetch(uuid);
    }
    return () => {};
  }, [activeMenu.refetch, uuid, loading]);

  useEffect(() => {
    if (uuid) {
      fetch(uuid);
    }
    return () => {};
    // eslint-disable-next-line
  }, [uuid]);

  return (
    <>
      <Card title={t(`${type}.product`)} extra={<LanguageList />}>
        <Steps current={currentStep} onChange={onChange}>
          {steps.map((item) => (
            <Step title={t(item.title)} key={item.title} />
          ))}
        </Steps>
      </Card>
      {steps[currentStep].content === 'product-content' && (
        <Suspense fallback={<Loading />}>
          <Details
            handleSubmit={(body) =>
              handleSubmit(body).then(() => {
                if (type === 'edit') {
                  dispatch(setRefetch(activeMenu));
                }
              })
            }
          />
        </Suspense>
      )}
      {steps[currentStep].content === 'attributes-content' && (
        <Suspense fallback={<Loading />}>
          <Attributes
            handleSubmit={(body) =>
              handleSubmit(body, currentStep + 1).then(() => {
                dispatch(setRefetch(activeMenu));
              })
            }
            prev={prev}
          />
        </Suspense>
      )}
      {steps[currentStep].content === 'finish-content' && (
        <Suspense fallback={<Loading />}>
          <Finish prev={prev} />
        </Suspense>
      )}
    </>
  );
};
export default ProductForm;
