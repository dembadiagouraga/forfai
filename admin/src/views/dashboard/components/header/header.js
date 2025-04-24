import { Card } from 'antd';
import React from 'react';
import { useTranslation } from 'react-i18next';
import { shallowEqual, useSelector } from 'react-redux';
import Filters from '../filters';

const Header = () => {
  const { t } = useTranslation();
  const { user } = useSelector((state) => state.auth, shallowEqual);

  return (
    <>
      <Card>
        <div className='d-flex justify-content-between'>
          <div>
            <h2>
              {t('hello')}, {user.fullName} 👋
            </h2>
            <p>{t('hello.text')}</p>
          </div>
        </div>
      </Card>
      <Card>
        <Filters />
      </Card>
    </>
  );
};

export default Header;
