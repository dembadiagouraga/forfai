import { Button, Card, Col, Form, Row, Space } from 'antd';
import BasicInfo from './components/basic-info';
import Additions from './components/additions';
import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import getTranslationFields from 'helpers/getTranslationFields';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import advertService from 'services/advert';
import createSelectObject from 'helpers/createSelectObject';
import getLanguageFields from 'helpers/getLanguageFields';
import useDidUpdate from 'helpers/useDidUpdate';
import { disableRefetch, removeFromMenu } from 'redux/slices/menu';
import { useNavigate, useParams } from 'react-router-dom';
import { toast } from 'react-toastify';
import LanguageList from 'components/language-list';
import { fetchAdverts } from 'redux/slices/advert';

const AdsForm = ({ handleSubmit }) => {
  const [form] = Form.useForm();
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { id } = useParams();
  const { languages } = useSelector((state) => state.formLang, shallowEqual);
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const [loading, setLoading] = useState(false);
  const [loadingBtn, setLoadingBtn] = useState(false);

  const fetchAds = (id) => {
    if (!id) return;
    setLoading(true);
    advertService
      .getById(id)
      .then(({ data }) => {
        const body = {
          // basic info
          ...getLanguageFields(languages, data, ['title', 'description']),
          // additions
          category: createSelectObject(data?.category),
          time: data?.time || 0,
          time_type: data?.time_type,
          price: data?.price || 0,
          count: data?.count || 0,
          active: Boolean(data?.active),
        };
        form.setFieldsValue(body);
      })
      .finally(() => setLoading(false));
  };

  useDidUpdate(() => {
    if (!!id && activeMenu.refetch) {
      fetchAds(id);
      dispatch(disableRefetch(activeMenu));
    }
  }, [activeMenu.refetch]);

  useEffect(() => {
    if (!!id) {
      fetchAds(id);
      dispatch(disableRefetch(activeMenu));
    }
    // eslint-disable-next-line
  }, [id]);

  const onFinish = (values) => {
    setLoadingBtn(true);
    const body = {
      // basic info
      title: getTranslationFields(languages, values),
      description: getTranslationFields(languages, values, 'description'),
      // additions
      category_id: values?.category?.value,
      time: values?.time,
      time_type: values?.time_type,
      price: values?.price,
      count: values?.count,
      active: Boolean(values?.active),
    };
    handleSubmit(body)
      .then(() => {
        const nextUrl = 'catalog/advert';
        navigate(`/${nextUrl}`);
        toast.success(t('successfully.created'));
        dispatch(removeFromMenu({ ...activeMenu, nextUrl }));
        dispatch(fetchAdverts({}));
      })
      .finally(() => setLoadingBtn(false));
  };

  return (
    <>
      <Space
        style={{
          marginBottom: '20px',
          display: 'flex',
          justifyContent: 'flex-end',
        }}
      >
        <LanguageList />
      </Space>
      <Form form={form} layout='vertical' onFinish={onFinish}>
        <Row gutter={12}>
          <Col span={24}>
            <BasicInfo loading={loading} />
          </Col>
          <Col span={24}>
            <Additions loading={loading} />
          </Col>
        </Row>
        <Card className='formFooterButtonsContainer'>
          <Button type='primary' htmlType='submit' loading={loadingBtn}>
            {t('submit')}
          </Button>
        </Card>
      </Form>
    </>
  );
};
export default AdsForm;
