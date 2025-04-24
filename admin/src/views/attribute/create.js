import { Card, Form } from 'antd';
import AttributeForm from './components/form';
import { useTranslation } from 'react-i18next';
import LanguageList from 'components/language-list';
import attributesService from 'services/attributes';

const CreateAttribute = () => {
  const { t } = useTranslation();
  const [form] = Form.useForm();

  const handleSubmit = (body) => attributesService.create(body);

  return (
    <Card title={t('create.attribute')} extra={<LanguageList />}>
      <AttributeForm form={form} handleSubmit={handleSubmit} />
    </Card>
  );
};

export default CreateAttribute;
