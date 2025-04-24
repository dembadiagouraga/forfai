import React, { useContext, useEffect, useState, useCallback } from 'react';
import {
  ClearOutlined,
  EditOutlined,
  PlusCircleOutlined,
} from '@ant-design/icons';
import { Button, Card, Modal, Space, Switch, Table, Tabs, Tag } from 'antd';
import { useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';
import { export_url } from 'configs/app-global';
import { Context } from 'context/context';
import CustomModal from 'components/modal';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import { addMenu, disableRefetch, setMenuData } from 'redux/slices/menu';
import productService from 'services/product';
import { fetchVacancies } from 'redux/slices/vacancy';
import useDidUpdate from 'helpers/useDidUpdate';
import brandService from 'services/brand';
import categoryService from 'services/category';
import SearchInput from 'components/search-input';
import formatSortType from 'helpers/formatSortType';
import { useTranslation } from 'react-i18next';
import DeleteButton from 'components/delete-button';
import ProductStatusModal from './productStatusModal';
import FilterColumns from 'components/filter-column';
import RiveResult from 'components/rive-result';
import { CgExport, CgImport } from 'react-icons/cg';
import { InfiniteSelect } from 'components/infinite-select';
import ColumnImage from 'components/column/image';
import ColumnOptions from 'components/column/options';

const colors = ['blue', 'red', 'gold', 'volcano', 'cyan', 'lime'];
const roles = ['all', 'pending', 'published', 'unpublished'];
const { TabPane } = Tabs;

const ProductCategories = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const [productDetails, setProductDetails] = useState(null);
  const [active, setActive] = useState(null);
  const [text, setText] = useState(null);
  const [role, setRole] = useState('all');
  const [links, setLinks] = useState(null);
  const [isVisibleMsgModal, setIsVisibleMsgModal] = useState(false);

  const clearData = () => {
    dispatch(
      setMenuData({
        activeMenu,
        data: null,
      }),
    );
  };

  const goToImport = useCallback(() => {
    dispatch(
      addMenu({
        id: 'vacancy-import',
        url: `vacancy/import`,
        name: t('vacancy.import'),
      }),
    );
    navigate(`/product/import`);
  }, [dispatch, navigate, t]);

  const goToAddProduct = useCallback(() => {
    dispatch(
      addMenu({
        id: 'vacancy-add',
        url: `vacancy/add`,
        name: t('add.vacancy'),
      }),
    );
    clearData();
    navigate(`/vacancies/add`);
    // eslint-disable-next-line
  }, [dispatch, navigate, t]);

  const goToEdit = useCallback(
    (uuid) => {
      dispatch(
        addMenu({
          id: `vacancy-edit`,
          url: `vacancy/${uuid}`,
          name: t('edit.vacancy'),
        }),
      );
      clearData();
      navigate(`/vacancy/${uuid}`);
    },
    // eslint-disable-next-line
    [dispatch, navigate, t],
  );

  const goToClone = useCallback(
    (uuid) => {
      dispatch(
        addMenu({
          id: `product-clone`,
          url: `product-clone/${uuid}`,
          name: t('clone.product'),
        }),
      );
      clearData();
      navigate(`/vacancy-clone/${uuid}`);
    },
    // eslint-disable-next-line
    [dispatch, navigate, t],
  );

  const [id, setId] = useState(null);
  const { setIsModalVisible } = useContext(Context);
  const [loadingBtn, setLoadingBtn] = useState(false);
  const [downloading, setDownloading] = useState(false);
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const { vacancies, meta, loading, params } = useSelector(
    (state) => state.vacancy,
    shallowEqual,
  );
  const immutable = activeMenu.data?.role || role;
  const data = activeMenu.data;
  const paramsData = {
    search: data?.search,
    brand_id: data?.selectedBrand?.value,
    category_id: data?.selectedCategory?.value,
    sort: data?.sort,
    status: immutable === 'all' ? undefined : immutable,
    column: data?.column,
    perPage: data?.perPage,
    page: data?.page,
  };

  const productDelete = () => {
    setLoadingBtn(true);
    const params = {
      ...Object.assign(
        {},
        ...id.map((item, index) => ({
          [`ids[${index}]`]: item,
        })),
      ),
    };
    productService
      .delete(params)
      .then(() => {
        setIsModalVisible(false);
        toast.success(t('successfully.deleted'));
        dispatch(fetchVacancies(paramsData));
        setText(null);
        setActive(false);
      })
      .finally(() => setLoadingBtn(false));
  };

  const handleActive = () => {
    setLoadingBtn(true);
    productService
      .setActive(id)
      .then(() => {
        setIsModalVisible(false);
        dispatch(fetchVacancies(paramsData));
        toast.success(t('successfully.updated'));
        setActive(false);
      })
      .finally(() => setLoadingBtn(false));
  };

  function onChangePagination(pagination, filter, sorter) {
    const { pageSize: perPage, current: page } = pagination;
    const { field: column, order } = sorter;
    const sort = formatSortType(order);
    dispatch(
      setMenuData({
        activeMenu,
        data: { ...activeMenu.data, perPage, page, column, sort },
      }),
    );
  }

  useDidUpdate(() => {
    dispatch(fetchVacancies(paramsData));
  }, [activeMenu.data]);

  useEffect(() => {
    if (activeMenu.refetch) {
      dispatch(fetchVacancies(paramsData));
      dispatch(disableRefetch(activeMenu));
    }
    // eslint-disable-next-line
  }, [activeMenu.refetch]);

  const excelExport = () => {
    setDownloading(true);
    productService
      .export(paramsData)
      .then((res) => {
        window.location.href = export_url + res.data?.file_name;
      })
      .finally(() => setDownloading(false));
  };

  async function fetchBrands({ search, page }) {
    const params = {
      search: search?.length === 0 ? undefined : search,
      page: page,
    };
    return brandService.search(params).then((res) => {
      setLinks(res.links);
      return res.data.map((item) => ({
        label: item.title,
        value: item.id,
      }));
    });
  }

  async function fetchCategories({ search, page }) {
    const params = {
      search: search?.length === 0 ? undefined : search,
      type: 'main',
      page: page,
    };
    return categoryService.search(params).then((res) => {
      setLinks(res.links);
      return res.data.map((item) => ({
        label: item?.translation?.title,
        value: item.id,
      }));
    });
  }

  const handleFilter = (items) => {
    const data = activeMenu.data;
    dispatch(
      setMenuData({
        activeMenu,
        data: { ...data, ...items },
      }),
    );
  };

  const rowSelection = {
    selectedRowKeys: id,
    onChange: (key) => {
      setId(key);
    },
  };

  const allDelete = () => {
    if (id === null || id.length === 0) {
      toast.warning(t('select.the.product'));
    } else {
      setIsModalVisible(true);
      setText(false);
    }
  };

  const handleClear = () => {
    dispatch(
      setMenuData({
        activeMenu,
        data: undefined,
      }),
    );
  };

  const [columns, setColumns] = useState([
    {
      title: t('id'),
      dataIndex: 'id',
      is_show: true,
      sorter: (a, b) => a.id - b.id,
    },
    {
      title: t('image'),
      dataIndex: 'img',
      is_show: true,
      render: (img, row) => <ColumnImage image={img} row={row} />,
    },
    {
      title: t('name'),
      dataIndex: 'name',
      is_show: true,
      render: (_, row) => (
        <span
          style={{
            display: 'block',
            width: '200px',
            whiteSpace: 'nowrap',
            overflow: 'hidden',
            textOverflow: 'ellipsis',
          }}
        >
          {row?.translation?.title || t('N/A')}
        </span>
      ),
    },
    {
      title: t('translations'),
      dataIndex: 'locales',
      is_show: true,
      render: (_, row) => {
        return (
          <Space>
            {!!row?.locales?.length
              ? row?.locales?.map((item, index) => (
                  <Tag
                    className='text-uppercase'
                    color={[colors[index]]}
                    key={item}
                  >
                    {item}
                  </Tag>
                ))
              : t('N/A')}
          </Space>
        );
      },
    },
    {
      title: t('category'),
      dataIndex: 'category_name',
      is_show: true,
      render: (categoryName) => categoryName || t('N/A'),
    },
    {
      title: t('type'),
      dataIndex: 'type',
      is_show: true,
    },
    {
      title: t('active'),
      dataIndex: 'active',
      is_show: true,
      render: (active, row) => {
        return (
          <Switch
            onChange={() => {
              setIsModalVisible(true);
              setId(row.uuid);
              setActive(true);
            }}
            checked={active}
          />
        );
      },
    },
    {
      title: t('status'),
      is_show: true,
      dataIndex: 'status',
      key: 'status',
      render: (status, row) => (
        <Space>
          {status === 'pending' ? (
            <Tag color='blue'>{t(status)}</Tag>
          ) : status === 'unpublished' ? (
            <Tag color='error'>{t(status)}</Tag>
          ) : (
            <Tag color='cyan'>{t(status)}</Tag>
          )}
          <EditOutlined onClick={() => setProductDetails(row)} />
        </Space>
      ),
    },
    {
      title: t('options'),
      dataIndex: 'options',
      is_show: true,
      render: (_, row) => {
        return (
          <ColumnOptions
            isDelete={true}
            isEdit={true}
            isClone={true}
            goToEdit={() => goToEdit(row?.slug)}
            goToClone={() => goToClone(row?.slug)}
            handleDelete={() => {
              setIsModalVisible(true);
              setId([row.id]);
              setText(true);
              setActive(false);
            }}
          />
        );
      },
    },
  ]);

  return (
    <React.Fragment>
      <Card className='p-0'>
        <Space wrap size={[14, 20]}>
          <Button onClick={goToImport}>
            <CgImport className='mr-2' />
            {t('import')}
          </Button>
          <Button loading={downloading} onClick={excelExport}>
            <CgExport className='mr-2' />
            {t('export')}
          </Button>
          <FilterColumns columns={columns} setColumns={setColumns} />
          <DeleteButton size='' onClick={allDelete}>
            {t('delete.selected')}
          </DeleteButton>
          <Button
            icon={<ClearOutlined />}
            onClick={handleClear}
            disabled={!activeMenu.data}
          />
          <Button
            icon={<PlusCircleOutlined />}
            type='primary'
            onClick={goToAddProduct}
          >
            {t('add.vacancy')}
          </Button>
        </Space>
      </Card>
      <Card className='p-0'>
        <Space wrap size={[14, 20]}>
          <SearchInput
            placeholder={t('search')}
            handleChange={(e) => handleFilter({ search: e })}
            defaultValue={activeMenu.data?.search}
            resetSearch={!activeMenu.data?.search}
            style={{ minWidth: 180 }}
          />
          <InfiniteSelect
            placeholder={t('select.category')}
            fetchOptions={fetchCategories}
            hasMore={links?.next}
            loading={loading}
            style={{ minWidth: 180 }}
            onChange={(e) => handleFilter({ selectedCategory: e })}
            value={activeMenu.data?.selectedCategory}
          />
          <InfiniteSelect
            placeholder={t('select.brand')}
            fetchOptions={fetchBrands}
            hasMore={links?.next}
            loading={loading}
            style={{ minWidth: 180 }}
            onChange={(e) => handleFilter({ selectedBrand: e })}
            value={activeMenu.data?.selectedBrand}
          />
        </Space>
      </Card>
      <Card>
        <Tabs
          className='mt-3'
          activeKey={immutable}
          onChange={(key) => {
            handleFilter({ role: key, page: 1 });
            setRole(key);
          }}
          type='card'
        >
          {roles.map((item) => (
            <TabPane tab={t(item)} key={item} />
          ))}
        </Tabs>
        <Table
          locale={{
            emptyText: <RiveResult />,
          }}
          scroll={{ x: true }}
          rowSelection={rowSelection}
          loading={loading}
          columns={columns?.filter((item) => item.is_show)}
          dataSource={vacancies}
          pagination={{
            pageSize: params.perPage,
            page: activeMenu.data?.page || 1,
            total: meta.total,
            defaultCurrent: activeMenu.data?.page,
            current: activeMenu.data?.page,
          }}
          onChange={onChangePagination}
          rowKey={(record) => record.id}
        />
      </Card>
      {productDetails && (
        <ProductStatusModal
          orderDetails={productDetails}
          handleCancel={() => setProductDetails(null)}
          paramsData={paramsData}
        />
      )}
      <CustomModal
        click={active ? handleActive : productDelete}
        text={
          active
            ? t('set.active.product')
            : text
              ? t('delete')
              : t('all.delete')
        }
        loading={loadingBtn}
        setText={setId}
        setActive={setActive}
      />
      <Modal
        title='Reject message'
        closable={false}
        visible={isVisibleMsgModal}
        footer={null}
        centered
      >
        <div className='d-flex justify-content-end'>
          <Button
            type='primary'
            className='mr-2'
            onClick={() => setIsVisibleMsgModal(false)}
          >
            {t('close')}
          </Button>
        </div>
      </Modal>
    </React.Fragment>
  );
};

export default ProductCategories;
