import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import { useEffect } from 'react';
import { disableRefetch } from 'redux/slices/menu';
import { fetchStatistics } from 'redux/slices/dashboard';
import useDidUpdate from 'helpers/useDidUpdate';
import Header from './components/header';
import Statistics from './components/statistics';

const Dashboard = () => {
  const dispatch = useDispatch();

  const { params } = useSelector((state) => state.dashboard, shallowEqual);
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);

  const fetch = () => {
    batch(() => {
      dispatch(fetchStatistics(params));
      dispatch(disableRefetch(activeMenu));
    });
  };

  useEffect(() => {
    fetch();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [params?.date_to]);

  useDidUpdate(() => {
    if (activeMenu.refetch) {
      fetch();
    }
  }, [activeMenu.refetch]);

  return (
    <>
      <Header />
      <Statistics />
    </>
  );
};

export default Dashboard;
