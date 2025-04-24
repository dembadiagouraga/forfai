import React, { useEffect } from 'react';
import { Card, Table } from 'antd';
import { useTranslation } from 'react-i18next';
import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import { fetchRoles } from 'redux/slices/role';
import { disableRefetch } from 'redux/slices/menu';
import useDidUpdate from 'helpers/useDidUpdate';

const RoleList = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const { loading, roles } = useSelector((state) => state.role, shallowEqual);
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);

  const columns = [
    {
      title: t('id'),
      dataIndex: 'id',
      key: 'id',
    },
    {
      title: t('name'),
      dataIndex: 'name',
      key: 'name',
      render: (name) => t(name),
    },
  ];

  const fetch = () => {
    batch(() => {
      dispatch(fetchRoles({}));
      dispatch(disableRefetch(activeMenu));
    });
  };

  useEffect(() => {
    fetch();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  useDidUpdate(() => {
    if (activeMenu?.refetch) {
      fetch();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [activeMenu?.refetch]);

  return (
    <Card title={t('roles')}>
      <Table
        scroll={{ x: true }}
        columns={columns}
        dataSource={roles}
        loading={loading}
        pagination={false}
        rowKey={(record) => record.id}
      />
    </Card>
  );
};

export default RoleList;
