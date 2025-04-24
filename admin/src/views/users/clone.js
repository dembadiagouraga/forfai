import { Card, Tabs } from 'antd';
import { useTranslation } from 'react-i18next';
import { lazy, Suspense, useEffect, useState } from 'react';
import Loading from 'components/loading';
import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import { fetchUserById, fetchUserWalletHistory } from 'redux/slices/user';
import { disableRefetch } from 'redux/slices/menu';
import { useParams } from 'react-router-dom';
import useDidUpdate from 'helpers/useDidUpdate';
import userService from 'services/user';

const BasicInfo = lazy(() => import('./components/form/basic-info'));
const WalletHistory = lazy(() => import('./components/wallet-history'));
const PasswordUpdate = lazy(() => import('./components/form/password-update'));

const Clone = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const { uuid } = useParams();

  const { userDetails, walletHistory } = useSelector(
    (state) => state.user,
    shallowEqual,
  );
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);

  const [activeTab, setActiveTab] = useState('basic-info');

  const handleSubmitBasicInfo = (body) => userService.create(body);

  const fetch = (uuid) => {
    batch(() => {
      switch (activeTab) {
        case 'basic-info':
          dispatch(fetchUserById({ id: uuid }));
          break;

        case 'wallet-history':
          dispatch(fetchUserWalletHistory({ id: uuid }));
          break;

        default:
          dispatch(fetchUserById({ id: uuid }));
          break;
      }
      dispatch(disableRefetch(activeMenu));
    });
  };

  useEffect(() => {
    if (uuid) {
      fetch(uuid);
    }
    return () => {};
    // eslint-disable-next-line
  }, [uuid, activeTab]);

  useDidUpdate(() => {
    if (activeMenu.refetch && uuid) {
      fetch(uuid);
    }
  }, [uuid, activeTab, activeMenu.refetch]);

  return (
    <Card>
      <Tabs
        tabPosition='left'
        size='small'
        onChange={(key) => setActiveTab(key)}
        activeKey={activeTab}
      >
        <Tabs.TabPane
          key='basic-info'
          tab={t('basic.info')}
          disabled={userDetails.loading || walletHistory.loading}
        >
          <Card loading={userDetails.loading}>
            <Suspense fallback={<Loading />}>
              <BasicInfo
                isEdit
                navigateToList
                handleSubmit={handleSubmitBasicInfo}
                role={userDetails.data?.role}
              />
            </Suspense>
          </Card>
        </Tabs.TabPane>
        <Tabs.TabPane
          key='wallet-history'
          tab={t('wallet.history')}
          disabled={userDetails.loading || walletHistory.loading}
        >
          <Card>
            <Suspense fallback={<Loading />}>
              <WalletHistory />
            </Suspense>
          </Card>
        </Tabs.TabPane>
        <Tabs.TabPane
          key='password-update'
          tab={t('password.update')}
          disabled={userDetails.loading || walletHistory.loading}
        >
          <Card>
            <Suspense fallback={<Loading />}>
              <PasswordUpdate uuid={uuid} />
            </Suspense>
          </Card>
        </Tabs.TabPane>
      </Tabs>
    </Card>
  );
};

export default Clone;
