import { Card, Steps } from 'antd';
import { useNavigate } from 'react-router-dom';
import { steps } from './steps';
import LanguageList from 'components/language-list';
import { useParams } from 'react-router-dom';
import productService from 'services/product';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import { setMenuData } from 'redux/slices/menu';
import { useTranslation } from 'react-i18next';
import { useQueryParams } from 'helpers/useQueryParams';
import ProductForm from './components/form';
import Finish from './components/finish';

const { Step } = Steps;

const VacancyEdit = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const queryParams = useQueryParams();
  const { uuid } = useParams();
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const current = Number(queryParams.values?.step || 0);

  const next = () => {
    const step = current + 1;
    queryParams.set('step', step);
  };
  const prev = () => {
    const step = current - 1;
    queryParams.set('step', step);
  };

  const onChange = (step) => {
    dispatch(setMenuData({ activeMenu, data: { ...activeMenu.data, step } }));
    queryParams.set('step', step);
  };

  const handleSubmitIndex = (body) => {
    return productService.update(uuid, body).then(({ data }) => {
      next();
      navigate(`/vacancy/${data?.slug}/?step=1`);
    });
  };

  return (
    <>
      <Card title={t('edit.vacancy')} extra={<LanguageList />}>
        <Steps current={current} onChange={onChange}>
          {steps.map((item) => (
            <Step title={t(item.title)} key={item.title} />
          ))}
        </Steps>
      </Card>

      {steps[current].content === 'First-content' && (
        <ProductForm handleSubmit={handleSubmitIndex} />
      )}
      {steps[current].content === 'Finish-content' && <Finish prev={prev} />}
    </>
  );
};
export default VacancyEdit;
