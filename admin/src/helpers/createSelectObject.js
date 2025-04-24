const createSelectObject = (data) => {
  if (!data?.id) return null;
  return {
    label: data?.translation ? data?.translation?.title : data?.title,
    value: data?.id,
    key: data?.id,
  };
};

export default createSelectObject;
