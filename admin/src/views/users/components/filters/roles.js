import { Tabs } from 'antd';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import { useTranslation } from 'react-i18next';
import { setParams } from 'redux/slices/user';

const RolesFilter = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();

  const { params } = useSelector((state) => state.user, shallowEqual);
  const { roles } = useSelector((state) => state.role, shallowEqual);

  return (
    <Tabs
      type='card'
      activeKey={params?.role}
      onChange={(key) => {
        dispatch(setParams({ role: key, page: 1 }));
      }}
    >
      {roles?.map((role) => (
        <Tabs.TabPane tab={t(role?.name)} key={role?.name} />
      ))}
    </Tabs>
  );
};

export default RolesFilter;
