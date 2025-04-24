import { Button, Card, Space } from 'antd';
import { useTranslation } from 'react-i18next';
import { useDispatch } from 'react-redux';
import { addMenu } from 'redux/slices/menu';
import { useNavigate } from 'react-router-dom';
import { PlusCircleOutlined } from '@ant-design/icons';
import { toast } from 'react-toastify';
import { Context } from 'context/context';
import { useContext } from 'react';
import DeleteButton from 'components/delete-button';

const StoryFunctions = ({ ids = null }) => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { setIsModalVisible } = useContext(Context);
  const goToCreate = () => {
    dispatch(
      addMenu({
        id: 'create-story',
        url: `stories/create`,
        name: t('create.story'),
      }),
    );
    navigate(`/stories/create`);
  };

  const handleDeleteSelected = () => {
    if (!ids?.length) {
      toast.warning(t('select.stories'));
    } else {
      setIsModalVisible(true);
    }
  };

  return (
    <Card>
      <Space wrap>
        <Button
          icon={<PlusCircleOutlined />}
          type='primary'
          onClick={goToCreate}
        >
          {t('create.story')}
        </Button>
        <DeleteButton type='danger' onClick={handleDeleteSelected}>
          {t('delete.selected')}
        </DeleteButton>
      </Space>
    </Card>
  );
};

export default StoryFunctions;
