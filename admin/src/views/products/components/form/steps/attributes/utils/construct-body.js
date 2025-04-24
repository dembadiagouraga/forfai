export const constructBody = (body, item) => {
  if (!item[1]) return;
  const attributeId = Number(item?.[0]?.split('_')?.pop());
  if (typeof item[1] === 'string') {
    body.push({
      attribute_id: attributeId,
      value: item?.[1],
    });
  } else if (Array.isArray(item[1])) {
    item[1].forEach((value) => {
      constructBody(body, [item[0], value]);
    });
  } else {
    body.push({
      attribute_id: attributeId,
      value_id: item?.[1],
    });
  }
};
