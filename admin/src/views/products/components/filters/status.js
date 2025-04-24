import { PRODUCT_STATUSES } from 'constants/index';
import { Tabs } from 'antd';
import { useTranslation } from 'react-i18next';
import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import { setFilters, setParams } from 'redux/slices/product';

const StatusFilter = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const { filters } = useSelector((state) => state.product, shallowEqual);
  return (
    <Tabs
      activeKey={filters.status}
      type='card'
      onChange={(key) => {
        batch(() => {
          dispatch(setFilters({ status: key }));
          if (key === 'all') {
            dispatch(setParams({ status: undefined }));
          } else {
            dispatch(setParams({ status: key }));
          }
          dispatch(setParams({ page: 1 }));
        });
      }}
    >
      {['all', ...PRODUCT_STATUSES].map((status) => (
        <Tabs.TabPane key={status} tab={t(status)} />
      ))}
    </Tabs>
  );
};

export default StatusFilter;
