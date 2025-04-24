import { Table } from 'antd';
import { useTranslation } from 'react-i18next';
import ColumnImage from 'components/column/image';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import numberToPrice from 'helpers/numberToPrice';
import { setReportParams } from 'redux/slices/report';

const ReportProductList = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();

  const { defaultCurrency } = useSelector(
    (state) => state.currency,
    shallowEqual,
  );
  const { data, loading, meta, params } = useSelector(
    (state) => state.report.products,
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
      dataIndex: 'translation',
      key: 'translation',
      render: (translation) => translation?.title || t('N/A'),
    },
    {
      title: 'image',
      dataIndex: 'galleries',
      key: 'galleries',
      render: (galleries, row) => (
        <ColumnImage image={galleries?.[0]?.path} row={row} />
      ),
    },
    {
      title: t("contact.name"),
      dataIndex: 'contact_name',
      key: 'contact_name',
      render: (contact_name) => contact_name || t('N/A'),
    },
    {
      title: t('email'),
      dataIndex: 'email',
      key: 'email',
      render: (email) => email || t('N/A'),
    },
    {
      title: t('views.count'),
      dataIndex: 'views_count',
      key: 'views_count',
      render: (views_count) => views_count || 0,
    },
    {
      title: t('likes.count'),
      dataIndex: 'likes_count',
      key: 'likes_count',
      render: (likes_count) => likes_count || 0,
    },
    {
      title: t('message.click.count'),
      dataIndex: 'message_click_count',
      key: 'message_click_count',
      render: (message_click_count) => message_click_count || 0,
    },
    {
      title: t('phone.views.count'),
      dataIndex: 'phone_views_count',
      key: 'phone_views_count',
      render: (phone_views_count) => phone_views_count || 0,
    },
    {
      title: t('price'),
      dataIndex: 'price',
      key: 'price',
      render: (price) => (
        <p style={{ width: 'max-content' }}>
          {numberToPrice(
            price,
            defaultCurrency?.symbol,
            defaultCurrency?.position,
          )}
        </p>
      ),
    },
  ];

  const handleChangeTable = (pagination) => {
    dispatch(
      setReportParams({
        type: 'product',
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
        total: meta?.total,
        showSizeChanger: false,
      }}
      onChange={handleChangeTable}
    />
  );
};

export default ReportProductList;
