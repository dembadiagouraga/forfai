import { Space } from 'antd';
import categoryService from 'services/category';
import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { InfiniteSelect } from 'components/infinite-select';
import SearchInput from 'components/search-input';
import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import { setFilters, setParams } from 'redux/slices/product';

const Filters = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();

  const { filters } = useSelector((state) => state.product, shallowEqual);

  const [hasMore, setHasMore] = useState({ category: false });

  const fetchCategories = ({ search = '', page = 1 }) => {
    const params = {
      search: search?.length ? search : undefined,
      type: 'main',
      page,
    };
    return categoryService.search(params).then((res) => {
      setHasMore((prev) => ({ ...prev, category: !!res?.links?.next }));
      return res.data.map((item) => ({
        label: item?.translation?.title || t('N/A'),
        value: item?.id,
        key: item?.id,
      }));
    });
  };

  const handleFilter = (key, value) => {
    switch (key) {
      case 'search':
        batch(() => {
          dispatch(setFilters({ search: value }));
          dispatch(
            setParams({
              page: 1,
              search: value,
            }),
          );
        });
        break;
      case 'category':
        batch(() => {
          dispatch(setFilters({ category: value }));
          dispatch(setParams({ page: 1, category_id: value?.value }));
        });

        break;
      default:
        break;
    }
  };

  return (
    <Space wrap>
      <SearchInput
        placeholder={t('search')}
        style={{ width: 200 }}
        handleChange={(value) => handleFilter('search', value)}
        defaultValue={filters?.search}
      />
      <InfiniteSelect
        fetchOptions={fetchCategories}
        hasMore={hasMore.category}
        style={{ width: 200 }}
        placeholder={t('select.category')}
        onChange={(value) => handleFilter('category', value)}
        value={filters?.category}
      />
    </Space>
  );
};

export default Filters;
