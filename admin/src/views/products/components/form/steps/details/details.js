import { useEffect, useState } from 'react';
import { Button, Col, Form, Row } from 'antd';
import { useTranslation } from 'react-i18next';
import { useSelector, shallowEqual } from 'react-redux';
import getTranslationFields from 'helpers/getTranslationFields';
import { useParams } from 'react-router-dom';
import getLanguageFields from 'helpers/getLanguageFields';
import createSelectObject from 'helpers/createSelectObject';
import { createImages, createMediaFile } from 'helpers/createImage';
import Location from 'components/forms/location';
import BasicInfo from './components/basic-info';
import Organization from './components/organization';
import Pricing from './components/pricing';
import Media from './components/media';
import UserInfo from './components/user-info';

const Details = ({ handleSubmit }) => {
  const { t } = useTranslation();
  const [form] = Form.useForm();
  const { uuid } = useParams();

  const { data, loading } = useSelector(
    (state) => state.product.productDetails,
    shallowEqual,
  );
  const { languages } = useSelector((state) => state.formLang, shallowEqual);
  const { defaultCurrency } = useSelector(
    (state) => state.currency,
    shallowEqual,
  );

  const [imageList, setImageList] = useState([]);
  const [videoList, setVideoList] = useState({ images: [], previews: [] });
  const [loadingBtn, setLoadingBtn] = useState(false);

  useEffect(() => {
    if (uuid && data?.id) {
      const body = {
        // basic info
        ...getLanguageFields(languages, data, ['title', 'description']),

        // organization
        category: createSelectObject(data?.category),
        type: data?.type,
        state: data?.state,

        // location
        region: createSelectObject(data?.region),
        country: createSelectObject(data?.country),
        city: createSelectObject(data?.city),
        area: createSelectObject(data?.area),

        // pricing
        price: data?.price || 0,
        currency: createSelectObject(
          data?.currency?.id ? data?.currency : defaultCurrency,
        ),

        // user info
        user: {
          label: `${data?.user?.lastname?.[0]?.concat('.') || ''} ${
            data?.user?.firstname || t('N/A')
          }`,
          value: data?.user?.id,
          key: `${data?.user?.id},${data?.user?.email || ''},${data?.user?.phone || ''}`,
        },
        contact_name: data?.contact_name,
        email: data?.email,
        phone: data?.phone,
      };
      setImageList(createImages(data?.galleries));
      setVideoList(createMediaFile(data?.galleries));
      form.setFieldsValue(body);
    }
    return () => {};
    // eslint-disable-next-line
  }, [data, uuid]);

  const onFinish = (values) => {
    setLoadingBtn(true);
    const body = {
      // basic info
      title: getTranslationFields(languages, values),
      description: getTranslationFields(languages, values, 'description'),
      // organization
      category_id: values?.category?.value,
      type: values.type,
      state: values.state,
      active: Number(values?.active),
      // pricing
      price: values?.price,
      currency: values?.currency?.value,
      // media
      images: [...videoList?.images, ...imageList].map((item) => item?.name),
      previews: videoList?.previews?.map((item) => item?.name),
      // location
      region_id: values?.region?.value,
      country_id: values?.country?.value,
      city_id: values?.city?.value,
      area_id: values?.area?.value || undefined,
      // user info
      user_id: values?.user?.value,
      contact_name: values?.contact_name,
      email: values?.email,
      phone: values?.phone,
    };

    handleSubmit(body).finally(() => setLoadingBtn(false));
  };

  return (
    <Form
      form={form}
      layout='vertical'
      onFinish={onFinish}
      initialValues={{
        active: true,
        age_limit: 12,
        interval: 1,
        max_qty: 2,
        min_qty: 1,
        tax: 0,
        price: 0,
        currency: createSelectObject(defaultCurrency),
        type: 'private',
        state: 1,
      }}
    >
      <Row gutter={12}>
        <Col span={16}>
          <BasicInfo loading={loading} />
          <Pricing loading={loading} />
          <UserInfo loading={loading} form={form} />
          <Media
            form={form}
            imageList={imageList}
            setImageList={setImageList}
            videoList={videoList}
            setVideoList={setVideoList}
            loading={loading}
          />
        </Col>
        <Col span={8}>
          <Organization loading={loading} />
          <Location loading={loading} form={form} />
        </Col>
      </Row>
      <Button type='primary' htmlType='submit' loading={loadingBtn}>
        {t('next')}
      </Button>
    </Form>
  );
};

export default Details;
