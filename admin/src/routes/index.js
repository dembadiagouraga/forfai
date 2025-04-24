// ** admin routes **
import AppRoutes from './admin/app';
import BannerRoutes from './admin/banner';
import BlogRoutes from './admin/blog';
import BrandRoutes from './admin/brand';
import CareerCategoryRoutes from './admin/career-category';
import CareerRoutes from './admin/career';
import CategoryImport from './admin/category';
import CurrencyRoutes from './admin/currency';
import EmailProvidersRoutes from './admin/email-provider';
import FaqRoutes from './admin/faq';
import FoodRoutes from './admin/food';
import GalleryRoutes from './admin/gallery';
import LanguagesRoutes from './admin/language';
import MessageSubscriber from './admin/message-subscriber';
import NotificationRoutes from './admin/notification';
import PagesRoutes from './admin/pages';
import PaymentPayloadsRoutes from './admin/payment-payloads';
import SettingsRoutes from './admin/settings';
import SmsPayloads from './admin/sms-payloads';
import SubscriptionsRoutes from './admin/subscriptions';
import UsersRoutes from './admin/user';
import ReportRoutes from './admin/report';
import LandingPageRoutes from './admin/landing-page';
import Advert from './admin/advert';
import Deliveryzone from './admin/deliveryzone';
import StoryRoutes from './admin/stories';
import VacancyRoutes from './admin/vacancy';
import VacancyCategoryRoutes from './admin/vacancy-category';
import AttributeRoutes from './admin/attribute';

// ** Merge Routes
const AllRoutes = [
  ...AppRoutes,
  ...BannerRoutes,
  ...BlogRoutes,
  ...BrandRoutes,
  ...CareerCategoryRoutes,
  ...CareerRoutes,
  ...CategoryImport,
  ...CurrencyRoutes,
  ...EmailProvidersRoutes,
  ...FaqRoutes,
  ...FoodRoutes,
  ...GalleryRoutes,
  ...LanguagesRoutes,
  ...MessageSubscriber,
  ...NotificationRoutes,
  ...PagesRoutes,
  ...PaymentPayloadsRoutes,
  ...SettingsRoutes,
  ...SmsPayloads,
  ...SubscriptionsRoutes,
  ...UsersRoutes,
  ...ReportRoutes,
  ...LandingPageRoutes,
  ...Advert,
  ...Deliveryzone,
  ...StoryRoutes,
  ...VacancyRoutes,
  ...VacancyCategoryRoutes,
  ...AttributeRoutes,
];

export { AllRoutes };
