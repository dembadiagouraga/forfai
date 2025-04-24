import { Col, Form, Row, Select } from 'antd';
import { shallowEqual, useSelector } from 'react-redux';
import { useMemo } from 'react';
import { getValueFromTranslations } from 'helpers/getValueFromTranslations';
import { useTranslation } from 'react-i18next';

const DropDown = ({ data }) => {
  const { t } = useTranslation();
  const { defaultLang } = useSelector((state) => state.formLang, shallowEqual);

  const options = useMemo(
    () =>
      data?.values?.map((item) => ({
        label: getValueFromTranslations('title', item?.translations),
        value: item?.id,
        key: item?.id,
      })),
    // eslint-disable-next-line
    [defaultLang, data?.values],
  );

  return (
    <Row gutter={12}>
      <Col span={24}>
        <Form.Item
          label={
            getValueFromTranslations('title', data?.translations) || t('N/A')
          }
          name={`drop_down_${data?.id}`}
          rules={[
            {
              required: !!data?.required,
              message: t('required'),
            },
          ]}
        >
          <Select options={options} />
        </Form.Item>
      </Col>
    </Row>
  );
};

export default DropDown;
