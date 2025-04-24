import { Button, Col, Form, Row, Space, Switch } from 'antd';
import { useTranslation } from 'react-i18next';
import categoryService from 'services/category';
import { AsyncTreeSelect } from 'components/async-tree-select-category';
import React, { useMemo, useState } from 'react';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import AttributeFormItemCard from './form-item';
import { removeFromMenu } from 'redux/slices/menu';
import { useNavigate } from 'react-router-dom';
import { fetchAttributes } from 'redux/slices/attributes';
import { parseFormValues } from '../utils';

const AttributeForm = ({
  handleSubmit,
  form,
  isCreateMany = false,
  isEdit = false,
}) => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { languages, defaultLang } = useSelector(
    (state) => state.formLang,
    shallowEqual,
  );
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const [loadingBtn, setLoadingBtn] = useState(false);

  const initialValues = {
    required: true,
    attributes: [
      {
        type: 'yes_or_no',
        value: [
          { [`title[${defaultLang}]`]: 'Yes' },
          { [`title[${defaultLang}]`]: 'no' },
        ],
        [`title[${defaultLang}]`]: 'Question title',
      },
    ],
  };

  const fetchUserCategoryList = useMemo(
    () => async (search) => {
      const params = {
        perPage: 100,
        type: 'main',
        search: search ? search : undefined,
      };
      return categoryService.getAll(params).then((res) =>
        res.data.map((item) => ({
          label: item.translation?.title,
          value: item.id,
          key: item.id,
          type: 'main',
          disabled: item.children?.length,
          children: item.children?.map((el) => ({
            label: el.translation?.title,
            value: el.id,
            key: el.id,
            type: 'sub_main',
            disabled: el.children?.length,
            children: el.children?.map((three) => ({
              label: three.translation?.title,
              value: three.id,
              key: three.id,
              type: 'child',
            })),
          })),
        })),
      );
    },
    [],
  );

  const onFinish = (values) => {
    setLoadingBtn(true);
    const parsedData = parseFormValues(values, languages, isCreateMany, isEdit);

    handleSubmit(parsedData)
      .then(() => {
        const nextUrl = 'attributes';
        dispatch(removeFromMenu({ ...activeMenu, nextUrl }));
        dispatch(fetchAttributes({}));
        navigate(`/${nextUrl}`);
      })
      .finally(() => setLoadingBtn(false));
  };

  return (
    <>
      <Form
        onFinish={onFinish}
        initialValues={initialValues}
        form={form}
        layout='vertical'
      >
        <Space direction='vertical' align='center' className='w-100'>
          <div style={{ width: '700px', flex: 1 }}>
            <Row gutter={12}>
              <Col flex='1'>
                <Form.Item
                  label={t('category')}
                  name='category'
                  rules={[{ required: true, message: t('required') }]}
                >
                  <AsyncTreeSelect
                    refetch
                    fetchOptions={fetchUserCategoryList}
                    allowClear
                    placeholder={t('select.category')}
                  />
                </Form.Item>
              </Col>
              <Col>
                <Form.Item
                  label={t('required')}
                  name='required'
                  valuePropName='checked'
                >
                  <Switch />
                </Form.Item>
              </Col>
            </Row>
          </div>
          <Form.List name='attributes'>
            {(fields, { add, remove }) => (
              <>
                <div
                  style={{
                    display: 'flex',
                    flexWrap: 'wrap',
                    justifyContent: 'center',
                    columnGap: '16px',
                  }}
                >
                  {fields.map((field, idx) => (
                    <div
                      style={{ width: '700px', maxWidth: '100%' }}
                      key={field.key}
                    >
                      <AttributeFormItemCard
                        form={form}
                        isNotLastAttribute={fields.length > 1}
                        idx={idx}
                        field={field}
                        remove={remove}
                      />
                    </div>
                  ))}
                </div>
                {isCreateMany && (
                  <Button
                    type='dashed'
                    style={{
                      width: '100%',
                      maxWidth: '500px',
                    }}
                    className='d-block mx-auto'
                    block
                    onClick={() => {
                      add();
                      const formValues = form.getFieldsValue();
                      formValues.attributes[fields.length] =
                        initialValues.attributes[0];
                      form.setFieldsValue(formValues);
                    }}
                  >
                    + {t('add.attribute')}
                  </Button>
                )}
              </>
            )}
          </Form.List>
        </Space>

        <Button
          style={{
            width: '100%',
            maxWidth: '700px',
          }}
          className='d-block mx-auto mt-3'
          htmlType='submit'
          type='primary'
          loading={loadingBtn}
        >
          {t('submit')}
        </Button>
      </Form>
    </>
  );
};

export default AttributeForm;
