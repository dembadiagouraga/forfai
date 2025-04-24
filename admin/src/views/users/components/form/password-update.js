import { Button, Col, Form, Input, Row } from 'antd';
import { useTranslation } from 'react-i18next';
import { useState } from 'react';
import userService from 'services/user';
import { toast } from 'react-toastify';

const PasswordUpdate = ({ uuid }) => {
  const [form] = Form.useForm();
  const { t } = useTranslation();
  const [loadingBtn, setLoadingBtn] = useState(false);

  const onFinish = (values) => {
    if (!uuid) {
      toast.error(t('no.uniq.id.of.user.found'));
      return;
    }
    setLoadingBtn(true);
    const body = {
      password: values?.password,
      password_confirmation: values?.password_confirmation,
    };
    userService
      .updatePassword(uuid, body)
      .then(() => {
        toast.success(t('successfully.updated'));
        form.resetFields();
      })
      .finally(() => setLoadingBtn(false));
  };

  return (
    <Form form={form} layout='vertical' onFinish={onFinish}>
      <Row gutter={12}>
        <Col span={12}>
          <Form.Item
            label={t('password')}
            name='password'
            rules={[
              { required: true, message: t('required') },
              {
                validator(_, value) {
                  if (value && value?.length < 6) {
                    return Promise.reject(new Error(t('min.6.letters')));
                  }
                  return Promise.resolve();
                },
              },
            ]}
            normalize={(value) =>
              value?.trim() === '' ? value?.trim() : value
            }
          >
            <Input.Password
              type='password'
              className='w-100'
              maxLength={20}
              placeholder={t('password')}
            />
          </Form.Item>
        </Col>
        <Col span={12}>
          <Form.Item
            label={t('password.confirmation')}
            name='password_confirmation'
            dependencies={['password']}
            hasFeedback
            rules={[
              {
                required: true,
                message: t('required'),
              },
              ({ getFieldValue }) => ({
                validator(rule, value) {
                  if (!value || getFieldValue('password') === value) {
                    return Promise.resolve();
                  }
                  return Promise.reject(t('two.passwords.dont.match'));
                },
              }),
            ]}
            normalize={(value) =>
              value?.trim() === '' ? value?.trim() : value
            }
          >
            <Input.Password
              type='password'
              placeholder={t('password.confirmation')}
            />
          </Form.Item>
        </Col>
      </Row>
      <Button type='primary' htmlType='submit' loading={loadingBtn}>
        {t('submit')}
      </Button>
    </Form>
  );
};

export default PasswordUpdate;
