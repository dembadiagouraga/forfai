import { useMemo } from 'react';
import { Card, Col, Row, InputNumber, Form } from 'antd';
import { useTranslation } from 'react-i18next';
import currencyService from 'services/currency';
import { DebounceSelect } from 'components/search';

const Pricing = ({ loading = false }) => {
  const { t } = useTranslation();
  const fetchCurrencies = useMemo(
    () => async () => {
      const params = {
        active: 1,
      };
      return currencyService.getAll(params).then(({ data }) =>
        data?.map((item) => ({
          label: `${item?.title} ( ${item?.symbol} )`,
          value: item?.id,
          key: item?.id,
        })),
      );
    },
    [],
  );
  return (
    <Card title={t('pricing')} loading={loading}>
      <Row gutter={24}>
        <Col flex='1 1 0'>
          <Form.Item
            label={t('price')}
            name='price'
            rules={[
              {
                required: true,
                message: t('required'),
              },
            ]}
          >
            <InputNumber min={0} className='w-100' />
          </Form.Item>
        </Col>
        <Col flex='1 1 0'>
          <Form.Item
            label={t('currency')}
            name='currency'
            rules={[
              {
                required: true,
                message: t('required'),
              },
            ]}
          >
            <DebounceSelect fetchOptions={fetchCurrencies} allowClear={false} />
          </Form.Item>
        </Col>
      </Row>
    </Card>
  );
};

export default Pricing;
