import { Button, Col, Form, Input, InputNumber, Modal, Row } from 'antd';
import { useTranslation } from 'react-i18next';
import { useState } from 'react';
import userService from 'services/user';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import { setRefetch } from 'redux/slices/menu';

const WalletTopUp = ({ uuid, visible, closeModal }) => {
  const [form] = Form.useForm();
  const { t } = useTranslation();
  const dispatch = useDispatch();

  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);

  const [loadingBtn, setLoadingBtn] = useState(false);

  const onFinish = (values) => {
    setLoadingBtn(true);
    const body = {
      price: values?.price || 0,
      note: values?.note || undefined,
    };
    userService
      .topupWallet(uuid, body)
      .then(() => {
        closeModal();
        form.resetFields();
        dispatch(setRefetch(activeMenu));
      })
      .finally(() => setLoadingBtn(false));
  };

  return (
    <Modal
      title={t('topup.wallet')}
      visible={visible}
      onCancel={closeModal}
      footer={[
        <Button onClick={closeModal}>{t('cancel')}</Button>,
        <Button type='primary' onClick={form.submit} loading={loadingBtn}>
          {t('submit')}
        </Button>,
      ]}
    >
      <Form form={form} layout='vertical' onFinish={onFinish}>
        <Row gutter={12}>
          <Col span={24}>
            <Form.Item
              name='price'
              label={t('price')}
              rules={[{ required: true, message: t('required') }]}
            >
              <InputNumber min={0} className='w-100' />
            </Form.Item>
          </Col>
          <Col span={24}>
            <Form.Item
              name='note'
              label={t('note')}
              rules={[
                {
                  type: 'string',
                  min: 2,
                  max: 200,
                  message: t('min.2.max.200.chars'),
                },
              ]}
            >
              <Input />
            </Form.Item>
          </Col>
        </Row>
      </Form>
    </Modal>
  );
};

export default WalletTopUp;
