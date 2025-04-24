import { Card, Col, Row, Form, Button, Select, Switch } from 'antd';
import { useTranslation } from 'react-i18next';
import React, { useMemo } from 'react';
import categoryService from 'services/category';
import { AsyncTreeSelect } from 'components/async-tree-select-category';
import { PlusOutlined } from '@ant-design/icons';
import { addMenu } from 'redux/slices/menu';
import { useNavigate } from 'react-router-dom';
import { useDispatch } from 'react-redux';
import { PRODUCT_STATE_OPTIONS } from 'constants/index';

const Organization = ({ loading = false }) => {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const dispatch = useDispatch();
  // fetch options
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

  // go to add
  const goToAddCategory = () => {
    dispatch(
      addMenu({
        id: 'category-add',
        url: 'category/add',
        name: t('add.category'),
      }),
    );
    navigate('/category/add');
  };

  return (
    <Card title={t('organization')} loading={loading}>
      <Row gutter={12}>
        <Col span={24}>
          <Form.Item
            label={t('category')}
            name='category'
            rules={[{ required: true, message: t('required') }]}
          >
            <AsyncTreeSelect
              refetch
              fetchOptions={fetchUserCategoryList}
              dropdownRender={(menu) => (
                <>
                  {menu}
                  <div className='p-1'>
                    <Button
                      icon={<PlusOutlined />}
                      className='w-100'
                      onClick={goToAddCategory}
                    >
                      {t('add.category')}
                    </Button>
                  </div>
                </>
              )}
              allowClear
            />
          </Form.Item>
        </Col>
        <Col span={24}>
          <Form.Item
            label={t('type')}
            name='type'
            rules={[{ required: true, message: t('required') }]}
          >
            <Select>
              <Select.Option value='business'>{t('business')}</Select.Option>
              <Select.Option value='private'>{t('private')}</Select.Option>
            </Select>
          </Form.Item>
        </Col>
        <Col span={24}>
          <Form.Item
            label={t('state')}
            name='state'
            rules={[{ required: true, message: t('required') }]}
          >
            <Select
              options={PRODUCT_STATE_OPTIONS.map((item) => ({
                ...item,
                label: t(item.label),
              }))}
            />
          </Form.Item>
        </Col>
        <Col span={6}>
          <Form.Item label={t('active')} name='active' valuePropName='checked'>
            <Switch />
          </Form.Item>
        </Col>
      </Row>
    </Card>
  );
};
export default Organization;
