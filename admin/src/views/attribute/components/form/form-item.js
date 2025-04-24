import { CloseOutlined } from '@ant-design/icons';
import { Card, Form, Input, Select } from 'antd';
import { ATTRIBUTE_TYPES } from '../../constants';
import DynamicFormFields from './dynamic-form-fields';
import React from 'react';
import { useTranslation } from 'react-i18next';
import { shallowEqual, useSelector } from 'react-redux';

const AttributeFormItemCard = ({
  form,
  field,
  remove,
  idx,
  isNotLastAttribute,
}) => {
  const { t } = useTranslation();
  const { languages, defaultLang } = useSelector(
    (state) => state.formLang,
    shallowEqual,
  );

  const initialValues = {
    yes_or_no: {
      type: 'yes_or_no',
      value: [
        { [`title[${defaultLang}]`]: 'Yes' },
        { [`title[${defaultLang}]`]: 'No' },
      ],
      [`title[${defaultLang}]`]: 'Question title',
    },
    from_to: {
      type: 'from_to',
      [`title[${defaultLang}]`]: 'Range',
      [`placeholder[${defaultLang}]`]: 'From range',
      [`placeholder_to[${defaultLang}]`]: 'To range',
    },
    drop_down: {
      type: 'drop_down',
      [`title[${defaultLang}]`]: 'Select',
      [`placeholder[${defaultLang}]`]: 'Select an option',
      value: [
        { [`title[${defaultLang}]`]: 'Option 1' },
        { [`title[${defaultLang}]`]: 'Option 2' },
      ],
    },
    input: {
      type: 'input',
      [`title[${defaultLang}]`]: 'Title',
      [`placeholder[${defaultLang}]`]: 'Placeholder',
    },
    checkbox: {
      type: 'checkbox',
      [`title[${defaultLang}]`]: 'Checkbox',
      [`placeholder[${defaultLang}]`]: 'Checkbox an option',
      value: [
        { [`title[${defaultLang}]`]: 'Checkbox option 1' },
        { [`title[${defaultLang}]`]: 'Checkbox option 2' },
      ],
    },
    radio: {
      type: 'radio',
      [`title[${defaultLang}]`]: 'Radio',
      [`placeholder[${defaultLang}]`]: 'Radio an option',
      value: [
        { [`title[${defaultLang}]`]: 'Radio option 1' },
        { [`title[${defaultLang}]`]: 'Radio option 2' },
      ],
    },
  };

  const handleAttributeTypeChange = (attributeType) => {
    const formValues = form.getFieldValue();
    formValues.attributes[idx] = initialValues[attributeType];
    form.setFieldsValue(formValues);
  };

  return (
    <Card
      className='border'
      title={`${t('attribute')}`}
      key={field.key}
      extra={
        isNotLastAttribute && (
          <CloseOutlined
            onClick={() => {
              remove(field.name);
            }}
          />
        )
      }
    >
      <Form.Item
        label={t('type')}
        name={[field.name, 'type']}
        rules={[{ required: true, message: 'required' }]}
      >
        <Select
          onChange={handleAttributeTypeChange}
          options={ATTRIBUTE_TYPES.map((item) => ({
            label: t(item),
            value: item,
          }))}
        />
      </Form.Item>
      {languages.map((item) => (
        <Form.Item
          label={t('title')}
          name={[field.name, `title[${item?.locale || 'en'}]`]}
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
      <Form.Item
        noStyle
        shouldUpdate={(prevValues, currentValues) =>
          prevValues.attributes[idx]?.type !==
          currentValues.attributes[idx]?.type
        }
      >
        {({ getFieldValue }) => (
          <DynamicFormFields
            field={field}
            attributeType={getFieldValue('attributes')[idx]?.type}
          />
        )}
      </Form.Item>
    </Card>
  );
};

export default AttributeFormItemCard;
