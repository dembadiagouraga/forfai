import { useEffect, useState } from 'react';
import { Button, Card, Col, Form, Row } from 'antd';
import { useTranslation } from 'react-i18next';
import { useSelector, shallowEqual } from 'react-redux';
import { useDispatch } from 'react-redux';
import getTranslationFields from 'helpers/getTranslationFields';
import { useParams } from 'react-router-dom';
import productService from 'services/product';
import { disableRefetch } from 'redux/slices/menu';
import getLanguageFields from 'helpers/getLanguageFields';
import createSelectObject from 'helpers/createSelectObject';
import useDidUpdate from 'helpers/useDidUpdate';
import { createImages, createMediaFile } from 'helpers/createImage';
import BasicInfo from './components/basic-info';
import Organization from './components/organization';
import Pricing from './components/pricing';
import Media from './components/media';
import Location from './components/location';

const ProductForm = ({ handleSubmit }) => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const [form] = Form.useForm();
  const { uuid } = useParams();
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const { languages } = useSelector((state) => state.formLang, shallowEqual);
  const { defaultCurrency } = useSelector(
    (state) => state.currency,
    shallowEqual,
  );
  const [imageList, setImageList] = useState([]);
  const [videoList, setVideoList] = useState({ images: [], previews: [] });
  const [loading, setLoading] = useState(false);
  const [loadingBtn, setLoadingBtn] = useState(false);

  const fetchVacancy = (uuid) => {
    if (!uuid) return;
    setLoading(true);
    productService
      .getById(uuid)
      .then(({ data }) => {
        const body = {
          // basic info
          ...getLanguageFields(languages, data, ['title', 'description']),
          // organization
          category: createSelectObject(data?.category),
          brand: createSelectObject(data?.brand),
          type: 'business',
          user: {
            label: `${data?.user?.lastname?.[0]?.concat('.') || ''} ${
              data?.user?.firstname || t('N/A')
            }`,
            value: data?.user?.id,
            key: data?.user?.id,
          },
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
          // additions
          phone: data?.phone,
          active: Boolean(data?.active),
          age_limit: data?.age_limit || 0,
        };
        setImageList(createImages(data?.galleries));
        setVideoList(createMediaFile(data?.galleries));
        form.setFieldsValue(body);
      })
      .finally(() => setLoading(false));
  };

  useDidUpdate(() => {
    if (!!uuid && activeMenu.refetch) {
      fetchVacancy(uuid);
      dispatch(disableRefetch(activeMenu));
    }
  }, [activeMenu.refetch]);

  useEffect(() => {
    if (!!uuid) {
      fetchVacancy(uuid);
      dispatch(disableRefetch(activeMenu));
    }
    // eslint-disable-next-line
  }, [uuid]);

  const onFinish = (values) => {
    setLoadingBtn(true);
    const body = {
      // basic info
      title: getTranslationFields(languages, values),
      description: getTranslationFields(languages, values, 'description'),
      // organization
      user_id: values?.user?.value,
      category_id: values?.category?.value,
      // brand is not required, so we need to check if it exists
      type: 'business',
      work: 1,
      // pricing
      price: values?.price,
      currency: values?.currency?.value,
      // media
      images: [...videoList?.images, ...imageList].map((item) => item.name),
      previews: videoList?.previews?.map((item) => item.name),
      // additions
      active: Number(values?.active),
      age_limit: values?.age_limit,
      phone: values.phone,
      // location
      region_id: values?.region?.value,
      country_id: values?.country?.value,
      city_id: values?.city?.value,
      area_id: values?.area?.value || undefined,
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
      }}
    >
      <Row gutter={12}>
        <Col span={16}>
          <BasicInfo loading={loading} />
          <Pricing loading={loading} />
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
      <Card className='formFooterButtonsContainer'>
        <Button type='primary' htmlType='submit' loading={loadingBtn}>
          {t('next')}
        </Button>
      </Card>
    </Form>
  );
};

export default ProductForm;
