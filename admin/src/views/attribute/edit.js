import { useTranslation } from 'react-i18next';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import { Card, Form } from 'antd';
import { useParams } from 'react-router-dom';
import { useEffect, useRef, useState } from 'react';
import attributesService from 'services/attributes';
import LanguageList from 'components/language-list';
import AttributeForm from './components/form';
import { disableRefetch } from 'redux/slices/menu';
import getLanguageFields from 'helpers/getLanguageFields';
import useDidUpdate from '../../helpers/useDidUpdate';

const EditAttribute = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const [form] = Form.useForm();
  const { id } = useParams();
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const { languages } = useSelector((state) => state.formLang, shallowEqual);
  const initialOptionIds = useRef([]);

  const [loading, setLoading] = useState(false);

  const fetchAttribute = (id) => {
    setLoading(true);
    attributesService
      .getById(id)
      .then(({ data }) => {
        const translationFields = ['title'];
        if (data.type === 'from_to') translationFields.push('placeholder_to');
        if (
          data.type === 'from_to' ||
          data.type === 'drop_down' ||
          data.type === 'input' ||
          data.type === 'checkbox' ||
          data.type === 'radio'
        ) {
          translationFields.push('placeholder');
        }
        const formValues = {
          required: !!data?.required,
          category: {
            value: data.category.id,
            label: data.category?.translation?.title,
          },
          attributes: [
            {
              type: data.type,
              ...getLanguageFields(languages, data, translationFields),
            },
          ],
        };
        if (
          data.type === 'yes_or_no' ||
          data.type === 'drop_down' ||
          data.type === 'checkbox' ||
          data.type === 'radio'
        ) {
          formValues.attributes[0].value = data.values.map((item) => ({
            id: item.id,
            ...getLanguageFields(languages, item, ['title']),
          }));
          initialOptionIds.current = data.values.map((item) => item.id);
        }
        form.setFieldsValue(formValues);
      })
      .finally(() => setLoading(false));
  };

  useEffect(() => {
    fetchAttribute(id);
    dispatch(disableRefetch(activeMenu));
    // eslint-disable-next-line
  }, [id]);

  useDidUpdate(() => {
    if (activeMenu.refetch && id) {
      fetchAttribute(id);
      dispatch(disableRefetch(activeMenu));
    }
  }, [activeMenu.refetch, id]);

  const handleSubmit = (body) => {
    const delete_value_ids = initialOptionIds.current.filter(
      (initialId) => body?.valueIds?.indexOf(initialId) === -1,
    );
    const bodyCopy = { ...body, delete_value_ids, valueIds: undefined };

    return attributesService.update(id, bodyCopy);
  };

  return (
    <Card
      title={t('edit.attribute')}
      loading={loading}
      extra={<LanguageList />}
    >
      <AttributeForm form={form} handleSubmit={handleSubmit} isEdit />
    </Card>
  );
};

export default EditAttribute;
