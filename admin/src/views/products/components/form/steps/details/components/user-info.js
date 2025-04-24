import { Card, Col, Form, Input, Row } from 'antd';
import { useTranslation } from 'react-i18next';
import { DebounceSelect } from 'components/search';
import userService from 'services/user';
import { useEffect } from 'react';

const UserInfo = ({ loading = false, form }) => {
  const { t } = useTranslation();
  const selectedUser = Form.useWatch('user', form);
  const selectedEmail = Form.useWatch('email', form);
  const selectedPhone = Form.useWatch('phone', form);
  const selectedContactName = Form.useWatch('contact_name', form);

  const selectedUserKeyArray = selectedUser?.key?.split(',');

  const fetchUserOptions = (search) => {
    const params = {
      search: search?.length ? search : undefined,
      page: 1,
      perPage: 20,
    };
    return userService.getAll(params).then((res) =>
      res?.data?.map((item) => ({
        label: `${item?.lastname?.[0]?.concat('.') || ''} ${
          item?.firstname || t('N/A')
        }`,
        value: item?.id,
        key: `${item?.id},${item?.email || ''},${item?.phone || ''}`,
      })),
    );
  };

  useEffect(() => {
    if (!selectedContactName && selectedUser?.label) {
      form.setFieldsValue({
        contact_name: selectedUser?.label,
      });
    }
    if (!selectedEmail && selectedUserKeyArray?.[1]) {
      form.setFieldsValue({
        email: selectedUserKeyArray?.[1],
      });
    }
    if (!selectedPhone && selectedUserKeyArray?.[2]) {
      form.setFieldsValue({
        phone: selectedUserKeyArray?.[2],
      });
    }
    // eslint-disable-next-line
  }, [selectedUser, selectedEmail, selectedPhone, selectedContactName]);

  return (
    <Card title={t('seller.info')} loading={loading}>
      <Row gutter={12}>
        <Col span={12}>
          <Form.Item
            label={t('seller')}
            name='user'
            rules={[
              {
                required: true,
                message: t('required'),
              },
            ]}
          >
            <DebounceSelect fetchOptions={fetchUserOptions} />
          </Form.Item>
        </Col>
        <Col span={12}>
          <Form.Item
            label={t('contact.name')}
            name='contact_name'
            rules={[{ required: true, message: t('required') }]}
          >
            <Input />
          </Form.Item>
        </Col>
        <Col span={12}>
          <Form.Item
            label={t('email')}
            name='email'
            rules={[
              { required: true, message: t('required') },
              {
                type: 'email',
                message: t('invalid.email'),
              },
            ]}
          >
            <Input />
          </Form.Item>
        </Col>
        <Col span={12}>
          <Form.Item
            label={t('phone')}
            name='phone'
            rules={[
              {
                required: true,
                message: t('phone.required'),
              },
            ]}
          >
            <Input />
          </Form.Item>
        </Col>
      </Row>
    </Card>
  );
};

export default UserInfo;
