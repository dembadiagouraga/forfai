import React, { useState } from 'react';
import { steps } from './steps';
import { Card, Steps } from 'antd';
import LanguageList from 'components/language-list';
import { shallowEqual, useSelector } from 'react-redux';
import { useTranslation } from 'react-i18next';
import ProductForm from './components/form';
import productService from 'services/product';
import { useNavigate } from 'react-router-dom';
import Finish from './components/finish';

const { Step } = Steps;

const VacancyAdd = () => {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const [current, setCurrent] = useState(activeMenu.data?.step || 0);

  const next = () => {
    const step = current + 1;
    setCurrent(step);
  };

  const prev = () => {
    const step = current - 1;
    setCurrent(step);
  };

  const handleSubmitIndex = (body) => {
    return productService.create(body).then(({ data }) => {
      next();
      navigate(`/vacancy/${data?.slug}/?step=1`);
    });
  };

  return (
    <>
      <Card title={t('add.vacancy')} extra={<LanguageList />}>
        <Steps current={current}>
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
export default VacancyAdd;
