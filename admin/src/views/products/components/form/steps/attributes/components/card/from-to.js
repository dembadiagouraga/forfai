import { Col, Form, Input, Row } from 'antd';
import { getValueFromTranslations } from 'helpers/getValueFromTranslations';
import { shallowEqual, useSelector } from 'react-redux';
import { useTranslation } from 'react-i18next';

const FromTo = ({ data }) => {
  const { t } = useTranslation();
  const { defaultLang } = useSelector((state) => state.formLang, shallowEqual);
  return (
    <Row gutter={12}>
      <h5 className='ml-2 mb-4'>
        {getValueFromTranslations('title', data?.translations, defaultLang) ||
          t('N/A')}
      </h5>
      <Col span={24}>
        <Form.Item
          label={t('from')}
          name={`from_from_${data?.id}`}
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
      <Col span={24}>
        <Form.Item
          label={t('to')}
          name={`from_to_${data?.id}`}
          rules={[
            {
              required: !!data?.required,
              message: t('required'),
            },
          ]}
        >
          <Input
            placeholder={getValueFromTranslations(
              'placeholder_to',
              data?.translations,
              defaultLang,
            )}
          />
        </Form.Item>
      </Col>
    </Row>
  );
};

export default FromTo;
