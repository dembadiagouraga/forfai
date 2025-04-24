import { useMemo } from 'react';
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
  const selectedRegion = Form.useWatch('region', form);
  const selectedCountry = Form.useWatch('country', form);
  const selectedCity = Form.useWatch('city', form);

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
        region_id: selectedRegion?.value,
      };
      return countryService
        .get(params)
        .then((res) => res?.data?.map((item) => createSelectObject(item)));
    },
    [selectedRegion],
  );

  const fetchCities = useMemo(
    () => async (search) => {
      const params = {
        search: search ? search : undefined,
        page: 1,
        perPage: 20,
        country_id: selectedCountry?.value,
      };
      return cityService
        .get(params)
        .then((res) => res?.data?.map((item) => createSelectObject(item)));
    },
    [selectedCountry],
  );

  const fetchAreas = useMemo(
    () => async (search) => {
      const params = {
        search: search ? search : undefined,
        page: 1,
        perPage: 20,
        city_id: selectedCity?.value,
      };
      return areaService
        .get(params)
        .then((res) => res?.data?.map((item) => createSelectObject(item)));
    },
    [selectedCity],
  );
  const onClear = (key) => {
    switch (key) {
      case 'region':
        form.setFieldsValue({
          region: null,
          country: null,
          city: null,
          area: null,
        });
        break;

      case 'country':
        form.setFieldsValue({
          country: null,
          city: null,
          area: null,
        });
        break;

      case 'city':
        form.setFieldsValue({
          city: null,
          area: null,
        });
        break;

      case 'area':
        form.setFieldsValue({
          area: null,
        });
        break;

      default:
        break;
    }
  };

  const onSelect = (key) => {
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
              onSelect={() => onSelect('region')}
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
              onSelect={() => onSelect('country')}
              onClear={() => onClear('country')}
              refetchOptions={true}
              disabled={!selectedRegion}
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
              onSelect={() => onSelect('city')}
              onClear={() => onClear('city')}
              disabled={!selectedCountry}
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
              onSelect={() => onSelect('area')}
              onClear={() => onClear('area')}
              disabled={!selectedCity}
              refetchOptions={true}
            />
          </Form.Item>
        </Col>
      </Row>
    </Card>
  );
};

export default Location;
