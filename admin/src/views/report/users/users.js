import { Card } from 'antd';
import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import { fetchUserReports } from 'redux/slices/report';
import { disableRefetch } from 'redux/slices/menu';
import { useEffect } from 'react';
import useDidUpdate from 'helpers/useDidUpdate';
import ReportUserFilter from './components/filter';
import ReportUserList from './components/list';

const ReportUsers = () => {
  const dispatch = useDispatch();

  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const { params: initialParams, filters } = useSelector(
    (state) => state.report.users,
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
      dispatch(fetchUserReports(params));
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
        <ReportUserFilter />
      </Card>
      <Card>
        <ReportUserList />
      </Card>
    </>
  );
};

export default ReportUsers;
