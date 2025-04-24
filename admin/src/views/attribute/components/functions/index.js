import { useTranslation } from 'react-i18next';
import { useDispatch } from 'react-redux';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { addMenu } from 'redux/slices/menu';
import { Button, Card, Space } from 'antd';
import { PlusCircleOutlined } from '@ant-design/icons';
import DeleteButton from 'components/delete-button';
import { toast } from 'react-toastify';
import { useContext } from 'react';
import { Context } from 'context/context';
import SearchInput from 'components/search-input';

const AttributeFunctions = ({ ids = null }) => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { setIsModalVisible } = useContext(Context);
  const [searchParams, setSearchParams] = useSearchParams();

  const handleFilter = (key, value) => {
    const filterValue = value?.toString().trim() || '';
    if (filterValue.length === 0) return removeFilter(key);

    searchParams.set(key, filterValue);
    setSearchParams(searchParams);
  };

  const removeFilter = (key) => {
    searchParams.delete(key);
    setSearchParams(searchParams);
  };

  const goToCreate = () => {
    dispatch(
      addMenu({
        id: 'create-attribute',
        url: `attributes/create`,
        name: t('create.attribute'),
      }),
    );
    navigate(`/attributes/create`);
  };
  const gotoCreateMany = () => {
    dispatch(
      addMenu({
        id: 'create-many-attributes',
        url: `attributes/create-many`,
        name: t('create.many.attribute'),
      }),
    );
    navigate(`/attributes/create-many`);
  };

  const handleDeleteSelected = () => {
    if (!ids?.length) {
      toast.warning(t('select.attributes'));
    } else {
      setIsModalVisible(true);
    }
  };

  return (
    <Card>
      <Space wrap>
        <Button
          icon={<PlusCircleOutlined />}
          type='primary'
          onClick={goToCreate}
        >
          {t('create.attribute')}
        </Button>
        <Button
          icon={<PlusCircleOutlined />}
          type='primary'
          onClick={gotoCreateMany}
        >
          {t('create.many.attributes')}
        </Button>
        <DeleteButton onClick={handleDeleteSelected}>
          {t('delete.selected')}
        </DeleteButton>
        <SearchInput
          placeholder={t('search')}
          handleChange={(value) => handleFilter('search', value)}
          debounceTimeout={300}
          style={{ minWidth: 180 }}
          defaultValue={searchParams.get('search')}
        />
      </Space>
    </Card>
  );
};

export default AttributeFunctions;
