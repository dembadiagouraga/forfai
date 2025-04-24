import AttributeFunctions from './components/functions';
import AttributesList from './components/list';
import { useTranslation } from 'react-i18next';
import { shallowEqual, useDispatch, useSelector } from 'react-redux';
import { useContext, useState } from 'react';
import { Context } from 'context/context';
import attributesService from 'services/attributes';
import { toast } from 'react-toastify';
import { setRefetch } from 'redux/slices/menu';
import CustomModal from 'components/modal';

const Attributes = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const [ids, setIds] = useState(null);
  const [loadingBtn, setLoadingBtn] = useState(false);
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const { setIsModalVisible } = useContext(Context);

  const handleDeleteAttributes = () => {
    setLoadingBtn(true);
    const params = {
      ...Object.assign(
        {},
        ...ids.map((item, index) => ({
          [`ids[${index}]`]: item,
        })),
      ),
    };
    attributesService
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
      <AttributeFunctions ids={ids} />
      <AttributesList ids={ids} setIds={setIds} />
      <CustomModal
        click={handleDeleteAttributes}
        text={t('are.you.sure?')}
        loading={loadingBtn}
      />
    </>
  );
};

export default Attributes;
