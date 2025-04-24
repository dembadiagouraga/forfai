import { Row, Col, Card, Form, Input } from 'antd';
import { useTranslation } from 'react-i18next';
import { shallowEqual, useSelector } from 'react-redux';
import TextArea from 'antd/es/input/TextArea';
const BasicInfo = ({ loading = false }) => {
  const { t } = useTranslation();
  const { defaultLang, languages } = useSelector(
    (state) => state.formLang,
    shallowEqual,
  );
  return (
    <Card title={t('basic.info')} loading={loading}>
      <Row gutter={12}>
        <Col span={24}>
          {languages.map((item) => (
            <Form.Item
              label={t('name')}
              name={`title[${item?.locale || 'en'}]`}
              key={item?.locale}
              hidden={item?.locale !== defaultLang}
              rules={[
                {
                  required: item?.locale === defaultLang,
                  message: t('required'),
                },
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
          ))}
        </Col>
        <Col span={24}>
          {languages.map((item) => (
            <Form.Item
              label={t('description')}
              name={`description[${item?.locale || 'en'}]`}
              key={item?.locale}
              hidden={item?.locale !== defaultLang}
              rules={[
                { 
                  // required: item?.locale === defaultLang,
                  required: false,
                  message: t('required'),
                },
                {
                  type: 'string',
                  min: 2,
                  max: 5000,
                  message: t('min.2.max.200.chars'),
                },
              ]}
            >
              <TextArea rows={2} />
            </Form.Item>
          ))}
        </Col>
        {/* <Col span={24}>
          <Form.Item
            label={t('phone')}
            name='phone'
            rules={[
              {
                required: true,
                message: t('phone.required'),
              },
              {
                pattern: /^[0-9\b]+$/,
                message: t('phone.pattern'),
              },
            ]}
          >
            <Input placeholder={t('phone.placeholder')} />
          </Form.Item>
        </Col> */}
      </Row>
    </Card>
  );
};

export default BasicInfo;
