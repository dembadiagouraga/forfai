import React from 'react';
import { useParams } from 'react-router-dom';
import advertService from 'services/advert';
import AdsForm from './components/form';

const AdvertEdit = () => {
  const { id } = useParams();
  const handleSubmit = (body) => {
    return advertService.update(id, body);
  };

  return <AdsForm handleSubmit={handleSubmit} />;
};

export default AdvertEdit;
