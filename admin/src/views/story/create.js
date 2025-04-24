import { useTranslation } from 'react-i18next';
import { Card, Form } from 'antd';
import StoryForm from './components/form';
import LanguageList from 'components/language-list';
import storeisService from 'services/storeis';

const CreateStory = () => {
  const { t } = useTranslation();
  const [form] = Form.useForm();

  const handleSubmit = (values) => storeisService.create(values);

  return (
    <Card title={t('create.story')} extra={<LanguageList />}>
      <StoryForm form={form} handleSubmit={handleSubmit} />
    </Card>
  );
};

export default CreateStory;
