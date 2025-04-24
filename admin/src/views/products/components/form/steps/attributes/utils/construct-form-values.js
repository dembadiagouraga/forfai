export const constructKey = (type, id) => `${type}_${id}`;

export const constructFormValues = (data) => {
  const result = {};
  data?.forEach((attribute) => {
    switch (attribute?.type) {
      case 'checkbox': {
        result[constructKey(attribute?.type, attribute?.id)] = [
          ...new Set(
            attribute?.values?.map((value) => value?.attribute_value_id),
          ),
        ];
        break;
      }
      case 'radio': {
        result[constructKey(attribute?.type, attribute?.id)] =
          attribute?.values?.[0]?.attribute_value_id;
        break;
      }
      case 'from_to': {
        result[constructKey('from_from', attribute?.id)] =
          attribute?.values?.[0]?.value;
        result[constructKey('from_to', attribute?.id)] =
          attribute?.values?.[1]?.value;
        break;
      }
      case 'input': {
        result[constructKey(attribute?.type, attribute?.id)] =
          attribute?.values?.[0]?.value;
        break;
      }
      case 'yes_or_no': {
        result[constructKey(attribute?.type, attribute?.id)] =
          attribute?.values?.[0]?.attribute_value_id;
        break;
      }
      case 'drop_down': {
        result[constructKey(attribute?.type, attribute?.id)] = [
          ...new Set(
            attribute?.values?.map((value) => value?.attribute_value_id),
          ),
        ];
        break;
      }
      default:
        break;
    }
  });
  return result;
};
