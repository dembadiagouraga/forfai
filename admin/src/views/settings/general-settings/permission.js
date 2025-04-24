import { Card, Col, Form, Row, Switch } from 'antd';
import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useSelector } from 'react-redux';
import { useDispatch } from 'react-redux';
import { shallowEqual } from 'react-redux';
import { toast } from 'react-toastify';
import settingService from 'services/settings';
import { fetchSettings } from 'redux/slices/globalSettings';
import { CheckOutlined, CloseOutlined } from '@ant-design/icons';
import useDemo from 'helpers/useDemo';

const permissionList = [
  {
    key: 'is_demo',
    title: 'is.demo',
    description: 'You.choose.whether.enable.is.demo.or.not',
  },
  {
    key: 'blog_active',
    title: 'blog.active',
    description: 'You.choose.to.display.the.blog.page.yourself',
  },
  {
    key: 'prompt_email_modal',
    title: 'prompt.email.modal',
    description: 'Send.sms.to.email.subscribers',
  },
  {
    key: 'referral_active',
    title: 'referral.active',
    description: 'You.choose.whether.the.referral.will.work.or.not',
  },
  {
    key: 'aws',
    title: 'aws.active',
    description: 'You.choose.whether.the.aws.will.work.or.not',
  },
  {
    key: 'product_auto_approve',
    title: 'auto.approve.products',
    description: 'You.choose.whether.auto.approve.products.or.not',
  },
  {
    key: 'category_auto_approve',
    title: 'auto.approve.categories',
    description: 'You.choose.whether.auto.approve.categories.or.not',
  },
  {
    key: 'show_ads',
    title: 'show.ads',
    description: 'is.ads.enabled',
  },
];

const Permission = () => {
  const { t } = useTranslation();
  const { isDemo } = useDemo();
  const [form] = Form.useForm();
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const dispatch = useDispatch();
  const [loadingBtn, setLoadingBtn] = useState(false);

  const updateSettings = (body) => {
    setLoadingBtn(true);
    settingService
      .update(body)
      .then(() => {
        toast.success(t('successfully.updated'));
        dispatch(fetchSettings({}));
      })
      .finally(() => setLoadingBtn(false));
  };

  return (
    <Form
      layout='vertical'
      form={form}
      name='global-settings'
      initialValues={{
        ...activeMenu.data,
        show_ads: Number(activeMenu.data?.show_ads),
        active_parcel: Number(activeMenu.data?.active_parcel),
      }}
    >
      <div
        style={{
          maxWidth: '800px',
          width: '100%',
        }}
      >
        <Card title={t('permission')}>
          <Row gutter={24}>
            {permissionList.map((item) => (
              <Col span={24}>
                <div className='d-flex justify-content-between align-items-center'>
                  <Form.Item style={{ margin: '0 !important' }}>
                    <div>
                      <h5>{t(item.title)}</h5>
                      <p className='m-0'>{t(item.description)}</p>
                    </div>
                  </Form.Item>
                  <Form.Item name={item.key} valuePropName='checked'>
                    <Switch
                      checkedChildren={<CheckOutlined />}
                      unCheckedChildren={<CloseOutlined />}
                      disabled={
                        (item.key !== 'is_demo' && isDemo) ||
                        item.key === 'show_ads'
                      }
                      loading={loadingBtn}
                      onChange={(checked) => {
                        updateSettings({ [item.key]: checked });
                      }}
                    />
                  </Form.Item>
                </div>
              </Col>
            ))}
          </Row>
        </Card>
      </div>
    </Form>
  );
};

export default Permission;
