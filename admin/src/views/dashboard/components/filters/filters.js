import { DatePicker, Space } from 'antd';
import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import moment from 'moment';
import { setFilters, setParams } from 'redux/slices/dashboard';

const { RangePicker } = DatePicker;

const Filters = () => {
  const dispatch = useDispatch();
  const { filters, statistics } = useSelector(
    (state) => state.dashboard,
    shallowEqual,
  );

  const handleFilter = (key, value) => {
    switch (key) {
      case 'date':
        batch(() => {
          dispatch(setFilters({ date: value }));
          dispatch(setParams({ date_from: value.from, date_to: value.to }));
        });
        break;

      default:
        break;
    }
  };

  return (
    <Space>
      <RangePicker
        disabled={statistics.loading}
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
    </Space>
  );
};

export default Filters;
