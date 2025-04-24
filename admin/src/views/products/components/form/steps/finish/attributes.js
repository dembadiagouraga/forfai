import { Table } from 'antd';
import { useTranslation } from 'react-i18next';

const AttributesTable = ({ data, loading = false }) => {
  const { t } = useTranslation();
  const columns = [
    {
      title: t('id'),
      dataIndex: 'id',
      key: 'id',
    },
    {
      title: t('type'),
      dataIndex: 'type',
      key: 'type',
      render: (type) => t(type || 'N/A'),
    },
    {
      title: t('title'),
      dataIndex: 'translation',
      key: 'translation',
      render: (translation) => translation?.title || t('N/A'),
    },
    {
      title: t('values'),
      dataIndex: 'values',
      key: 'values',
      render: (values) =>
        values
          ?.map(
            (value) =>
              value?.attribute_value?.translation?.title || value?.value,
          )
          ?.join(', ') || t('N/A'),
    },
  ];
  return (
    <Table
      pagination={false}
      scroll={{ x: true }}
      loading={loading}
      dataSource={data}
      columns={columns}
      bordered
    />
  );
};

export default AttributesTable;
