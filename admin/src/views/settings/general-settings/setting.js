import { Button, Col, Form, Input, Row, Space } from 'antd';
import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useDispatch } from 'react-redux';
import { shallowEqual, useSelector } from 'react-redux';
import { toast } from 'react-toastify';
import ImageUploadSingle from 'components/image-upload-single';
import settingService from 'services/settings';
import { fetchSettings } from 'redux/slices/globalSettings';
import useDemo from 'helpers/useDemo';

const Setting = ({ setFavicon, favicon, setLogo, logo }) => {
  const { t } = useTranslation();
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const dispatch = useDispatch();
  const [loadingBtn, setLoadingBtn] = useState(false);
  const [form] = Form.useForm();
  const { isDemo } = useDemo();

  function updateSettings(data) {
    setLoadingBtn(true);
    settingService
      .update(data)
      .then(() => {
        toast.success(t('successfully.updated'));
        dispatch(fetchSettings({}));
      })
      .finally(() => setLoadingBtn(false));
  }

  const onFinish = (values) => {
    const body = {
      ...values,
      favicon: favicon?.name,
      logo: logo?.name,
    };
    updateSettings(body);
  };

  return (
    <Form
      layout='vertical'
      form={form}
      name='global-settings'
      onFinish={onFinish}
      initialValues={{
        delivery: '1',
        deliveryman_order_acceptance_time:
          Number(activeMenu.data?.deliveryman_order_acceptance_time) || 30,
        ...activeMenu.data,
      }}
    >
      <Row gutter={12}>
        <Col span={24}>
          <Form.Item
            label={t('title')}
            name='title'
            rules={[
              {
                required: true,
                message: t('required'),
              },
              {
                type: 'string',
                min: 2,
                message: t(`min.${2}.characters`),
              },
            ]}
          >
            <Input />
          </Form.Item>
        </Col>
        <Col span={12}>
          <Space>
            <Form.Item
              label={t('favicon')}
              name='favicon'
              rules={[
                {
                  required: true,
                  message: t('required'),
                },
              ]}
            >
              <ImageUploadSingle
                type='languages'
                image={favicon}
                setImage={setFavicon}
                form={form}
                name='favicon'
              />
            </Form.Item>
            <Form.Item
              label={t('logo')}
              name='logo'
              rules={[
                {
                  required: true,
                  message: t('required'),
                },
              ]}
            >
              <ImageUploadSingle
                type='languages'
                image={logo}
                setImage={setLogo}
                form={form}
                name='logo'
              />
            </Form.Item>
          </Space>
        </Col>
      </Row>
      <Button
        onClick={() => form.submit()}
        type='primary'
        disabled={isDemo}
        loading={loadingBtn}
      >
        {t('save')}
      </Button>
    </Form>
  );
};

export default Setting;
