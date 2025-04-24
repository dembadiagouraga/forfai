import { Card } from 'antd';
import Filters from '../filters';
import Navigations from '../navigations';

const Header = () => {
  return (
    <>
      <Card>
        <Navigations />
      </Card>
      <Card>
        <Filters />
      </Card>
    </>
  );
};

export default Header;
