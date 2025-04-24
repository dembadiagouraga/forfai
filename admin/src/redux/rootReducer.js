import formLang from './slices/formLang';
import menu from './slices/menu';
import category from './slices/category';
import brand from './slices/brand';
import banner from './slices/banner';
import product from './slices/product';
import vacancy from './slices/vacancy';
import vacancyCategory from './slices/vacancyCategory';
import currency from './slices/currency';
import blog from './slices/blog';
import notification from './slices/notification';
import user from './slices/user';
import payment from './slices/payment';
import faq from './slices/faq';
import transaction from './slices/transaction';
import auth from './slices/auth';
import backup from './slices/backup';
import globalSettings from './slices/globalSettings';
import chat from './slices/chat';
import wallet from './slices/wallet';
import payoutRequests from './slices/payoutRequests';
import theme from './slices/theme';
import role from './slices/role';
import languages from './slices/languages';
import subscriber from './slices/subscriber';
import messageSubscriber from './slices/messegeSubscriber';
import storeis from './slices/storeis';
import emailProvider from './slices/emailProvider';
import adminPayouts from './slices/adminPayouts';
import todo from './slices/todo';
import paymentPayload from './slices/paymentPayload';
import sms from './slices/sms-geteways';
import careerCategory from './slices/career-category';
import career from './slices/career';
import pages from './slices/pages';
import landingPage from './slices/landing-page';
import advert from './slices/advert';
import gallery from './slices/gallery';
import attributes from './slices/attributes';
import report from './slices/report';
import dashboard from './slices/dashboard';

//deliveryzone
import deliveryCountries from './slices/deliveryzone/country';
import deliveryCity from './slices/deliveryzone/city';
import deliveryRegion from './slices/deliveryzone/region';
import deliveryArea from './slices/deliveryzone/area';

const rootReducer = {
  deliveryCountries,
  deliveryRegion,
  deliveryCity,
  deliveryArea,
  pages,
  career,
  careerCategory,
  sms,
  emailProvider,
  storeis,
  messageSubscriber,
  subscriber,
  languages,
  menu,
  formLang,
  category,
  brand,
  banner,
  product,
  vacancy,
  vacancyCategory,
  currency,
  blog,
  notification,
  user,
  payment,
  faq,
  transaction,
  auth,
  backup,
  globalSettings,
  chat,
  wallet,
  payoutRequests,
  theme,
  role,
  adminPayouts,
  todo,
  paymentPayload,
  landingPage,
  advert,
  gallery,
  attributes,
  report,
  dashboard,
};

export default rootReducer;
