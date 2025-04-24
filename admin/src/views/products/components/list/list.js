import { Space, Switch, Table, Tag } from 'antd';
import { useTranslation } from 'react-i18next';
import RiveResult from 'components/rive-result';
import React, { useEffect, useState } from 'react';
import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import { useNavigate } from 'react-router-dom';
import {
  deleteProducts,
  fetchProducts,
  setParams,
  setSelectedIds,
} from 'redux/slices/product';
import { addMenu, disableRefetch, setRefetch } from 'redux/slices/menu';
import useDidUpdate from 'helpers/useDidUpdate';
import ColumnImage from 'components/column/image';
import {
  COLORS,
  PRODUCT_STATE_OPTIONS,
  PRODUCT_STATUSES,
} from 'constants/index';
import { EditOutlined } from '@ant-design/icons';
import ColumnOptions from 'components/column/options';
import productService from 'services/product';
import { toast } from 'react-toastify';
import ConfirmModal from 'components/confirm-modal';
import StatusChangeModal from 'components/status-change-modal';

const List = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const { products, params, loading, meta, selectedIds } = useSelector(
    (state) => state.product,
    shallowEqual,
  );
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);

  const [isConfirmationModalVisible, setIsConfirmationModalVisible] =
    useState(false);
  const [confirmType, setConfirmType] = useState(null); // active, delete
  const [confirmText, setConfirmText] = useState(null); // active, delete
  const [selectedStatus, setSelectedStatus] = useState(null);

  const columns = [
    {
      title: t('id'),
      dataIndex: 'id',
      key: 'id',
    },
    {
      title: t('image'),
      dataIndex: 'img',
      key: 'img',
      render: (img, row) => <ColumnImage image={img} row={row} />,
    },
    {
      title: t('name'),
      dataIndex: 'translation',
      key: 'translation',
      render: (translation) => (
        <p
          style={{
            width: '200px',
            whiteSpace: 'nowrap',
            overflow: 'hidden',
            textOverflow: 'ellipsis',
          }}
        >
          {translation?.title || t('N/A')}
        </p>
      ),
    },
    {
      title: t('translations'),
      dataIndex: 'locales',
      key: 'locales',
      render: (locales) => (
        <Space wrap>
          {locales?.map((item, index) => (
            <Tag
              key={item}
              color={[COLORS[index % COLORS.length]]}
              className='text-uppercase'
            >
              {item}
            </Tag>
          ))}
        </Space>
      ),
    },
    {
      title: t('category'),
      dataIndex: 'category',
      key: 'category',
      render: (category) => category?.translation?.title || t('N/A'),
    },
    {
      title: t('type'),
      dataIndex: 'type',
      key: 'type',
      render: (type) => t(type || 'N/A'),
    },
    {
      title: t('state'),
      dataIndex: 'state',
      key: 'state',
      render: (state) =>
        t(
          PRODUCT_STATE_OPTIONS.find((item) => item.value === state)?.label ||
            'N/A',
        ),
    },
    {
      title: t('active'),
      dataIndex: 'active',
      key: 'active',
      render: (active, row) => (
        <Switch
          onChange={() => {
            setConfirmType('active');
            setConfirmText(t('are.you.sure.active.text'));
            setIsConfirmationModalVisible(true);
            dispatch(setSelectedIds([row?.slug]));
          }}
          checked={active}
        />
      ),
    },
    {
      title: t('status'),
      is_show: true,
      dataIndex: 'status',
      key: 'status',
      render: (status, row) => (
        <Space>
          <Tag color={getStatusColor(status)}>{t(status)}</Tag>
          <EditOutlined
            onClick={() => {
              setSelectedStatus({
                status,
                id: row?.slug,
              });
            }}
          />
        </Space>
      ),
    },
    {
      title: t('options'),
      dataIndex: 'slug',
      render: (slug, row) => {
        return (
          <ColumnOptions
            isShow={false}
            goToEdit={() => navigateToEdit(slug)}
            goToClone={() => navigateToClone(slug)}
            handleDelete={() => {
              setConfirmType('delete');
              setConfirmText(t('are.you.sure.delete.text'));
              setIsConfirmationModalVisible(true);
              dispatch(setSelectedIds([row?.id]));
            }}
          />
        );
      },
    },
  ];

  const getStatusColor = (status) => {
    switch (status) {
      case 'pending':
        return 'blue';
      case 'unpublished':
        return 'error';
      default:
        return 'cyan';
    }
  };

  const handleTableChange = (pagination) => {
    dispatch(setParams({ page: pagination.current }));
  };

  const handleSwitchActive = (id) =>
    productService.setActive(id).then(() => {
      toast.success(t('successfully.updated'));
      dispatch(setRefetch(activeMenu));
    });

  const handleChangeStatus = (body) => {
    return productService.updateStatus(selectedStatus?.id, body).then(() => {
      dispatch(setRefetch(activeMenu));
      setSelectedStatus(null);
      toast.success(t('successfully.updated'));
    });
  };

  const handleDelete = (ids) => {
    return deleteProducts(ids).then(() => {
      toast.success(t('successfully.deleted'));
      dispatch(setRefetch(activeMenu));
    });
  };

  const handleCancelConfirm = () => {
    setIsConfirmationModalVisible(false);
    setConfirmType(null);
    setConfirmText(null);
    dispatch(setSelectedIds([]));
  };

  const onClickConfirm = () => {
    switch (confirmType) {
      case 'active':
        return handleSwitchActive(selectedIds[0]).finally(() =>
          handleCancelConfirm(),
        );

      case 'delete':
        return handleDelete(selectedIds).finally(() => handleCancelConfirm());
      default:
        break;
    }
  };

  const navigateToEdit = (slug) => {
    const url = `product/${slug}`;
    dispatch(addMenu({ id: url, url, name: t('edit.product') }));
    navigate(`/${url}`);
  };

  const navigateToClone = (slug) => {
    const url = `product-clone/${slug}`;
    dispatch(addMenu({ id: url, url, name: t('clone.product') }));
    navigate(`/${url}`);
  };

  const fetch = () => {
    batch(() => {
      dispatch(fetchProducts(params));
      dispatch(disableRefetch(activeMenu));
    });
  };

  useEffect(() => {
    fetch();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [params?.page, params?.search, params?.category_id, params?.status]);

  useDidUpdate(() => {
    if (activeMenu.refetch) {
      fetch();
    }
  }, [activeMenu.refetch]);

  return (
    <>
      <Table
        locale={{
          emptyText: <RiveResult />,
        }}
        scroll={{ x: true }}
        loading={loading}
        dataSource={products}
        pagination={{
          current: params?.page,
          total: meta?.total,
          showSizeChanger: false,
        }}
        rowKey={(record) => record?.id}
        columns={columns}
        onChange={handleTableChange}
        rowSelection={{
          selectedRowKeys: selectedIds,
          onChange: (selectedRowKeys) =>
            dispatch(setSelectedIds(selectedRowKeys)),
        }}
      />
      {isConfirmationModalVisible && (
        <ConfirmModal
          onCancel={handleCancelConfirm}
          visible={isConfirmationModalVisible}
          onClick={onClickConfirm}
          text={t(confirmText)}
        />
      )}
      {!!selectedStatus && (
        <StatusChangeModal
          statuses={PRODUCT_STATUSES}
          currentStatus={selectedStatus?.status}
          visible={!!selectedStatus}
          onCancel={() => setSelectedStatus(null)}
          onConfirm={handleChangeStatus}
        />
      )}
    </>
  );
};

export default List;
