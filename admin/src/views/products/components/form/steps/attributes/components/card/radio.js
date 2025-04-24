import { useTranslation } from 'react-i18next';
import { Col, Form, Radio, Row } from 'antd';
import { getValueFromTranslations } from 'helpers/getValueFromTranslations';

const RadioAttribute = ({ data }) => {
  const { t } = useTranslation();

  return (
    <Row gutter={12}>
      <Col span={24}>
        <Form.Item
          label={
            getValueFromTranslations('title', data?.translations) || t('N/A')
          }
          name={`radio_${data?.id}`}
          rules={[
            {
              required: !!data?.required,
              message: t('required'),
            },
          ]}
        >
          <Radio.Group>
            <Row gutter={12}>
              {data?.values?.map((item) => (
                <Col key={item?.id}>
                  <Radio value={item?.id}>
                    {getValueFromTranslations('title', item?.translations) ||
                      t('N/A')}
                  </Radio>
                </Col>
              ))}
            </Row>
          </Radio.Group>
        </Form.Item>
      </Col>
    </Row>
  );
};

export default RadioAttribute;
