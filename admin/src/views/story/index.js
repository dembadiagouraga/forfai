import { useContext, useState } from 'react';
import StoryFunctions from './components/functions';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import StoriesList from './components/list';
import CustomModal from 'components/modal';
import { Context } from 'context/context';
import storeisService from 'services/storeis';
import { useTranslation } from 'react-i18next';
import { toast } from 'react-toastify';
import { setRefetch } from 'redux/slices/menu';

const Stories = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const [ids, setIds] = useState(null);
  const [loadingBtn, setLoadingBtn] = useState(false);
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const { setIsModalVisible } = useContext(Context);

  const handleDeleteStories = () => {
    setLoadingBtn(true);
    const params = {
      ...Object.assign(
        {},
        ...ids.map((item, index) => ({
          [`ids[${index}]`]: item,
        })),
      ),
    };
    storeisService
      .delete(params)
      .then(() => {
        setIds(null);
        setIsModalVisible(false);
        toast.success(t('successfully.deleted'));
        dispatch(setRefetch(activeMenu));
      })
      .finally(() => setLoadingBtn(false));
  };

  return (
    <>
      <StoryFunctions ids={ids} />
      <StoriesList ids={ids} setIds={setIds} />
      <CustomModal
        click={handleDeleteStories}
        text={t('are.you.sure?')}
        loading={loadingBtn}
      />
    </>
  );
};

export default Stories;
