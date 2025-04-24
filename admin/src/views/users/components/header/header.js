import { Button, Space } from 'antd';
import SearchInput from 'components/search-input';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import { deleteUsers, resetSelectedIds, setParams } from 'redux/slices/user';
import { useTranslation } from 'react-i18next';
import DeleteButton from 'components/delete-button';
import { useState } from 'react';
import ConfirmModal from 'components/confirm-modal';
import { toast } from 'react-toastify';
import { addMenu, setRefetch } from 'redux/slices/menu';
import { useNavigate } from 'react-router-dom';

const Header = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const { params, selectedIds } = useSelector(
    (state) => state.user,
    shallowEqual,
  );
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);

  const [isConfirmationModalVisible, setIsConfirmationModalVisible] =
    useState(false);

  const handleFilter = (key, value) => {
    switch (key) {
      case 'search':
        dispatch(
          setParams({ [key]: value?.length ? value : undefined, page: 1 }),
        );
        break;

      default:
        break;
    }
  };

  const handleDelete = () => {
    deleteUsers(selectedIds).then(() => {
      dispatch(resetSelectedIds());
      dispatch(dispatch(setRefetch(activeMenu)));
      setIsConfirmationModalVisible(false);
      toast.success(t('successfully.deleted'));
    });
  };

  const handleCancel = () => {
    setIsConfirmationModalVisible(false);
  };

  const handleDeleteButton = () => {
    if (!selectedIds.length) {
      toast.warning(t('select.at.least.one.user'));
      return;
    }
    setIsConfirmationModalVisible(true);
  };

  const navigateToAddUser = () => {
    const url = `user/add/${params?.role}`;
    dispatch(
      addMenu({
        id: url,
        url,
        name: t(`add.${params?.role}`),
      }),
    );
    navigate(`/${url}`);
  };

  return (
    <>
      <Space wrap>
        <SearchInput
          defaultValue={params?.search}
          placeholder={t('search')}
          handleChange={(value) => handleFilter('search', value)}
        />
        {params?.role !== 'admin' && (
          <>
            <Button type='primary' onClick={navigateToAddUser}>
              {t(`add.${params?.role}`)}
            </Button>
            <DeleteButton onClick={handleDeleteButton}>
              {t('delete.selected')}
            </DeleteButton>
          </>
        )}
      </Space>
      {isConfirmationModalVisible && (
        <ConfirmModal
          text={t('are.you.sure.delete.text')}
          onClick={handleDelete}
          onCancel={handleCancel}
          visible={isConfirmationModalVisible}
        />
      )}
    </>
  );
};

export default Header;
