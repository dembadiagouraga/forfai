import { shallowEqual, useSelector } from 'react-redux';
import { Col, Row } from 'antd';
import { useTranslation } from 'react-i18next';
import ChartWidget from 'components/chart-widget';
import { useMemo } from 'react';
import Loading from 'components/loading';
import StatisticNumberWidget from '../number-widget';

const Statistics = () => {
  const { t } = useTranslation();
  const { data, loading } = useSelector(
    (state) => state.dashboard.statistics,
    shallowEqual,
  );

  const chartSeries = useMemo(
    () => [
      {
        name: t('feedback.count'),
        data: data?.chart?.map((item) => item?.count) || [],
      },
      {
        name: t('helpful'),
        data: data?.chart?.map((item) => Number(item?.helpful)) || [],
      },
      {
        name: t('not.helpful'),
        data: data?.chart?.map((item) => Number(item?.not_helpful)) || [],
      },
    ],
    // eslint-disable-next-line
    [data.chart],
  );

  const chartXAxis = useMemo(() => {
    return data?.chart?.map((item) => item?.time);
  }, [data.chart]);

  if (loading) {
    return <Loading />;
  }

  return (
    <Row gutter={16}>
      <Col flex='1 1 0'>
        <StatisticNumberWidget
          title={t('feedback.count')}
          value={data?.count}
          color='red'
        />
      </Col>
      <Col flex='1 1 0'>
        <StatisticNumberWidget
          title={t('helpful')}
          value={data?.helpful}
          color='grey'
        />
      </Col>
      <Col flex='1 1 0'>
        <StatisticNumberWidget
          title={t('not.helpful')}
          value={data?.not_helpful}
        />
      </Col>
      <Col flex='1 1 0'>
        <StatisticNumberWidget
          title={t('products.count')}
          value={data?.products_count}
          color='grey'
        />
      </Col>
      {/*<Col flex='1 1 0'>*/}
      {/*  <StatisticNumberWidget*/}
      {/*    title={t('reviews_count')}*/}
      {/*    value={data?.reviews_count}*/}
      {/*    color='red'*/}
      {/*  />*/}
      {/*</Col>*/}
      <Col span={24}>
        <ChartWidget height={280} series={chartSeries} xAxis={chartXAxis} />
      </Col>
    </Row>
  );
};

export default Statistics;
