import { Button, Modal } from 'antd';
import { useState } from 'react';
import { useTranslation } from 'react-i18next';

const ConfirmModal = ({ visible, text, onClick, onCancel }) => {
  const { t } = useTranslation();
  const [isLoading, setIsLoading] = useState(false);
  const onOk = () => {
    setIsLoading(true);
    onClick().finally(() => setIsLoading(false));
  };
  return (
    <Modal
      visible={visible}
      onCancel={onCancel}
      footer={[
        <Button onClick={onCancel}>{t('cancel')}</Button>,
        <Button type='primary' onClick={onOk} loading={isLoading}>
          {t('confirm')}
        </Button>,
      ]}
    >
      <h3>{text}</h3>
    </Modal>
  );
};

export default ConfirmModal;
