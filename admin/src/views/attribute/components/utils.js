import getTranslationFields from 'helpers/getTranslationFields';

export const parseFormValues = (
  formValues,
  languages,
  isCreateMany,
  isEdit,
) => {
  const attributes = formValues.attributes;

  if (isCreateMany) {
    return attributes.map((attribute) =>
      formatAttributeValues(
        attribute,
        formValues.category,
        languages,
        false,
        !!formValues?.required,
      ),
    );
  } else {
    return formatAttributeValues(
      attributes[0],
      formValues.category,
      languages,
      isEdit,
      !!formValues?.required,
    );
  }
};

const formatAttributeValues = (
  attribute,
  category,
  languages,
  isEdit,
  required,
) => {
  const item = {
    category_id: category.value,
    required,
    type: attribute.type,
    title: getTranslationFields(languages, attribute, 'title'),
    valueIds: [],
  };

  if (
    attribute.type === 'from_to' ||
    attribute.type === 'drop_down' ||
    attribute.type === 'input' ||
    attribute.type === 'checkbox' ||
    attribute.type === 'radio'
  ) {
    item.placeholder = getTranslationFields(
      languages,
      attribute,
      'placeholder',
    );
  }

  // if (attribute.type === 'yes_or_no' || attribute.type === 'drop_down') {
  //   item.value = attribute.value.map((item) =>
  //     getTranslationFields(languages, item, 'title'),
  //   );
  //   if (isEdit) item.valueIds = attribute.value.map((item) => item.id);
  // }

  if (
    attribute.type === 'yes_or_no' ||
    attribute.type === 'drop_down' ||
    attribute.type === 'checkbox' ||
    attribute.type === 'radio'
  ) {
    item.value = attribute.value.map((option) => {
      if (option?.id) {
        item.valueIds.push(option?.id);
      }
      return {
        ...languages.reduce((acc, cur) => {
          if (option?.[`title[${cur?.locale}]`]) {
            acc[cur?.locale] = option?.[`title[${cur?.locale}]`];
          }
          if (option?.id) {
            acc['id'] = `${option?.id}`;
          }
          return acc;
        }, {}),
      };
    });
  }

  if (attribute.type === 'from_to') {
    item.placeholder_to = getTranslationFields(
      languages,
      attribute,
      'placeholder_to',
    );
  }
  return item;
};
