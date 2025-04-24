import {
  Button,
  Col,
  DatePicker,
  Form,
  Input,
  InputNumber,
  Row,
  Select,
} from 'antd';
import moment from 'moment/moment';
import { USER_GENDERS } from 'constants/index';
import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import { removeFromMenu, setRefetch } from 'redux/slices/menu';
import { useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';
import MediaUpload from 'components/upload';
import { setParams } from 'redux/slices/user';
import createImage from 'helpers/createImage';

const BasicInfo = ({
  isEdit = true,
  handleSubmit,
  role,
  navigateToList = false,
}) => {
  const { t } = useTranslation();
  const [form] = Form.useForm();
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const { activeMenu } = useSelector((state) => state.menu, shallowEqual);
  const { data } = useSelector((state) => state.user.userDetails, shallowEqual);

  const [loadingBtn, setLoadingBtn] = useState(false);
  const [avatar, setAvatar] = useState([]);

  const onFinish = (values) => {
    setLoadingBtn(true);
    const body = {
      images: avatar?.map((item) => item?.name),
      firstname: values?.firstname,
      lastname: values?.lastname,
      email: values?.email,
      phone: values?.phone,
      birthday: moment(values?.birthday).format('YYYY-MM-DD'),
      gender: values?.gender,
      password: values?.password || undefined,
      password_confirmation: values?.password_confirmation || undefined,
    };
    handleSubmit(body)
      .then(() => {
        if (navigateToList) {
          const url = 'users/admin';
          batch(() => {
            dispatch(removeFromMenu({ ...activeMenu, nextUrl: url }));
            if (role) {
              dispatch(setParams({ role }));
            }
          });
          navigate(`/${url}`);
          toast.success(t('user.added'));
        } else {
          toast.success(t('successfully.updated'));
          dispatch(setRefetch(activeMenu));
        }
      })
      .finally(() => setLoadingBtn(false));
  };

  useEffect(() => {
    if (isEdit && data) {
      if (data?.img) {
        setAvatar([createImage(data?.img)]);
      }
      form.setFieldsValue({
        firstname: data?.firstname,
        lastname: data?.lastname,
        birthday: moment(data?.birthday),
        gender: data?.gender,
        phone: data?.phone,
        email: data?.email,
      });
    }
    return () => {};
    // eslint-disable-next-line
  }, [data, isEdit]);

  return (
    <Form
      form={form}
      layout='vertical'
      onFinish={onFinish}
      initialValues={{
        gender: USER_GENDERS[0],
      }}
    >
      <Row gutter={12}>
        <Col span={24}>
          <Form.Item
            name='images'
            label={t('avatar')}
            rules={[
              {
                required: !avatar?.length,
                message: t('required'),
              },
            ]}
          >
            <MediaUpload
              type='users'
              imageList={avatar}
              setImageList={setAvatar}
              form={form}
              multiple={false}
            />
          </Form.Item>
        </Col>
        <Col span={12}>
          <Form.Item
            name='firstname'
            label={t('firstname')}
            rules={[
              {
                required: true,
                message: t('required'),
              },
              {
                type: 'string',
                min: 2,
                max: 200,
                message: t('min.2.max.200.chars'),
              },
            ]}
          >
            <Input />
          </Form.Item>
        </Col>
        <Col span={12}>
          <Form.Item
            name='lastname'
            label={t('lastname')}
            rules={[
              {
                required: true,
                message: t('required'),
              },
              {
                type: 'string',
                min: 2,
                max: 200,
                message: t('min.2.max.200.chars'),
              },
            ]}
          >
            <Input />
          </Form.Item>
        </Col>
        <Col span={12}>
          <Form.Item
            name='birthday'
            label={t('birthday')}
            rules={[
              {
                required: true,
                message: t('required'),
              },
            ]}
          >
            <DatePicker
              className='w-100'
              disabledDate={(current) => moment().add(-18, 'years') <= current}
              defaultPickerValue={moment().add(-18, 'years')}
              placeholder=' '
            />
          </Form.Item>
        </Col>
        <Col span={12}>
          <Form.Item
            name='gender'
            label={t('gender')}
            rules={[
              {
                required: true,
                message: t('required'),
              },
            ]}
          >
            <Select
              options={USER_GENDERS.map((gender) => ({
                label: t(gender),
                value: gender,
                key: gender,
              }))}
            />
          </Form.Item>
        </Col>
        <Col span={12}>
          <Form.Item
            name='phone'
            label={t('phone')}
            rules={[{ required: true, message: t('required') }]}
          >
            <InputNumber className='w-100' min={0} />
          </Form.Item>
        </Col>
        <Col span={12}>
          <Form.Item
            name='email'
            label={t('email')}
            rules={[
              { required: true, message: t('required') },
              {
                type: 'email',
                message: t('invalid.email'),
              },
            ]}
          >
            <Input />
          </Form.Item>
        </Col>
        {!isEdit && (
          <>
            <Col span={12}>
              <Form.Item
                label={t('password')}
                name='password'
                rules={[
                  { required: true, message: t('required') },
                  {
                    validator(_, value) {
                      if (value && value?.length < 6) {
                        return Promise.reject(new Error(t('min.6.letters')));
                      }
                      return Promise.resolve();
                    },
                  },
                ]}
                normalize={(value) =>
                  value?.trim() === '' ? value?.trim() : value
                }
              >
                <Input.Password
                  type='password'
                  className='w-100'
                  maxLength={20}
                />
              </Form.Item>
            </Col>
            <Col span={12}>
              <Form.Item
                label={t('password.confirmation')}
                name='password_confirmation'
                dependencies={['password']}
                hasFeedback
                rules={[
                  {
                    required: true,
                    message: t('required'),
                  },
                  ({ getFieldValue }) => ({
                    validator(rule, value) {
                      if (!value || getFieldValue('password') === value) {
                        return Promise.resolve();
                      }
                      return Promise.reject(t('two.passwords.dont.match'));
                    },
                  }),
                ]}
                normalize={(value) =>
                  value?.trim() === '' ? value?.trim() : value
                }
              >
                <Input.Password type='password' />
              </Form.Item>
            </Col>
          </>
        )}
      </Row>
      <Button type='primary' htmlType='submit' loading={loadingBtn}>
        {t('submit')}
      </Button>
    </Form>
  );
};

export default BasicInfo;
