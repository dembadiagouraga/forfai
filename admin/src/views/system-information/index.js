import { useEffect, useState } from 'react';
import { Card, Descriptions } from 'antd';
import installationService from 'services/installation';
import { useTranslation } from 'react-i18next';

export default function SystemInformation() {
  const { t } = useTranslation();
  const [loading, setLoading] = useState(false);
  const [list, setList] = useState([]);

  useEffect(() => {
    setLoading(true);
    installationService
      .systemInformation()
      .then(({ data }) => setList(Object.entries(data)))
      .finally(() => setLoading(false));
  }, []);

  return (
    <Card title={t('system.information')} loading={loading}>
      <div style={{ maxWidth: '700px' }}>
        <Descriptions bordered>
          {list.map((item, index) => (
            <Descriptions.Item key={index} label={item[0]} span={3}>
              {item[1]}
            </Descriptions.Item>
          ))}
        </Descriptions>
      </div>
    </Card>
  );
}
