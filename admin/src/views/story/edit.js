import { Card, Form } from 'antd';
import { useTranslation } from 'react-i18next';
import StoryForm from './components/form';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import { useParams } from 'react-router-dom';
import { useEffect, useState } from 'react';
import storyService from 'services/storeis';
import getLanguageFields from 'helpers/getLanguageFields';
import { disableRefetch } from 'redux/slices/menu';
import LanguageList from 'components/language-list';

function EditStory() {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const [form] = Form.useForm();
  const { id } = useParams();
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const { languages } = useSelector((state) => state.formLang, shallowEqual);

  const [loading, setLoading] = useState(false);

  const createImages = (items) =>
    items.map((item) => ({
      name: item,
      url: item,
    }));

  const fetchStory = (id) => {
    setLoading(true);
    storyService
      .getById(id)
      .then(({ data }) => {
        const body = {
          ...getLanguageFields(languages, data, ['title']),
          images: createImages(data?.file_urls),
          color: data?.color,
        };

        form.setFieldsValue(body);
      })
      .finally(() => setLoading(false));
  };

  useEffect(() => {
    fetchStory(id);
    dispatch(disableRefetch(activeMenu));
    // eslint-disable-next-line
  }, [activeMenu.refetch]);

  const handleSubmit = (body) => storyService.update(id, body);

  return (
    <Card title={t('edit.story')} loading={loading} extra={<LanguageList />}>
      <StoryForm form={form} handleSubmit={handleSubmit} />
    </Card>
  );
}

export default EditStory;
