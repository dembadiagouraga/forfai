import { Button, Col, Form, Input, Row } from 'antd';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import { SketchPicker } from 'react-color';
import { useTranslation } from 'react-i18next';
import React, { useState } from 'react';
import MediaUpload from 'components/upload';
import getTranslationFields from 'helpers/getTranslationFields';
import { removeFromMenu } from 'redux/slices/menu';
import { useNavigate } from 'react-router-dom';
import { fetchStoreis } from 'redux/slices/storeis';

const StoryForm = ({ form, handleSubmit }) => {
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { t } = useTranslation();
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const { languages, defaultLang } = useSelector(
    (state) => state.formLang,
    shallowEqual,
  );
  const [color, setColor] = useState(
    () => form.getFieldValue('color') || '#000',
  );

  const [image, setImage] = useState(() => form.getFieldValue('images') || []);
  const [loadingBtn, setLoadingBtn] = useState(false);

  const onFinish = (values) => {
    setLoadingBtn(true);
    const body = {
      title: getTranslationFields(languages, values),
      color: values.color?.hex,
      file_urls: values.images.map((item) => item.url),
    };

    handleSubmit(body)
      .then(() => {
        const nextUrl = 'stories';
        dispatch(removeFromMenu({ ...activeMenu, nextUrl }));
        dispatch(fetchStoreis({}));
        navigate(`/${nextUrl}`);
      })
      .finally(() => setLoadingBtn(false));
  };

  return (
    <Form
      name='story-form'
      layout='vertical'
      onFinish={onFinish}
      form={form}
      initialValues={{ color: { hex: '#000' } }}
      className='d-flex flex-column h-100'
    >
      <Row gutter={12}>
        <Col span={24}>
          <Form.Item
            label={t('image')}
            name='images'
            rules={[
              {
                required: image.length === 0,
                message: t('required'),
              },
            ]}
          >
            <MediaUpload
              type='categories'
              imageList={image}
              setImageList={setImage}
              form={form}
              multiple={false}
            />
          </Form.Item>
        </Col>
        <Col span={24}>
          {languages.map((item) => (
            <Form.Item
              label={t('title')}
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
          <Form.Item
            label={t('story.text.color')}
            name='color'
            rules={[
              {
                required: true,
                message: t('required'),
              },
            ]}
          >
            <SketchPicker
              onChangeComplete={(color) => setColor(color.hex)}
              color={color}
            />
          </Form.Item>
        </Col>
      </Row>
      <div className='flex-grow-1 d-flex flex-column justify-content-end'>
        <div className='pb-5'>
          <Button type='primary' htmlType='submit' loading={loadingBtn}>
            {t('submit')}
          </Button>
        </div>
      </div>
    </Form>
  );
};

export default StoryForm;
