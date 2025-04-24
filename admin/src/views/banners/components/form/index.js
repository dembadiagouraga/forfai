import { useNavigate, useParams } from 'react-router-dom';
import { useEffect, useState } from 'react';
import bannerService from 'services/banner';
import getLanguageFields from 'helpers/getLanguageFields';
import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import { Button, Col, Form, Row } from 'antd';
import { disableRefetch, removeFromMenu } from 'redux/slices/menu';
import getTranslationFields from 'helpers/getTranslationFields';
import BannerFormBasic from './basic';
import BannerFormMedia from './media';
import { fetchBanners } from 'redux/slices/banner';
import useDidUpdate from 'helpers/useDidUpdate';
import { useTranslation } from 'react-i18next';
import createImage from 'helpers/createImage';

const BannerForm = ({ handleSubmit }) => {
  const { id } = useParams();
  const { t } = useTranslation();
  const [form] = Form.useForm();
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const { languages } = useSelector((state) => state.formLang, shallowEqual);
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);

  const [loading, setLoading] = useState(false);
  const [loadingBtn, setLoadingBtn] = useState(false);
  const [imageList, setImageList] = useState([]);

  const fetchBanner = (id) => {
    setLoading(true);
    bannerService
      .getById(id)
      .then((res) => {
        const body = {
          ...getLanguageFields(languages, res?.data, ['title', 'description']),
          products: res?.data?.products?.map((product) => ({
            label: product?.translation?.title,
            value: product?.id,
            key: product?.id,
          })),
        };
        if (res?.data?.img) {
          setImageList([createImage(res?.data?.img)]);
        }
        form.setFieldsValue(body);
      })
      .finally(() => setLoading(false));
  };

  const fetch = () => {
    fetchBanner(id);
    dispatch(disableRefetch(activeMenu));
  };

  const onFinish = (values) => {
    const body = {
      clickable: true,
      // basic info
      title: getTranslationFields(languages, values),
      description: getTranslationFields(languages, values, 'description'),
      products: values?.products?.map((item) => item?.value),
      // media
      images: imageList.map((item) => item?.name),
    };
    setLoadingBtn(true);
    handleSubmit(body)
      .then(() => {
        const nextUrl = 'banners';
        batch(() => {
          dispatch(removeFromMenu({ ...activeMenu, nextUrl }));
          dispatch(fetchBanners({}));
        });
        navigate(`/${nextUrl}`);
      })
      .finally(() => setLoadingBtn(false));
  };

  useEffect(() => {
    if (id) {
      fetch();
    }
    return () => {};
    // eslint-disable-next-line
  }, [id]);

  useDidUpdate(() => {
    if (activeMenu.refetch && id) {
      fetch();
    }
  }, [activeMenu.refetch, id]);

  return (
    <Form form={form} layout='vertical' onFinish={onFinish}>
      <Row gutter={12}>
        <Col span={16}>
          <BannerFormBasic loading={loading} />
        </Col>
        <Col flex='1'>
          <BannerFormMedia
            form={form}
            imageList={imageList}
            setImageList={setImageList}
            loading={loading}
          />
        </Col>
      </Row>
      <Button htmlType='submit' loading={loadingBtn} type='primary'>
        {t('submit')}
      </Button>
    </Form>
  );
};

export default BannerForm;
