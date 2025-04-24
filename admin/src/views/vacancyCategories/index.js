import React, { useContext, useEffect, useState } from 'react';
import { ClearOutlined, PlusCircleOutlined } from '@ant-design/icons';
import { Button, Card, Space, Switch, Table, Tag } from 'antd';
import { export_url } from 'configs/app-global';
import { Context } from 'context/context';
import { useNavigate, useParams } from 'react-router-dom';
import { toast } from 'react-toastify';
import CustomModal from 'components/modal';
import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import { addMenu, disableRefetch, setMenuData } from 'redux/slices/menu';
import categoryService from 'services/category';
import { fetchVacancyCategories } from 'redux/slices/vacancyCategory';
import { useTranslation } from 'react-i18next';
import DeleteButton from 'components/delete-button';
import FilterColumns from 'components/filter-column';
import SearchInput from 'components/search-input';
import ColumnImage from 'components/column/image';
import { CgExport, CgImport } from 'react-icons/cg';
import formatSortType from 'helpers/formatSortType';
import ColumnOptions from 'components/column/options';

const colors = ['blue', 'red', 'gold', 'volcano', 'cyan', 'lime'];

const VacancyCategories = ({
  parentId,
  type = 'main',
  parent_type,
  handleAddAction = () => {},
  activeTab = 'list',
}) => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const { vacancyCategories, meta, loading } = useSelector(
    (state) => state.vacancyCategory,
    shallowEqual,
  );
  const { setIsModalVisible } = useContext(Context);
  const { uuid: parentUuid } = useParams();
  const [active, setActive] = useState(null);
  const [id, setId] = useState(null);
  const [loadingBtn, setLoadingBtn] = useState(false);
  const [downloading, setDownloading] = useState(false);
  const [text, setText] = useState(null);
  const [columns, setColumns] = useState([
    {
      title: t('id'),
      dataIndex: 'id',
      key: 'id',
      is_show: true,
    },
    {
      title: t('name'),
      dataIndex: 'name',
      key: 'name',
      is_show: true,
      render: (name) => name || t('N/A'),
    },
    {
      title: t('translations'),
      dataIndex: 'locales',
      is_show: true,
      render: (_, row) => {
        return !!row?.locales?.length ? (
          <Space>
            {row?.locales?.map((item, index) => (
              <Tag
                className='text-uppercase'
                color={[colors[index]]}
                key={item}
              >
                {item}
              </Tag>
            ))}
          </Space>
        ) : (
          t('N/A')
        );
      },
    },
    {
      title: t('image'),
      dataIndex: 'img',
      key: 'img',
      is_show: true,
      render: (img, row) => <ColumnImage image={img} row={row} />,
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
      title: t('options'),
      key: 'options',
      dataIndex: 'options',
      is_show: true,
      render: (_, row) => {
        return (
          <ColumnOptions
            isShow={true}
            isEdit={true}
            isClone={true}
            isDelete={true}
            goToShow={() => goToShow(row)}
            goToEdit={() => goToEdit(row)}
            goToClone={() => goToClone(row.uuid)}
            handleDelete={() => {
              setId([row.id]);
              setIsModalVisible(true);
              setText(true);
            }}
          />
        );
      },
    },
  ]);

  const data = activeMenu.data;
  const paramsData = {
    search: data?.search,
    perPage: activeMenu?.data?.perPage || 10,
    page: data?.page || 1,
    type: type,
    parent_id: parentId,
  };

  function goToEdit(row) {
    dispatch(
      addMenu({
        url: `vacancy-category/${row.uuid}`,
        id: parentId ? 'category_sub_edit' : 'vacancy-category_edit',
        name: parentId ? t('edit.sub.category') : t('edit.category'),
      }),
    );
    navigate(`/category/${row.uuid}`, { state: { parentId, parentUuid } });
  }
  function goToShow(row) {
    dispatch(
      addMenu({
        url: `vacancy-category/show/${row.uuid}`,
        id: 'category_show',
        name: t('category.show'),
      }),
    );
    navigate(`/vacancy-category/show/${row.uuid}`, {
      state: { parentId, parentUuid },
    });
  }
  const goToImport = () => {
    dispatch(
      addMenu({
        url: `catalog/categories/import`,
        id: parentId ? 'sub_category_import' : 'category_import',
        name: parentId ? t('import.sub.category') : t('import.category'),
      }),
    );
    navigate(`/catalog/categories/import`, { state: { parentId, parentUuid } });
  };
  const goToClone = (uuid) => {
    dispatch(
      addMenu({
        id: parentId ? 'sub-category-clone' : `category-clone`,
        url: `category-clone/${uuid}`,
        name: parentId ? t('sub.category.clone') : t('category.clone'),
      }),
    );
    navigate(`/category-clone/${uuid}`, { state: { parentId, parentUuid } });
  };
  const goToAddCategory = () => {
    if (parentId) {
      handleAddAction(parentId);
    } else {
      dispatch(
        addMenu({
          id: parentId ? 'sub-category-add' : 'category-add',
          url: 'vacancy-category/add',
          name: parentId ? t('add.sub.category') : t('add.category'),
        }),
      );
      navigate('/vacancy-category/add', { state: { parentId, parentUuid } });
    }
  };
  const categoryDelete = () => {
    setLoadingBtn(true);
    const params = {
      ...Object.assign(
        {},
        ...id.map((item, index) => ({
          [`ids[${index}]`]: item,
        })),
      ),
    };
    categoryService
      .delete(params)
      .then(() => {
        dispatch(fetchVacancyCategories(paramsData));
        toast.success(t('successfully.deleted'));
      })
      .finally(() => {
        setIsModalVisible(false);
        setLoadingBtn(false);
        setText(null);
        setId(null);
      });
  };
  const allDelete = () => {
    if (id === null || id.length === 0) {
      toast.warning(t('select.the.product'));
    } else {
      setIsModalVisible(true);
      setText(false);
    }
  };
  const handleFilter = (items) => {
    const data = activeMenu.data;
    dispatch(
      setMenuData({
        activeMenu,
        data: { ...data, ...items },
      }),
    );
  };
  const handleClear = () => {
    dispatch(
      setMenuData({
        activeMenu,
        data: undefined,
      }),
    );
  };
  const rowSelection = {
    selectedRowKeys: id,
    onChange: (key) => {
      setId(key);
    },
  };

  const fetch = (params = {}) => {
    console.log('fetchVacancyCategories');
    batch(() => {
      dispatch(fetchVacancyCategories(params));
      dispatch(disableRefetch(activeMenu));
    });
  };

  useEffect(() => {
    if (activeMenu.refetch && activeTab === 'list') {
      fetch(paramsData);
    }
    // eslint-disable-next-line
  }, [activeMenu.refetch]);

  useEffect(() => {
    if (activeTab === 'list') {
      fetch(paramsData);
    }
    // eslint-disable-next-line
  }, [activeMenu.data, type, parentId, activeTab]);

  const onChangePagination = (pagination, filter, sorter) => {
    const { pageSize: perPage, current: page } = pagination;
    const { field: column, order } = sorter;
    const sort = formatSortType(order);
    dispatch(
      setMenuData({
        activeMenu,
        data: { ...activeMenu.data, perPage, page, column, sort },
      }),
    );
  };

  const excelExport = () => {
    setDownloading(true);
    categoryService
      .export(paramsData)
      .then((res) => {
        window.location.href = export_url + res.data.file_name;
      })
      .finally(() => setDownloading(false));
  };

  const handleActive = () => {
    setLoadingBtn(true);
    categoryService
      .setActive(id)
      .then(() => {
        setIsModalVisible(false);
        dispatch(fetchVacancyCategories(paramsData));
        toast.success(t('successfully.updated'));
        setActive(false);
      })
      .finally(() => setLoadingBtn(false));
  };
  // const handleSetActive = () => {
  //   setLoadingBtn(true);
  //   categoryService
  //     .setActive(id)
  //     .then(() => {
  //       setIsModalVisible(false);
  //       dispatch(fetchVacancyCategories(paramsData));
  //       toast.success(t('successfully.updated'));
  //     })
  //     .finally(() => setLoadingBtn(false));
  // };

  return (
    <>
      {!parentId && (
        <>
          <Card className='p-0'>
            <Space wrap size={[14, 20]}>
              <DeleteButton onClick={allDelete}>
                {t('delete.selected')}
              </DeleteButton>

              <Button onClick={goToImport}>
                <CgImport className='mr-2' />
                {t('import')}
              </Button>
              <Button loading={downloading} onClick={excelExport}>
                <CgExport className='mr-2' />
                {t('export')}
              </Button>
              {parent_type !== 'child' && (
                <Button
                  type='primary'
                  icon={<PlusCircleOutlined />}
                  onClick={goToAddCategory}
                >
                  {t('add.category')}
                </Button>
              )}
              <Button
                icon={<ClearOutlined />}
                onClick={handleClear}
                disabled={!activeMenu.data}
              />
            </Space>
          </Card>
          <Card className='p-0'>
            <Space wrap size={[14, 20]}>
              <SearchInput
                placeholder={t('search')}
                className='w-25'
                handleChange={(e) => {
                  handleFilter({ search: e });
                }}
                defaultValue={activeMenu.data?.search}
                resetSearch={!activeMenu.data?.search}
                style={{ minWidth: 300 }}
              />
              <FilterColumns columns={columns} setColumns={setColumns} />
            </Space>
          </Card>
        </>
      )}

      <Card title={parentId && t('sub.category')}>
        {parentId && (
          <Space wrap size={[14, 20]}>
            <SearchInput
              placeholder={t('search')}
              handleChange={(e) => {
                handleFilter({ search: e });
              }}
              defaultValue={activeMenu.data?.search}
              resetSearch={!activeMenu.data?.search}
              style={{ minWidth: 180 }}
            />
            <DeleteButton onClick={allDelete}>
              {t('delete.selected')}
            </DeleteButton>

            <Button onClick={goToImport}>
              <CgImport className='mr-2' />
              {t('import')}
            </Button>
            <Button loading={downloading} onClick={excelExport}>
              <CgExport className='mr-2' />
              {t('export')}
            </Button>
            {parent_type !== 'child' && (
              <Button
                type='primary'
                icon={<PlusCircleOutlined />}
                onClick={goToAddCategory}
              >
                {t('add.category')}
              </Button>
            )}
            <Button
              icon={<ClearOutlined />}
              onClick={handleClear}
              disabled={!activeMenu.data}
              style={{ minWidth: 100 }}
            />
            <FilterColumns columns={columns} setColumns={setColumns} />
          </Space>
        )}

        <Table
          scroll={{ x: true }}
          rowSelection={rowSelection}
          columns={columns?.filter((item) => item.is_show)}
          dataSource={vacancyCategories}
          pagination={{
            pageSize: activeMenu.data?.perPage || 10,
            page: data?.page || 1,
            total: meta.total,
            defaultCurrent: data?.page,
            current: activeMenu.data?.page,
          }}
          rowKey={(record) => record.id}
          onChange={onChangePagination}
          loading={loading}
        />
      </Card>

      <CustomModal
        click={active ? handleActive : categoryDelete}
        text={
          active
            ? t('set.active.category')
            : text
              ? t('delete')
              : t('all.delete')
        }
        setText={setId}
        loading={loadingBtn}
      />
    </>
  );
};

export default VacancyCategories;
