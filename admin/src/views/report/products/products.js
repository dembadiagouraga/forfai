import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import { fetchProductReports } from 'redux/slices/report';
import { disableRefetch } from 'redux/slices/menu';
import { useEffect } from 'react';
import useDidUpdate from 'helpers/useDidUpdate';
import ReportProductList from './components/list';
import { Card } from 'antd';
import ReportProductFilter from './components/filter';

const ReportProducts = () => {
  const dispatch = useDispatch();

  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const { params: initialParams, filters } = useSelector(
    (state) => state.report.products,
    shallowEqual,
  );

  const params = {
    ...initialParams,
    date_from: filters?.date?.from || undefined,
    date_to: filters?.date?.to || undefined,
    user_id: filters?.user?.value || undefined,
  };

  const fetchReport = () => {
    batch(() => {
      dispatch(fetchProductReports(params));
      dispatch(disableRefetch(activeMenu));
    });
  };

  useEffect(() => {
    fetchReport();
    return () => {};
    // eslint-disable-next-line
  }, [params?.date_from, params?.date_to, params?.user_id, params?.page]);

  useDidUpdate(() => {
    if (activeMenu.refetch) {
      fetchReport();
    }
  }, [activeMenu.refetch]);

  return (
    <>
      <Card>
        <ReportProductFilter />
      </Card>
      <Card>
        <ReportProductList />
      </Card>
    </>
  );
};

export default ReportProducts;
