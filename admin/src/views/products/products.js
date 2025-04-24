import React, { Fragment } from 'react';
import { Card } from 'antd';
import Header from './components/header';
import StatusFilter from './components/filters/status';
import List from './components/list';

const ProductCategories = () => {
  return (
    <Fragment>
      <Header />
      <Card>
        <StatusFilter />
        <List />
      </Card>
    </Fragment>
  );
};

export default ProductCategories;
