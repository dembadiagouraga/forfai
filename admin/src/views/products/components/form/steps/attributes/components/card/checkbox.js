import { useTranslation } from 'react-i18next';
import { getValueFromTranslations } from 'helpers/getValueFromTranslations';
import { Checkbox, Col, Form, Row } from 'antd';

const CheckboxAttributes = ({ data }) => {
  const { t } = useTranslation();

  return (
    <Row gutter={12}>
      <Col span={24}>
        <Form.Item
          label={
            getValueFromTranslations('title', data?.translations) || t('N/A')
          }
          name={`checkbox_${data?.id}`}
          rules={[
            {
              required: !!data?.required,
              message: t('required'),
            },
          ]}
        >
          <Checkbox.Group>
            <Row gutter={12}>
              {data?.values?.map((item) => (
                <Col key={item?.id}>
                  <Checkbox value={item?.id}>
                    {getValueFromTranslations('title', item?.translations) ||
                      t('N/A')}
                  </Checkbox>
                </Col>
              ))}
            </Row>
          </Checkbox.Group>
        </Form.Item>
      </Col>
    </Row>
  );
};

export default CheckboxAttributes;
