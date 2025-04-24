// Desc:
// 1. Fetches attributes by selected category id from step details
// 2. Construct form keys based on fetched attributes
// 3. Construct form values based on product details and assign them to corresponding form keys

import { Button, Card, Col, Form, Row } from 'antd';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import { fetchAttributeByCategoryId } from 'redux/slices/attributes';
import { disableRefetch } from 'redux/slices/menu';
import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import RiveResult from 'components/rive-result';
import { useParams } from 'react-router-dom';
import useDidUpdate from 'helpers/useDidUpdate';
import AttributeCard from './components/card';
import { constructBody } from './utils/construct-body';
import { constructFormValues } from './utils/construct-form-values';

const Attributes = ({ handleSubmit, prev }) => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const [form] = Form.useForm();
  const { uuid } = useParams();

  const { data, loading: productDetailsLoading } = useSelector(
    (state) => state.product.productDetails,
    shallowEqual,
  );
  const { data: attributes, loading: attributesLoading } = useSelector(
    (state) => state.attributes.attributeDetails,
    shallowEqual,
  );
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);

  const [loadingBtn, setLoadingBtn] = useState(false);

  // 1. Fetches attributes by selected category id from step details
  const fetchAttribute = () => {
    dispatch(fetchAttributeByCategoryId({ id: data?.category_id }));
    dispatch(disableRefetch(activeMenu));
  };

  const onFinish = (values) => {
    const arrayOfValues = Object.entries(values);
    const body = [];
    arrayOfValues.forEach((item) => {
      constructBody(body, item);
    });
    setLoadingBtn(true);
    handleSubmit({
      attribute_values: body,
      category_id: data?.category_id,
    }).finally(() => setLoadingBtn(false));
  };

  // fetching when first time component is mounted
  useEffect(() => {
    if (uuid === data?.slug) {
      fetchAttribute();
    }
    return () => {};
    // eslint-disable-next-line
  }, [data?.category_id, data?.slug, uuid]);

  // re-fetching when active menu refetch is true
  useDidUpdate(() => {
    if (
      activeMenu.refetch &&
      uuid === data?.slug &&
      !productDetailsLoading &&
      !attributesLoading
    ) {
      fetchAttribute();
    }
    return () => {};
  }, [
    activeMenu.refetch,
    uuid,
    data?.category_id,
    data?.slug,
    productDetailsLoading,
    attributesLoading,
  ]);

  // 3. Construct form values based on product details and assign them to corresponding form keys
  useEffect(() => {
    if (data?.attributes?.length) {
      const body = constructFormValues(data?.attributes);
      form.setFieldsValue(body);
    }
    return () => {};
    // eslint-disable-next-line
  }, [data?.attributes, attributes]);

  return (
    <Card loading={attributesLoading || productDetailsLoading}>
      {attributes?.length ? (
        <div className='d-flex justify-content-center'>
          <Form
            form={form}
            layout='vertical'
            onFinish={onFinish}
            style={{ width: '1200px' }}
          >
            <Row gutter={12}>
              {/* 2. Construct form keys based on fetched attributes */}
              {attributes?.map((attribute) => (
                <Col  lg={12} sm={24}>
                  <AttributeCard key={attribute?.id} data={attribute} />
                </Col>
              ))}
            </Row>
            <div className='d-flex justify-content-between align-items-center'>
              <Button onClick={prev}>{t('prev')}</Button>
              <Button htmlType='submit' type='primary' loading={loadingBtn}>
                {t('next')}
              </Button>
            </div>
          </Form>
        </div>
      ) : (
        <RiveResult
          text='product.category.does.not.have.assigned.attributes'
          description='assign.attributes.to.selected.category'
        />
      )}
    </Card>
  );
};

export default Attributes;
