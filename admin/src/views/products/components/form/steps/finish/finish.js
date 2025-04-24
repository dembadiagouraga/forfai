import { Button, Card, Col, Descriptions, Row, Switch } from 'antd';
import { useTranslation } from 'react-i18next';
import { useSelector, shallowEqual, useDispatch } from 'react-redux';
import { removeFromMenu } from 'redux/slices/menu';
import numberToPrice from 'helpers/numberToPrice';
import { useNavigate } from 'react-router-dom';
import { PRODUCT_STATE_OPTIONS } from 'constants/index';
import { getValueFromTranslations } from 'helpers/getValueFromTranslations';
import Attributes from './attributes';

const Finish = ({ prev }) => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { defaultLang } = useSelector((state) => state.formLang, shallowEqual);
  const { data, loading } = useSelector(
    (state) => state.product.productDetails,
    shallowEqual,
  );
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);

  const finish = () => {
    const nextUrl = 'products';
    dispatch(removeFromMenu({ ...activeMenu, nextUrl }));
    navigate(`/${nextUrl}`);
  };

  return (
    <Card loading={loading}>
      <Row gutter={12}>
        <Col span={16}>
          <Descriptions column={1} bordered title={t('basic.info')}>
            <Descriptions.Item
              label={t('title')}
              children={getValueFromTranslations(
                'title',
                data?.translations,
                defaultLang,
              )}
            />
            <Descriptions.Item
              label={t('description')}
              children={getValueFromTranslations(
                'title',
                data?.translations,
                defaultLang,
              )}
            />
          </Descriptions>
          <br />
          <Descriptions column={1} bordered title={t('pricing')}>
            <Descriptions.Item
              label={t('price')}
              children={numberToPrice(
                data?.price,
                data?.currency?.symbol,
                data?.currency?.position,
              )}
            />
          </Descriptions>
          <br />
          <Descriptions column={1} bordered title={t('seller.info')}>
            <Descriptions.Item
              label={t('seller')}
              children={`#${data?.user?.id || ''}. ${data?.user?.firstname || ''} ${data?.user?.lastname || ''}`}
            />
            <Descriptions.Item
              label={t('contact.name')}
              children={data?.contact_name || t('N/A')}
            />
            <Descriptions.Item
              label={t('email')}
              children={data?.email || t('N/A')}
            />
            <Descriptions.Item
              label={t('phone')}
              children={data?.phone || t('N/A')}
            />
          </Descriptions>
        </Col>
        <Col span={8}>
          <Descriptions column={1} bordered title={t('organization')}>
            <Descriptions.Item
              label={t('category')}
              children={data?.category?.translation?.title}
            />
            <Descriptions.Item
              label={t('type')}
              children={t(data?.type || 'N/A')}
            />
            <Descriptions.Item
              label={t('state')}
              children={t(
                PRODUCT_STATE_OPTIONS.find(
                  (item) => item?.value === data?.state,
                )?.label || 'N/A',
              )}
            />
            <Descriptions.Item
              label={t('active')}
              children={<Switch checked={!!data?.active} />}
            />
          </Descriptions>
          <br />
          <Descriptions column={1} bordered title={t('location')}>
            <Descriptions.Item
              label={t('region')}
              children={data?.region?.translation?.title}
            />
            <Descriptions.Item
              label={t('country')}
              children={data?.country?.translation?.title}
            />
            <Descriptions.Item
              label={t('city')}
              children={data?.city?.translation?.title}
            />
            {!!data?.area && (
              <Descriptions.Item
                label={t('area')}
                children={data?.area?.translation?.title}
              />
            )}
          </Descriptions>
        </Col>
        {!!data?.attributes?.length && (
          <Col span={24} className='mt-5'>
            <h4 className='font-weight-bold font-size-md'>{t('attributes')}</h4>
            <Attributes data={data?.attributes} />
          </Col>
        )}
      </Row>
      <div className='d-flex align-items-center justify-content-between mt-4'>
        <Button onClick={prev}>{t('prev')}</Button>
        <Button type='primary' onClick={finish}>
          {t('finish')}
        </Button>
      </div>
    </Card>
  );
};

export default Finish;
