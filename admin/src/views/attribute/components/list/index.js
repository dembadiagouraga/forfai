import { Button, Card, Space, Table } from 'antd';
import { useTranslation } from 'react-i18next';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import { useLocation, useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';
import { useContext, useEffect, useMemo, useState } from 'react';
import { Context } from 'context/context';
import formatSortType from 'helpers/formatSortType';
import { fetchAttributes } from 'redux/slices/attributes';
import { DeleteOutlined, EditOutlined } from '@ant-design/icons';
import DeleteButton from 'components/delete-button';
import { addMenu, disableRefetch } from 'redux/slices/menu';
import RiveResult from 'components/rive-result';
import qs from 'qs';
import useDidUpdate from 'helpers/useDidUpdate';

const AttributesList = ({ ids = null, setIds }) => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const location = useLocation();
  const { setIsModalVisible } = useContext(Context);
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const { attributes, loading, meta } = useSelector(
    (state) => state.attributes,
    shallowEqual,
  );

  const filterParams = useMemo(
    () => qs.parse(location.search, { ignoreQueryPrefix: true }),
    [location.search],
  );

  const handleDeleteAttribute = (id) => {
    if (!id) {
      toast.warning(t('no.id'));
    } else {
      setIds([id]);
      setIsModalVisible(true);
    }
  };

  const goToEdit = (id) => {
    dispatch(
      addMenu({
        id: 'edit-attribute',
        url: `attributes/edit/${id}`,
        name: t('edit.attributes'),
      }),
    );
    navigate(`/attributes/edit/${id}`);
  };

  const onChangePagination = (pagination, filters, sorter) => {
    const { pageSize: perPage, current: page } = pagination;
    const { field: column, order } = sorter;
    const sort = formatSortType(order);
    const params = {
      ...filterParams,
      page,
      perPage,
      column,
      sort,
    };
    dispatch(fetchAttributes(params));
  };

  const [columns] = useState([
    {
      title: t('id'),
      dataIndex: 'id',
      key: 'id',
    },
    {
      title: t('title'),
      dataIndex: 'translation',
      key: 'title',
      render: (translation) => translation?.title,
    },
    {
      title: t('type'),
      dataIndex: 'type',
      key: 'type',
      render: (type) => t(type),
    },
    {
      title: t('category'),
      dataIndex: 'category',
      key: 'category',
      render: (category) => category?.translation?.title,
    },
    {
      title: t('options'),
      dataIndex: 'id',
      render: (attributeId) => {
        return (
          <Space>
            <Button
              type='primary'
              icon={<EditOutlined />}
              onClick={() => goToEdit(attributeId)}
            />
            <DeleteButton
              icon={<DeleteOutlined />}
              onClick={() => handleDeleteAttribute(attributeId)}
            />
          </Space>
        );
      },
    },
  ]);

  useEffect(() => {
    if (activeMenu.refetch) {
      dispatch(fetchAttributes({}));
      dispatch(disableRefetch(activeMenu));
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [activeMenu.refetch]);

  useDidUpdate(() => {
    dispatch(fetchAttributes(filterParams));
  }, [filterParams]);

  return (
    <Card>
      <Table
        locale={{
          emptyText: <RiveResult />,
        }}
        scroll={{ x: true }}
        columns={columns}
        loading={loading}
        dataSource={attributes}
        rowSelection={{
          selectedRowKeys: ids,
          onChange: (selectedRowKeys) => setIds(selectedRowKeys),
        }}
        rowKey={(record) => record?.id}
        pagination={{
          defaultCurrent: 1,
          pageSize: meta?.per_page || 10,
          current: meta.current_page || 1,
          total: meta.total || 0,
        }}
        onChange={onChangePagination}
      />
    </Card>
  );
};

export default AttributesList;
