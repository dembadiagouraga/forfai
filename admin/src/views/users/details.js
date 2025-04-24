import { Card, Descriptions } from 'antd';
import { useTranslation } from 'react-i18next';
import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import { useParams } from 'react-router-dom';
import { fetchUserById } from 'redux/slices/user';
import { disableRefetch } from 'redux/slices/menu';
import { useEffect } from 'react';
import useDidUpdate from 'helpers/useDidUpdate';
import ColumnImage from 'components/column/image';
import moment from 'moment/moment';
import hideEmail from 'components/hideEmail';
import hideNumber from 'components/hideNumber';

const ReactAppIsDemo = process.env.REACT_APP_IS_DEMO === 'true';

const Details = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const { id: uuid } = useParams();

  const { data, loading } = useSelector(
    (state) => state.user.userDetails,
    shallowEqual,
  );
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);

  const fetch = (uuid) => {
    batch(() => {
      dispatch(fetchUserById({ id: uuid }));
      dispatch(disableRefetch(activeMenu));
    });
  };

  useEffect(() => {
    if (uuid) {
      fetch(uuid);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [uuid]);

  useDidUpdate(() => {
    if (activeMenu.refetch && uuid) {
      fetch(uuid);
    }
  }, [activeMenu.refetch, uuid]);

  return (
    <Card title={t('user.details')} loading={loading}>
      <ColumnImage image={data?.img} row={data} />
      <Descriptions column={1} className='mt-4'>
        <Descriptions.Item label={t('firstname')}>
          {data?.firstname || t('N/A')}
        </Descriptions.Item>
        <Descriptions.Item label={t('lastname')}>
          {data?.lastname || t('N/A')}
        </Descriptions.Item>
        <Descriptions.Item label={t('birthday')}>
          {data?.birthday
            ? moment(data?.birthday).format('YYYY-MM-DD')
            : t('N/A')}
        </Descriptions.Item>
        <Descriptions.Item label={t('registration.date')}>
          {data?.registered_at
            ? moment(data?.registered_at).format('YYYY-MM-DD HH:mm')
            : t('N/A')}
        </Descriptions.Item>
        <Descriptions.Item label={t('email')}>
          {data?.email
            ? ReactAppIsDemo
              ? hideEmail(data?.email)
              : data?.email
            : t('N/A')}
        </Descriptions.Item>
        <Descriptions.Item label={t('phone')}>
          {data?.phone
            ? ReactAppIsDemo
              ? hideNumber(data?.phone)
              : data?.phone
            : t('N/A')}
        </Descriptions.Item>
        <Descriptions.Item label={t('gender')}>
          {data?.gender || t('N/A')}
        </Descriptions.Item>
        <Descriptions.Item label={t('role')}>
          {data?.role || t('N/A')}
        </Descriptions.Item>
      </Descriptions>
    </Card>
  );
};

export default Details;
