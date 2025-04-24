import { DatePicker, Space } from 'antd';
import { InfiniteSelect } from 'components/infinite-select';
import userService from 'services/user';
import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import moment from 'moment';
import { setReportFilters, setReportParams } from 'redux/slices/report';

const { RangePicker } = DatePicker;

const ReportProductFilter = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();

  const { filters } = useSelector(
    (state) => state.report.products,
    shallowEqual,
  );

  const [hasMore, setHasMore] = useState(true);

  const fetchUserOptions = ({ search = '', page = 1 }) => {
    const params = {
      search: search?.length ? search : undefined,
      perPage: 10,
      page,
    };
    return userService.search(params).then((res) => {
      setHasMore(!!res?.links?.next);
      return res?.data?.map((item) => ({
        label: `${item?.firstname || ''} ${item?.lastname || ''}`,
        value: item?.id,
        key: item?.id,
      }));
    });
  };

  const handleFilter = (key, value) => {
    switch (key) {
      case 'date':
        batch(() => {
          dispatch(
            setReportFilters({
              type: 'product',
              filters: {
                date: value,
              },
            }),
          );
          dispatch(setReportParams({ type: 'product', params: { page: 1 } }));
        });
        break;

      case 'user':
        batch(() => {
          dispatch(
            setReportFilters({
              type: 'product',
              filters: {
                user: value,
              },
            }),
          );
          dispatch(setReportParams({ type: 'product', params: { page: 1 } }));
        });
        break;

      default:
        break;
    }
  };

  return (
    <Space>
      <RangePicker
        allowClear={false}
        defaultValue={
          filters?.date
            ? [
                moment(filters?.date?.from, 'YYYY-MM-DD'),
                moment(filters?.date?.to, 'YYYY-MM-DD'),
              ]
            : undefined
        }
        onChange={(date) =>
          handleFilter('date', {
            from: moment(date?.[0]).format('YYYY-MM-DD'),
            to: moment(date?.[1]).format('YYYY-MM-DD'),
          })
        }
      />
      <InfiniteSelect
        fetchOptions={fetchUserOptions}
        hasMore={hasMore}
        placeholder={t('select.user')}
        style={{ width: 250 }}
        onChange={(value) => handleFilter('user', value)}
        defaultValue={filters?.user}
      />
    </Space>
  );
};

export default ReportProductFilter;
