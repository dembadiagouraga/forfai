import React from 'react';
import AdsForm from './components/form';
import advertService from 'services/advert';

const AdsAdd = () => {
  const handleSubmit = (body) => {
    return advertService.create(body);
  };
  return <AdsForm handleSubmit={handleSubmit} />;
};

export default AdsAdd;
