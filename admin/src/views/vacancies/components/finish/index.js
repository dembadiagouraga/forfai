import React, { useEffect, useState } from 'react';
import { Button, Card, Col, Descriptions, Row, Space } from 'antd';
import { useTranslation } from 'react-i18next';
import { useParams } from 'react-router-dom';
import productService from 'services/product';
import { useSelector, shallowEqual, useDispatch } from 'react-redux';
import getLanguageFields from 'helpers/getLanguageFields';
import { disableRefetch, removeFromMenu } from 'redux/slices/menu';
import numberToPrice from 'helpers/numberToPrice';
import { fetchVacancies } from 'redux/slices/vacancy';
import { useNavigate } from 'react-router-dom';

const Finish = ({ prev }) => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { uuid } = useParams();
  const { languages, defaultLang } = useSelector(
    (state) => state.formLang,
    shallowEqual,
  );
  const { defaultCurrency } = useSelector(
    (state) => state.currency,
    shallowEqual,
  );
  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const [data, setData] = useState({});
  const [loading, setLoading] = useState(false);

  const fetchVacancy = (uuid) => {
    if (!uuid) return;
    setLoading(true);
    productService
      .getById(uuid)
      .then(({ data }) => {
        const body = {
          // basic info
          ...getLanguageFields(languages, data, ['title', 'description']),
          // organization
          user: data?.user,
          category: data?.category,
          unit: data?.unit,
          // pricing
          price_to: data?.price_to,
          price_from: data?.price_from,
          price: data?.price || 0,
          currency: data?.currency || defaultCurrency,
          // location
          region: data?.region,
          country: data?.country,
          city: data?.city,
          area: data?.area,
          // media
          images: data?.images,
          videos: data?.videos,
          // additions
          age_limit: data?.age_limit,
          active: Boolean(data?.active),
          work: true,
        };
        setData(body);
      })
      .finally(() => setLoading(false));
  };
  useEffect(() => {
    if (activeMenu.refetch && !!uuid) {
      fetchVacancy(uuid);
      dispatch(disableRefetch(activeMenu));
    }
    //  eslint-disable-next-line
  }, [activeMenu.refetch]);
  useEffect(() => {
    if (!!uuid) {
      fetchVacancy(uuid);
      dispatch(disableRefetch(activeMenu));
    }
    // eslint-disable-next-line
  }, [uuid]);
  const finish = () => {
    const nextUrl = 'vacancies';
    dispatch(removeFromMenu({ ...activeMenu, nextUrl }));
    dispatch(fetchVacancies({}));
    navigate(`/${nextUrl}`);
  };
  return (
    <Card loading={loading}>
      <Row gutter={12}>
        <Col span={16}>
          <Descriptions column={1} bordered title={t('basic.info')}>
            <Descriptions.Item
              label={t('title')}
              children={data?.[`title[${defaultLang}]`]}
            />
            <Descriptions.Item
              label={t('description')}
              children={data?.[`description[${defaultLang}]`]}
            />
          </Descriptions>
          <br />
          <Descriptions column={1} bordered title={t('pricing')}>
            <Descriptions.Item
              label={t('price_from')}
              children={data?.price_from}
            />
            <Descriptions.Item
              label={t('price_to')}
              children={data?.price_to}
            />
            <Descriptions.Item
              label={t('price')}
              children={numberToPrice(
                data?.price,
                data?.currency?.symbol,
                data?.currency?.position,
              )}
            />
          </Descriptions>
        </Col>
        <Col span={8}>
          <Descriptions column={1} bordered title={t('organization')}>
            {!!data?.user && (
              <Descriptions.Item
                label={t('user')}
                children={`#${data?.user?.id}. ${data?.user?.firstname} ${data?.user?.lastname || ''}`}
              />
            )}
            <Descriptions.Item
              label={t('category')}
              children={data?.category?.translation?.title}
            />
            {!!data?.brand && (
              <Descriptions.Item
                label={t('brand')}
                children={data?.brand?.translation?.title}
              />
            )}
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
      </Row>
      <div className='d-flex justify-content-end mt-4'>
        <Space>
          <Button onClick={prev}>{t('prev')}</Button>
          <Button type='primary' onClick={finish}>
            {t('finish')}
          </Button>
        </Space>
      </div>
    </Card>
  );
};

export default Finish;
