import React, { useEffect, Suspense } from 'react';
import { Outlet } from 'react-router-dom';
import { shallowEqual, useDispatch, useSelector, batch } from 'react-redux';
import { Layout } from 'antd';
import Sidebar from 'components/sidebar';
import TabMenu from 'components/tab-menu';
import ChatIcons from 'views/chat/chat-icons';
import Footer from 'components/footer';
import languagesService from 'services/languages';
import { setLangugages, setDefaultLanguage } from 'redux/slices/formLang';
import { fetchCurrencies, fetchRestCurrencies } from 'redux/slices/currency';
import { data as allRoutes } from 'configs/menu-config';
import { setUserData } from 'redux/slices/auth';
import Loading from 'components/loading';
import {
  fetchRestSettings,
  fetchSettings,
} from '../redux/slices/globalSettings';

const { Content } = Layout;

const AppLayout = () => {
  const dispatch = useDispatch();
  const { languages } = useSelector((state) => state.formLang, shallowEqual);
  const { user } = useSelector((state) => state.auth, shallowEqual);
  const { direction, navCollapsed } = useSelector(
    (state) => state.theme.theme,
    shallowEqual,
  );

  const fetchLanguages = () => {
    languagesService.getAllActive().then(({ data }) => {
      batch(() => {
        dispatch(setLangugages(data));
        dispatch(
          setDefaultLanguage(
            data?.find((item) => item?.default)?.locale || 'en',
          ),
        );
      });
    });
  };

  const getLayoutGutter = () => {
    return navCollapsed ? 80 : 250;
  };

  const getLayoutDirectionGutter = () => {
    if (direction === 'ltr') {
      return { paddingLeft: getLayoutGutter(), minHeight: '100vh' };
    }
    if (direction === 'rtl') {
      return { paddingRight: getLayoutGutter(), minHeight: '100vh' };
    }
    return { paddingLeft: getLayoutGutter() };
  };

  useEffect(() => {
    if (!languages.length) {
      fetchLanguages();
    }
    if (user?.role === 'admin' || user?.role === 'manager') {
      dispatch(fetchCurrencies({}));
      dispatch(fetchSettings({}));
    } else {
      dispatch(fetchRestCurrencies({}));
      dispatch(fetchRestSettings({}));
    }
    // eslint-disable-next-line
  }, []);

  useEffect(() => {
    // for development purpose only
    const userObj = {
      ...user,
      urls: allRoutes[user.role],
    };
    dispatch(setUserData(userObj));
    // eslint-disable-next-line
  }, []);

  return (
    <Layout className='app-container'>
      <Sidebar />
      <Layout className='app-layout' style={getLayoutDirectionGutter()}>
        <TabMenu />
        <Content className='p-3' style={{ flex: '1 0 70%' }}>
          <Suspense fallback={<Loading />}>
            <Outlet />
          </Suspense>
        </Content>
        <Footer />
      </Layout>
      <ChatIcons />
    </Layout>
  );
};

export default AppLayout;
