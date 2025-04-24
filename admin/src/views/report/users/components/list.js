import { useTranslation } from 'react-i18next';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import { setReportParams } from 'redux/slices/report';
import { Table } from 'antd';
import ColumnImage from 'components/column/image';

const ReportUserList = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();

  const { data, loading, meta, params } = useSelector(
    (state) => state.report.users,
    shallowEqual,
  );

  const columns = [
    {
      title: t('id'),
      dataIndex: 'id',
      key: 'id',
    },
    {
      title: t('name'),
      key: 'name',
      render: (row) => `${row?.firstname || ''} ${row?.lastname || ''}`,
    },
    {
      title: t('image'),
      dataIndex: 'img',
      key: 'img',
      render: (img, row) => <ColumnImage image={img} row={row} />,
    },
    {
      title: t('phone'),
      dataIndex: 'phone',
      key: 'phone',
      render: (phone) => phone || t('N/A'),
    },
    {
      title: t('feedbacks.count'),
      dataIndex: 'feed_backs_count',
      key: 'feed_backs_count',
      render: (feed_backs_count) => feed_backs_count || 0,
    },
    {
      title: t('helpful.counts'),
      dataIndex: 'helpful',
      key: 'helpful',
      render: (helpful) => helpful || 0,
    },
    {
      title: t('not.helpful.counts'),
      dataIndex: 'not_helpful',
      key: 'not_helpful',
      render: (not_helpful) => not_helpful || 0,
    },
  ];

  const handleChangeTable = (pagination) => {
    dispatch(
      setReportParams({
        type: 'user',
        params: { page: pagination?.current },
      }),
    );
  };

  return (
    <Table
      scroll={{ x: true }}
      loading={loading}
      dataSource={data}
      columns={columns}
      pagination={{
        current: params?.page || 1,
        pageSize: meta?.per_page || 10,
        total: meta?.total,
      }}
      onChange={handleChangeTable}
    />
  );
};

export default ReportUserList;
