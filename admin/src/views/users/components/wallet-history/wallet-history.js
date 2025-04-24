import { Button, Space, Table } from 'antd';
import { useTranslation } from 'react-i18next';
import numberToPrice from 'helpers/numberToPrice';
import moment from 'moment';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import { PlusCircleOutlined } from '@ant-design/icons';
import { useState } from 'react';
import WalletTopUp from './wallet-top-up';
import { setWalletHistoryParams } from 'redux/slices/user';

const WalletHistory = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();

  const { walletHistory, userDetails } = useSelector(
    (state) => state.user,
    shallowEqual,
  );

  const { data, loading, meta } = walletHistory;

  const [isWalletTopUpModalVisible, setIsWalletTopUpModalVisible] =
    useState(false);

  const columns = [
    {
      title: t('created.by'),
      dataIndex: 'author',
      key: 'author',
      render: (author) =>
        `#${author?.id}. ${author?.firstname || ''} ${author?.lastname || ''}`,
    },
    {
      title: t('price'),
      dataIndex: 'price',
      key: 'price',
      render: (price) => numberToPrice(price),
    },
    {
      title: t('note'),
      dataIndex: 'note',
      key: 'note',
      render: (note) => note || t('N/A'),
    },
    {
      title: t('created.at'),
      dataIndex: 'created_at',
      key: 'created_at',
      render: (createdAt) =>
        createdAt ? moment(createdAt).format('YYYY-MM-DD HH:mm') : t('N/A'),
    },
  ];

  const handleChangeTable = (pagination) => {
    dispatch(setWalletHistoryParams({ page: pagination?.current || 1 }));
  };

  return (
    <>
      <Space className='mb-5'>
        <Button
          icon={<PlusCircleOutlined />}
          type='primary'
          onClick={() => setIsWalletTopUpModalVisible(true)}
        >{`${t('wallet')}: ${numberToPrice(userDetails.data?.wallet?.price)}`}</Button>
      </Space>
      <Table
        loading={loading}
        scroll={{ x: true }}
        columns={columns}
        dataSource={data}
        pagination={{
          current: meta?.current_page,
          pageSize: meta?.per_page,
          total: meta?.total,
        }}
        onChange={handleChangeTable}
      />
      {isWalletTopUpModalVisible && (
        <WalletTopUp
          uuid={userDetails.data?.uuid}
          visible={isWalletTopUpModalVisible}
          closeModal={() => setIsWalletTopUpModalVisible(false)}
        />
      )}
    </>
  );
};

export default WalletHistory;
