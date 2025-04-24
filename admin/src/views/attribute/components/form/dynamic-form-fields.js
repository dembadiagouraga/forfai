import { Button, Col, Divider, Form, Input, Row } from 'antd';
import React, { Fragment } from 'react';
import { shallowEqual, useSelector } from 'react-redux';
import { useTranslation } from 'react-i18next';
import { DeleteOutlined } from '@ant-design/icons';

const DynamicFormFields = ({ field, attributeType }) => {
  const { t } = useTranslation();
  const { languages, defaultLang } = useSelector(
    (state) => state.formLang,
    shallowEqual,
  );

  switch (attributeType) {
    case 'yes_or_no':
      return (
        <>
          <Divider plain>{t('options')}</Divider>
          <Form.List name={[field.name, 'value']}>
            {(subFields) => (
              <Row gutter={10}>
                {subFields.map((subField, idx) => (
                  <Col className='flex-grow-1' key={idx}>
                    {languages.map((item) => (
                      <Form.Item
                        className='mb-1'
                        label={idx === 0 ? t('yes') : t('no')}
                        name={[subField.name, `title[${item?.locale || 'en'}]`]}
                        key={item?.locale + '-' + idx}
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
                ))}
              </Row>
            )}
          </Form.List>
        </>
      );
    case 'from_to':
      return (
        <>
          {languages.map((item) => (
            <Form.Item
              label={t('placeholder')}
              name={[field.name, `placeholder[${item?.locale || 'en'}]`]}
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
          {languages.map((item) => (
            <Form.Item
              label={t('placeholder_to')}
              name={[field.name, `placeholder_to[${item?.locale || 'en'}]`]}
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
        </>
      );
    case 'drop_down':
      return (
        <>
          {languages.map((item) => (
            <Form.Item
              label={t('placeholder')}
              name={[field.name, `placeholder[${item?.locale || 'en'}]`]}
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
          <Divider plain>{t('options')}</Divider>
          <Form.List name={[field.name, 'value']}>
            {(subFields, subOpt) => (
              <div
                style={{ display: 'flex', flexDirection: 'column', rowGap: 16 }}
                key={field.name}
              >
                {subFields.map((subField, idx) => (
                  <Row gutter={10} justify='space-between' key={idx}>
                    <Col className='flex-grow-1'>
                      {languages.map((item) => (
                        <Form.Item
                          className='mb-0'
                          name={[
                            subField.name,
                            `title[${item?.locale || 'en'}]`,
                          ]}
                          key={item?.locale + '-' + idx}
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
                    <Col>
                      <Button
                        icon={<DeleteOutlined />}
                        type='danger'
                        onClick={() => subOpt.remove(subField.name)}
                        disabled={subFields.length <= 1}
                      />
                    </Col>
                  </Row>
                ))}
                <Button type='dashed' onClick={() => subOpt.add()} block>
                  + {t('add.option')}
                </Button>
              </div>
            )}
          </Form.List>
        </>
      );
    case 'input':
      return (
        <>
          {languages.map((item) => (
            <Form.Item
              label={t('placeholder')}
              name={[field.name, `placeholder[${item?.locale || 'en'}]`]}
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
        </>
      );
    case 'checkbox':
      return (
        <>
          {languages.map((item) => (
            <Form.Item
              label={t('placeholder')}
              name={[field.name, `placeholder[${item?.locale || 'en'}]`]}
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
          <Divider plain>{t('options')}</Divider>
          <Form.List name={[field.name, 'value']}>
            {(subFields, subOpt) => (
              <div
                style={{ display: 'flex', flexDirection: 'column', rowGap: 16 }}
                key={field.name}
              >
                {subFields.map((subField, idx) => (
                  <Row gutter={10} justify='space-between' key={idx}>
                    <Col className='flex-grow-1'>
                      {languages.map((item) => (
                        <Form.Item
                          className='mb-0'
                          name={[
                            subField.name,
                            `title[${item?.locale || 'en'}]`,
                          ]}
                          key={item?.locale + '-' + idx}
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
                    <Col>
                      <Button
                        icon={<DeleteOutlined />}
                        type='danger'
                        onClick={() => subOpt.remove(subField.name)}
                        disabled={subFields.length <= 1}
                      />
                    </Col>
                  </Row>
                ))}
                <Button type='dashed' onClick={() => subOpt.add()} block>
                  + {t('add.option')}
                </Button>
              </div>
            )}
          </Form.List>
        </>
      );
    case 'radio':
      return (
        <>
          {languages.map((item) => (
            <Form.Item
              label={t('placeholder')}
              name={[field.name, `placeholder[${item?.locale || 'en'}]`]}
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
          <Divider plain>{t('options')}</Divider>
          <Form.List name={[field.name, 'value']}>
            {(subFields, subOpt) => (
              <div
                style={{ display: 'flex', flexDirection: 'column', rowGap: 16 }}
                key={field.name}
              >
                {subFields.map((subField, idx) => (
                  <Row gutter={10} justify='space-between' key={idx}>
                    <Col className='flex-grow-1'>
                      {languages.map((item) => (
                        <Form.Item
                          className='mb-0'
                          name={[
                            subField.name,
                            `title[${item?.locale || 'en'}]`,
                          ]}
                          key={item?.locale + '-' + idx}
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
                    <Col>
                      <Button
                        icon={<DeleteOutlined />}
                        type='danger'
                        onClick={() => subOpt.remove(subField.name)}
                        disabled={subFields.length <= 1}
                      />
                    </Col>
                  </Row>
                ))}
                <Button type='dashed' onClick={() => subOpt.add()} block>
                  + {t('add.option')}
                </Button>
              </div>
            )}
          </Form.List>
        </>
      );
    default:
      return null;
  }
};

export default DynamicFormFields;
