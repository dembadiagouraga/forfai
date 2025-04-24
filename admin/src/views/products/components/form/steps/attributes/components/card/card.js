import { lazy, Suspense } from 'react';
import { Card } from 'antd';
import Loading from 'components/loading';

const YesOrNo = lazy(() => import('./yes-or-no'));
const DropDown = lazy(() => import('./drop-down'));
const Checkbox = lazy(() => import('./checkbox'));
const Radio = lazy(() => import('./radio'));
const Input = lazy(() => import('./input'));
const FromTo = lazy(() => import('./from-to'));

const getAttributeCard = (data) => {
  switch (data?.type) {
    case 'yes_or_no':
      return <YesOrNo data={data} />;
    case 'drop_down':
      return <DropDown data={data} />;
    case 'checkbox':
      return <Checkbox data={data} />;
    case 'radio':
      return <Radio data={data} />;
    case 'input':
      return <Input data={data} />;
    case 'from_to':
      return <FromTo data={data} />;
    default:
      break;
  }
};

const AttributeCard = ({ data }) => {
  return (
    <Card style={{ borderColor: 'var(--anchor-before-bg)' }}>
      <Suspense fallback={<Loading />}>{getAttributeCard(data)}</Suspense>
    </Card>
  );
};

export default AttributeCard;
