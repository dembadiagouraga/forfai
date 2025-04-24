import { useTranslation } from 'react-i18next';
import { Button, Space, Table } from 'antd';
import hideEmail from 'components/hideEmail';
import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import {
  CopyOutlined,
  DeleteOutlined,
  EditOutlined,
  EyeOutlined,
} from '@ant-design/icons';
import DeleteButton from 'components/delete-button';
import { useNavigate } from 'react-router-dom';
import { addMenu, setRefetch } from 'redux/slices/menu';
import {
  deleteUsers,
  resetSelectedIds,
  setParams,
  setSelectedIds,
} from 'redux/slices/user';
import { useState } from 'react';
import ConfirmModal from 'components/confirm-modal';
import { toast } from 'react-toastify';

const ReactAppIsDemo = process.env.REACT_APP_IS_DEMO === 'true';

const List = () => {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const dispatch = useDispatch();

  const { users, loading, selectedIds, meta } = useSelector(
    (state) => state.user,
    shallowEqual,
  );
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);

  const [isConfirmationModalVisible, setIsConfirmationModalVisible] =
    useState(false);

  const columns = [
    {
      title: t('id'),
      dataIndex: 'id',
      key: 'id',
    },
    {
      title: t('firstname'),
      dataIndex: 'firstname',
      key: 'firstname',
      render: (firstname) => firstname || t('N/A'),
    },
    {
      title: t('lastname'),
      dataIndex: 'lastname',
      key: 'lastname',
      render: (lastname) => lastname || t('N/A'),
    },
    {
      title: t('email'),
      dataIndex: 'email',
      key: 'email',
      render: (email) => (ReactAppIsDemo ? hideEmail(email) : email),
    },
    {
      title: t('options'),
      dataIndex: 'uuid',
      key: 'uuid',
      render: (uuid, row) => (
        <Space>
          <Button
            icon={<EyeOutlined />}
            onClick={() => navigateToDetails(uuid)}
          />
          <Button
            icon={<EditOutlined />}
            onClick={() => navigateToEdit(uuid)}
          />
          {row?.role !== 'admin' && (
            <>
              <Button
                icon={<CopyOutlined />}
                onClick={() => navigateToClone(uuid)}
              />
              <DeleteButton
                icon={<DeleteOutlined />}
                onClick={() => {
                  setIsConfirmationModalVisible(true);
                  dispatch(setSelectedIds([row?.id]));
                }}
              />
            </>
          )}
        </Space>
      ),
    },
  ];

  const navigateToDetails = (uuid) => {
    const url = `users/user/${uuid}`;
    dispatch(addMenu({ id: url, url, name: t('user.details') }));
    navigate(`/${url}`);
  };

  const navigateToEdit = (uuid) => {
    const url = `user/${uuid}`;
    dispatch(addMenu({ id: url, url, name: t('user.edit') }));
    navigate(`/${url}`);
  };

  const navigateToClone = (uuid) => {
    const url = `user-clone/${uuid}`;
    dispatch(
      addMenu({
        id: url,
        url,
        name: t('user.clone'),
      }),
    );
    navigate(`/${url}`);
  };

  const handleDeleteSelectedUsers = () => {
    return deleteUsers(selectedIds).then(() => {
      batch(() => {
        dispatch(resetSelectedIds());
        dispatch(setRefetch(activeMenu));
      });
      setIsConfirmationModalVisible(false);
      toast.success(t('successfully.deleted'));
    });
  };

  const handleCancelConfirm = () => {
    dispatch(resetSelectedIds());
    setIsConfirmationModalVisible(false);
  };

  const handleChangeTable = (pagination) => {
    dispatch(setParams({ page: pagination?.current || 1 }));
  };

  return (
    <>
      <Table
        loading={loading}
        columns={columns}
        dataSource={users}
        rowKey={(row) => row?.id}
        pagination={{
          pageSize: meta?.per_page,
          current: meta?.current_page,
          total: meta?.total,
        }}
        rowSelection={{
          selectedRowKeys: selectedIds,
          onChange: (selectedRowKeys) =>
            dispatch(setSelectedIds(selectedRowKeys)),
        }}
        onChange={handleChangeTable}
      />
      {isConfirmationModalVisible && (
        <ConfirmModal
          visible={isConfirmationModalVisible}
          onClick={handleDeleteSelectedUsers}
          onCancel={handleCancelConfirm}
          text={t('are.you.sure.delete.text')}
        />
      )}
    </>
  );
};

export default List;
