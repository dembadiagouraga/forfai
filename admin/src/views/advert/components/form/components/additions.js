import {
  Card,
  Col,
  Row,
  Form,
  Button,
  Select,
  Input,
  InputNumber,
  Switch,
} from 'antd';
import { useTranslation } from 'react-i18next';
import { useMemo } from 'react';
import categoryService from 'services/category';
import { AsyncTreeSelect } from 'components/async-tree-select-category';
import { PlusOutlined } from '@ant-design/icons';
import { addMenu } from 'redux/slices/menu';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import { useNavigate } from 'react-router-dom';
import { ADS_TIME_TYPES } from 'constants/ads-time-types';

const Additions = ({ loading }) => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { defaultCurrency } = useSelector(
    (state) => state.currency,
    shallowEqual,
  );
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
    <Card title={t('additions')} loading={loading}>
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
        <Col span={18}>
          <Form.Item
            label={t('time')}
            name='time'
            rules={[
              {
                required: true,
                message: t('required'),
              },
            ]}
          >
            <Input />
          </Form.Item>
        </Col>
        <Col span={6}>
          <Form.Item
            label={t('time.type')}
            name='time_type'
            rules={[
              {
                required: true,
                message: t('required'),
              },
            ]}
          >
            <Select
              options={ADS_TIME_TYPES.map((item) => ({
                ...item,
                label: t(item.label),
              }))}
            />
          </Form.Item>
        </Col>
        <Col span={24}>
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
            <InputNumber
              className='w-100'
              min={0}
              addonAfter={
                defaultCurrency?.position === 'after' && defaultCurrency?.symbol
              }
              addonBefore={
                defaultCurrency?.position === 'before' &&
                defaultCurrency?.symbol
              }
            />
          </Form.Item>
        </Col>
        <Col flex='1'>
          <Form.Item
            label={t('count')}
            name='count'
            rules={[
              {
                required: true,
                message: t('required'),
              },
            ]}
          >
            <InputNumber className='w-100' min={0} />
          </Form.Item>
        </Col>
        <Col >
          <Form.Item label={t('active')} name='active' valuePropName='checked'>
            <Switch />
          </Form.Item>
        </Col>
      </Row>
    </Card>
  );
};

export default Additions;
