import { useTranslation } from 'react-i18next';
import { Col, Form, Input, Row } from 'antd';
import { getValueFromTranslations } from 'helpers/getValueFromTranslations';
import { shallowEqual, useSelector } from 'react-redux';

const InputAttributes = ({ data }) => {
  const { t } = useTranslation();
  const { defaultLang } = useSelector((state) => state.formLang, shallowEqual);

  return (
    <Row gutter={12}>
      <Col span={24}>
        <Form.Item
          name={`input_${data?.id}`}
          label={
            getValueFromTranslations('title', data?.translations) || t('N/A')
          }
          rules={[
            {
              required: !!data?.required,
              message: t('required'),
            },
          ]}
        >
          <Input
            placeholder={getValueFromTranslations(
              'placeholder',
              data?.translations,
              defaultLang,
            )}
          />
        </Form.Item>
      </Col>
    </Row>
  );
};

export default InputAttributes;
