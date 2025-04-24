import { store } from 'redux/store';
import { DEFAULT_LANGUAGE } from 'configs/app-global';

export const getValueFromTranslations = (key, translations, locale) => {
  if (!Array.isArray(translations)) {
    return;
  }

  const defaultLang = store.getState().formLang.defaultLang || DEFAULT_LANGUAGE;

  return translations?.find(
    (translation) => translation?.locale === (locale || defaultLang),
  )?.[key];
};
