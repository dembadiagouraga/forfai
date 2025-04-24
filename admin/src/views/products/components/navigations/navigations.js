import { Button, Space } from 'antd';
import { useTranslation } from 'react-i18next';
import { CgExport, CgImport } from 'react-icons/cg';
import { PlusCircleOutlined } from '@ant-design/icons';
import React, { useState } from 'react';
import productService from 'services/product';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import { export_url } from 'configs/app-global';
import { addMenu, setRefetch } from 'redux/slices/menu';
import { useNavigate } from 'react-router-dom';
import DeleteButton from 'components/delete-button';
import ConfirmModal from 'components/confirm-modal';
import { deleteProducts, setSelectedIds } from 'redux/slices/product';
import { toast } from 'react-toastify';

const Navigations = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const { params, selectedIds } = useSelector(
    (state) => state.product,
    shallowEqual,
  );
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);

  const [loading, setLoading] = useState({ export: false });
  const [isConfirmationModalVisible, setIsConfirmationModalVisible] =
    useState(false);

  const fetchDownloadExport = () => {
    setLoading((prev) => ({ ...prev, export: true }));
    productService
      .export(params)
      .then((res) => {
        if (res?.data?.file_name) {
          window.location.href = `${export_url}${res?.data?.file_name}`;
        }
      })
      .finally(() => setLoading((prev) => ({ ...prev, export: false })));
  };

  const handleImport = () => {
    const url = 'product/import';
    dispatch(
      addMenu({
        id: 'product-import',
        url,
        name: t('product.import'),
      }),
    );
    navigate(`/${url}`);
  };

  const handleAddProduct = () => {
    const url = 'product/add';
    dispatch(
      addMenu({
        id: 'product-add',
        url,
        name: t('add.product'),
      }),
    );
    navigate(`/${url}`);
  };

  const handleCancelConfirm = () => {
    setIsConfirmationModalVisible(false);
    dispatch(setSelectedIds([]));
  };

  const handleClickConfirm = () => {
    return deleteProducts(selectedIds).then(() => {
      setIsConfirmationModalVisible(false);
      dispatch(setSelectedIds([]));
      dispatch(setRefetch(activeMenu));
      toast.success(t('deleted.successfully'));
    });
  };

  return (
    <>
      <Space wrap>
        <Button icon={<CgImport className='mr-2' />} onClick={handleImport}>
          {t('import')}
        </Button>
        <Button
          icon={<CgExport className='mr-2' />}
          onClick={fetchDownloadExport}
          loading={loading.export}
        >
          {t('export')}
        </Button>
        <Button
          icon={<PlusCircleOutlined />}
          type='primary'
          onClick={handleAddProduct}
        >
          {t('add.product')}
        </Button>
        <DeleteButton
          onClick={() => {
            if (!selectedIds.length) {
              toast.warning(t('select.at.least.one.product'));
              return;
            }
            setIsConfirmationModalVisible(true);
          }}
        >
          {t('delete.selected')}
        </DeleteButton>
      </Space>
      {isConfirmationModalVisible && (
        <ConfirmModal
          onCancel={handleCancelConfirm}
          visible={isConfirmationModalVisible}
          onClick={handleClickConfirm}
          text={t('delete.selected.confirm')}
        />
      )}
    </>
  );
};

export default Navigations;
