import { Button, Col, Form, Modal, Row, Select } from 'antd';
import { useTranslation } from 'react-i18next';
import { useState } from 'react';

const StatusChangeModal = ({
  visible,
  onCancel,
  onConfirm,
  statuses,
  currentStatus,
}) => {
  const { t } = useTranslation();
  const [form] = Form.useForm();

  const [isLoading, setIsLoading] = useState(false);

  const onFinish = (values) => {
    setIsLoading(true);
    const body = {
      status: values?.status,
    };
    onConfirm(body).finally(() => setIsLoading(false));
  };

  return (
    <Modal
      visible={visible}
      onCancel={onCancel}
      title={t('status.change')}
      footer={[
        <Button onClick={onCancel}>{t('cancel')}</Button>,
        <Button type='primary' onClick={form.submit} loading={isLoading}>
          {t('confirm')}
        </Button>,
      ]}
    >
      <Form
        form={form}
        layout='vertical'
        onFinish={onFinish}
        initialValues={{
          status: currentStatus,
        }}
      >
        <Row gutter={12}>
          <Col span={24}>
            <Form.Item
              name='status'
              label={t('status')}
              rules={[{ required: true, message: t('required') }]}
            >
              <Select
                options={statuses.map((item) => ({
                  label: t(item),
                  value: item,
                  key: item,
                }))}
              />
            </Form.Item>
          </Col>
        </Row>
      </Form>
    </Modal>
  );
};

export default StatusChangeModal;
