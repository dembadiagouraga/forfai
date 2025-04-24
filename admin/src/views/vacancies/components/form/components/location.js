import { useMemo, useState } from 'react';
import { Card, Col, Form, Row } from 'antd';
import { useTranslation } from 'react-i18next';
import { DebounceSelect } from 'components/search';
import regionService from 'services/deliveryzone/region';
import countryService from 'services/deliveryzone/country';
import cityService from 'services/deliveryzone/city';
import areaService from 'services/deliveryzone/area';
import createSelectObject from 'helpers/createSelectObject';

const Location = ({ loading, form }) => {
  const { t } = useTranslation();
  const [location, setLocation] = useState({
    region: null,
    country: null,
    city: null,
    area: null,
  });

  const fetchRegions = useMemo(
    () => async (search) => {
      const params = {
        search: search ? search : undefined,
        page: 1,
        perPage: 20,
      };
      return regionService
        .get(params)
        .then((res) => res?.data?.map((item) => createSelectObject(item)));
    },
    [],
  );

  const fetchCountries = useMemo(
    () => async (search) => {
      const params = {
        search: search ? search : undefined,
        page: 1,
        perPage: 20,
        region_id: location.region?.value,
      };
      return countryService
        .get(params)
        .then((res) => res?.data?.map((item) => createSelectObject(item)));
    },
    [location.region],
  );

  const fetchCities = useMemo(
    () => async (search) => {
      const params = {
        search: search ? search : undefined,
        page: 1,
        perPage: 20,
        country_id: location.country?.value,
      };
      return cityService
        .get(params)
        .then((res) => res?.data?.map((item) => createSelectObject(item)));
    },
    [location.country],
  );

  const fetchAreas = useMemo(
    () => async (search) => {
      const params = {
        search: search ? search : undefined,
        page: 1,
        perPage: 20,
        city_id: location.city?.value,
      };
      return areaService
        .get(params)
        .then((res) => res?.data?.map((item) => createSelectObject(item)));
    },
    [location.city],
  );
  const onClear = (key) => {
    switch (key) {
      case 'region':
        setLocation({
          region: null,
          country: null,
          city: null,
          area: null,
        });
        form.setFieldsValue({
          region: null,
          country: null,
          city: null,
          area: null,
        });
        break;

      case 'country':
        setLocation({
          ...location,
          country: null,
          city: null,
          area: null,
        });
        form.setFieldsValue({
          country: null,
          city: null,
          area: null,
        });
        break;

      case 'city':
        setLocation({
          ...location,
          city: null,
          area: null,
        });
        form.setFieldsValue({
          city: null,
          area: null,
        });
        break;

      case 'area':
        setLocation({
          ...location,
          area: null,
        });
        form.setFieldsValue({
          area: null,
        });
        break;

      default:
        break;
    }
  };

  const onSelect = (key, value) => {
    switch (key) {
      case 'region':
        onClear('country');
        break;
      case 'country':
        onClear('city');
        break;
      case 'city':
        onClear('area');
        break;
      default:
        break;
    }
    setLocation((prev) => ({
      ...prev,
      [key]: value,
    }));
  };

  return (
    <Card title={t('location')} loading={loading}>
      <Row gutter={12}>
        <Col span={24}>
          <Form.Item
            label={t('region')}
            name='region'
            rules={[
              {
                required: true,
                message: t('required'),
              },
            ]}
          >
            <DebounceSelect
              fetchOptions={fetchRegions}
              onSelect={(value) => onSelect('region', value)}
              onClear={() => onClear('region')}
            />
          </Form.Item>
        </Col>
        <Col span={24}>
          <Form.Item
            label={t('country')}
            name='country'
            rules={[
              {
                required: true,
                message: t('required'),
              },
            ]}
          >
            <DebounceSelect
              fetchOptions={fetchCountries}
              onSelect={(value) => onSelect('country', value)}
              onClear={() => onClear('country')}
              refetchOptions={true}
              disabled={!location.region}
            />
          </Form.Item>
        </Col>
        <Col span={24}>
          <Form.Item
            label={t('city')}
            name='city'
            rules={[
              {
                required: true,
                message: t('required'),
              },
            ]}
          >
            <DebounceSelect
              fetchOptions={fetchCities}
              onSelect={(value) => onSelect('city', value)}
              onClear={() => onClear('city')}
              disabled={!location.country}
              refetchOptions={true}
            />
          </Form.Item>
        </Col>
        <Col span={24}>
          <Form.Item
            label={t('area')}
            name='area'
            rules={[
              {
                required: false,
                message: t('required'),
              },
            ]}
          >
            <DebounceSelect
              fetchOptions={fetchAreas}
              onSelect={(value) => onSelect('area', value)}
              onClear={() => onClear('area')}
              disabled={!location.city}
              refetchOptions={true}
            />
          </Form.Item>
        </Col>
      </Row>
    </Card>
  );
};

export default Location;
