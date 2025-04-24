import { useTranslation } from 'react-i18next';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import { useNavigate } from 'react-router-dom';
import { useContext, useEffect, useState } from 'react';
import { Context } from 'context/context';
import { addMenu, disableRefetch } from 'redux/slices/menu';
import { fetchStoreis } from 'redux/slices/storeis';
import { Button, Card, Space, Table } from 'antd';
import RiveResult from 'components/rive-result';
import { DeleteOutlined, EditOutlined } from '@ant-design/icons';
import DeleteButton from 'components/delete-button';
import { toast } from 'react-toastify';
import formatSortType from 'helpers/formatSortType';
import ColumnImage from 'components/column/image';

const StoriesList = ({ ids = null, setIds }) => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { setIsModalVisible } = useContext(Context);
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const { storeis, loading, meta } = useSelector(
    (state) => state.storeis,
    shallowEqual,
  );

  const goToEdit = (id) => {
    dispatch(
      addMenu({
        id: 'edit-story',
        url: `stories/edit/${id}`,
        name: t('edit.stories'),
      }),
    );
    navigate(`/stories/edit/${id}`);
  };

  const handleDeleteCondition = (id) => {
    if (!id) {
      toast.warning(t('no.id'));
    } else {
      setIds([id]);
      setIsModalVisible(true);
    }
  };

  const onChangePagination = (pagination, filters, sorter) => {
    const { pageSize: perPage, current: page } = pagination;
    const { field: column, order } = sorter;
    const sort = formatSortType(order);
    const params = {
      page,
      perPage,
      column,
      sort,
    };
    dispatch(fetchStoreis(params));
  };

  const [columns] = useState([
    {
      title: t('id'),
      dataIndex: 'id',
      key: 'id',
      is_show: true,
    },
    {
      title: t('image'),
      dataIndex: 'file_urls',
      key: 'file_urls',
      is_show: true,
      render: (file_urls, row) => (
        <ColumnImage image={file_urls?.[0]} row={row} />
      ),
    },
    {
      title: t('title'),
      dataIndex: 'translation',
      key: 'title',
      is_show: true,
      render: (translation) => translation.title,
    },
    {
      title: t('options'),
      key: 'options',
      dataIndex: 'id',
      is_show: true,
      render: (storyId) => (
        <Space>
          <Button
            type='primary'
            icon={<EditOutlined />}
            onClick={() => goToEdit(storyId)}
          />
          <DeleteButton
            icon={<DeleteOutlined />}
            onClick={() => handleDeleteCondition(storyId)}
          />
        </Space>
      ),
    },
  ]);

  useEffect(() => {
    if (activeMenu.refetch) {
      dispatch(fetchStoreis({}));
      dispatch(disableRefetch(activeMenu));
    }
    // eslint-disable-next-line
  }, [activeMenu.refetch]);

  return (
    <Card>
      <Table
        locale={{
          emptyText: <RiveResult />,
        }}
        scroll={{ x: true }}
        columns={columns.filter((column) => column.is_show)}
        loading={loading}
        dataSource={storeis}
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

export default StoriesList;
