import { Card } from 'antd';
import userService from 'services/user';
import BasicInfo from './components/form/basic-info';
import { useParams } from 'react-router-dom';

const Add = () => {
  const { role } = useParams();
  const handleSubmit = (body) => userService.create(body);

  return (
    <Card>
      <BasicInfo
        handleSubmit={handleSubmit}
        isEdit={false}
        navigateToList
        role={role}
      />
    </Card>
  );
};

export default Add;
