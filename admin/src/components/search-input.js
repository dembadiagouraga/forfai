import React, { useMemo, useState, useEffect } from 'react';
import { Input } from 'antd';
import { debounce } from 'lodash';
import { SearchOutlined } from '@ant-design/icons';

export default function SearchInput({
  handleChange,
  defaultValue,
  resetSearch,
  ...props
}) {
  const [searchTerm, setSearchTerm] = useState(defaultValue);

  const debounceSearch = useMemo(() => {
    const loadOptions = (value) => {
      handleChange(value);
    };
    return debounce(loadOptions, 800);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  useEffect(() => {
    setSearchTerm(defaultValue);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [resetSearch]);

  return (
    <Input
      value={searchTerm}
      onChange={(event) => {
        setSearchTerm(event.target.value);
        debounceSearch(event.target.value);
      }}
      prefix={<SearchOutlined />}
      {...props}
    />
  );
}
