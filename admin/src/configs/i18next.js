import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import Backend from 'i18next-http-backend';
import LanguageDetector from 'i18next-browser-languagedetector';
import { THEME_CONFIG } from './theme-config';

const resources = {
  en: {
    translation: '',
  },
};

i18n
  .use(initReactI18next)
  .use(Backend)
  .use(LanguageDetector)
  .init({
    resources,
    fallbackLng: THEME_CONFIG.locale,
    lng: localStorage.getItem('i18nextLng') || THEME_CONFIG.locale,
    ns: ['translation', 'errors'],
    defaultNS: 'translation',
    keySeparator: false,
    nsSeparator: false,
    interpolation: {
      escapeValue: false,
    },
    parseMissingKeyHandler: (key) => {
      // Convert keys with dots to spaces
      return key.replace(/\./g, ' ');
    },
  });

export default i18n;
