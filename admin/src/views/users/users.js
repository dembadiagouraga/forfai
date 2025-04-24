import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import { fetchUsers } from 'redux/slices/user';
import { disableRefetch } from 'redux/slices/menu';
import { useEffect } from 'react';
import { fetchRoles } from 'redux/slices/role';
import { Card } from 'antd';
import useDidUpdate from 'helpers/useDidUpdate';
import Header from './components/header';
import RolesFilter from './components/filters/roles';
import List from './components/list';

const Users = () => {
  const dispatch = useDispatch();

  const { params } = useSelector((state) => state.user, shallowEqual);
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);

  const fetch = () => {
    batch(() => {
      dispatch(fetchRoles({}));
      dispatch(fetchUsers(params));
      dispatch(disableRefetch(activeMenu));
    });
  };

  useEffect(() => {
    fetch();
    // eslint-disable-next-line
  }, [params?.page, params?.search, params?.role]);

  useDidUpdate(() => {
    if (activeMenu.refetch) {
      fetch();
    }
  }, [activeMenu.refetch]);

  return (
    <>
      <Card>
        <Header />
      </Card>
      <Card>
        <RolesFilter />
        <List />
      </Card>
    </>
  );
};

export default Users;
