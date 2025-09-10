# 🌍 **Internationalization**

> **Master internationalization (i18n), localization (l10n), and multi-language support for React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Internationalization Overview](#-internationalization-overview)
- [i18n Implementation](#-i18n-implementation)
- [Localization Strategies](#-localization-strategies)
- [RTL Support](#-rtl-support)
- [Date & Number Formatting](#-date--number-formatting)
- [Best Practices](#-best-practices)
- [Interview Questions](#-interview-questions)

---

## 🏗️ **Internationalization Overview**

### **i18n Architecture**


{% raw %}
```mermaid
graph TD
    A[App Content] --> B[Translation Keys]
    B --> C[Locale Files]
    C --> D[Language Selection]
    D --> E[Localized Content]
    
    F[Date/Time] --> G[Locale Formatting]
    G --> E
    H[Numbers] --> G
    I[Currency] --> G
```
{% endraw %}


### **Key Concepts**
- **i18n**: Internationalization (preparing app for multiple languages)
- **l10n**: Localization (adapting content for specific regions)
- **Locale**: Language and region combination (e.g., en-US, fr-CA)
- **RTL**: Right-to-left text direction (Arabic, Hebrew)

---

## 🌐 **i18n Implementation**

### **Basic i18n Setup**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import React, { useState, useEffect } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, I18nManager } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';

// Translation files
const translations = {
  en: {
    welcome: 'Welcome',
    hello: 'Hello',
    goodbye: 'Goodbye',
    settings: 'Settings',
    language: 'Language',
    selectLanguage: 'Select Language',
    currentLanguage: 'Current Language: English',
    changeLanguage: 'Change Language',
    confirm: 'Confirm',
    cancel: 'Cancel',
  },
  es: {
    welcome: 'Bienvenido',
    hello: 'Hola',
    goodbye: 'Adiós',
    settings: 'Configuración',
    language: 'Idioma',
    selectLanguage: 'Seleccionar Idioma',
    currentLanguage: 'Idioma Actual: Español',
    changeLanguage: 'Cambiar Idioma',
    confirm: 'Confirmar',
    cancel: 'Cancelar',
  },
  fr: {
    welcome: 'Bienvenue',
    hello: 'Bonjour',
    goodbye: 'Au revoir',
    settings: 'Paramètres',
    language: 'Langue',
    selectLanguage: 'Sélectionner la Langue',
    currentLanguage: 'Langue Actuelle: Français',
    changeLanguage: 'Changer de Langue',
    confirm: 'Confirmer',
    cancel: 'Annuler',
  },
  ar: {
    welcome: 'مرحباً',
    hello: 'مرحبا',
    goodbye: 'وداعاً',
    settings: 'الإعدادات',
    language: 'اللغة',
    selectLanguage: 'اختر اللغة',
    currentLanguage: 'اللغة الحالية: العربية',
    changeLanguage: 'تغيير اللغة',
    confirm: 'تأكيد',
    cancel: 'إلغاء',
  },
};

// i18n service
const createI18nService = () => {
  let currentLocale = 'en';
  let translations = {};

  return {
    // Initialize i18n
    initialize: async () => {
      try {
        // Load saved locale
        const savedLocale = await AsyncStorage.getItem('app_locale');
        if (savedLocale && translations[savedLocale]) {
          currentLocale = savedLocale;
        } else {
          // Use device locale
          const deviceLocale = getDeviceLocale();
          currentLocale = translations[deviceLocale] ? deviceLocale : 'en';
        }

        // Set RTL if needed
        const isRTL = isRTLLanguage(currentLocale);
        if (I18nManager.isRTL !== isRTL) {
          I18nManager.allowRTL(isRTL);
          I18nManager.forceRTL(isRTL);
        }

        return currentLocale;
      } catch (error) {
        console.error('Error initializing i18n:', error);
        return 'en';
      }
    },

    // Set locale
    setLocale: async (locale) => {
      try {
        if (translations[locale]) {
          currentLocale = locale;
          await AsyncStorage.setItem('app_locale', locale);

          // Update RTL if needed
          const isRTL = isRTLLanguage(locale);
          if (I18nManager.isRTL !== isRTL) {
            I18nManager.allowRTL(isRTL);
            I18nManager.forceRTL(isRTL);
          }

          return true;
        }
        return false;
      } catch (error) {
        console.error('Error setting locale:', error);
        return false;
      }
    },

    // Get current locale
    getCurrentLocale: () => currentLocale,

    // Translate text
    t: (key, params = {}) => {
      const translation = translations[currentLocale]?.[key] || key;
      return interpolateTranslation(translation, params);
    },

    // Get available locales
    getAvailableLocales: () => Object.keys(translations),

    // Check if locale is RTL
    isRTL: () => isRTLLanguage(currentLocale),
  };
};

// Get device locale
const getDeviceLocale = () => {
  const locale = require('react-native-localize').getLocales()[0];
  return locale.languageCode;
};

// Check if language is RTL
const isRTLLanguage = (locale) => {
  const rtlLanguages = ['ar', 'he', 'fa', 'ur'];
  return rtlLanguages.includes(locale);
};

// Interpolate translation with parameters
const interpolateTranslation = (translation, params) => {
  let result = translation;
  Object.keys(params).forEach(key => {
    result = result.replace(`{{#123;{{#123;${key}}#125;}}#125;}`, params[key]);
  });
  return result;
};

// Export i18n service
export { createI18nService, translations };
```
{% endraw %}


### **i18n Hook Implementation**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import React, { createContext, useContext, useState, useEffect } from 'react';
import { createI18nService } from './i18nService';

// i18n Context
const I18nContext = createContext();

// i18n Provider
const I18nProvider = ({ children }) => {
  const [i18n, setI18n] = useState(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const initializeI18n = async () => {
      try {
        const i18nService = createI18nService();
        await i18nService.initialize();
        setI18n(i18nService);
      } catch (error) {
        console.error('Error initializing i18n:', error);
      } finally {
        setIsLoading(false);
      }
    };

    initializeI18n();
  }, []);

  const changeLocale = async (locale) => {
    if (i18n) {
      const success = await i18n.setLocale(locale);
      if (success) {
        // Force re-render by updating the service
        setI18n({ ...i18n });
      }
      return success;
    }
    return false;
  };

  const value = {
    i18n,
    isLoading,
    changeLocale,
    t: i18n?.t || ((key) => key),
    currentLocale: i18n?.getCurrentLocale() || 'en',
    availableLocales: i18n?.getAvailableLocales() || [],
    isRTL: i18n?.isRTL() || false,
  };

  return (
    <I18nContext.Provider value={value}>
      {children}
    </I18nContext.Provider>
  );
};

// useI18n hook
const useI18n = () => {
  const context = useContext(I18nContext);
  if (!context) {
    throw new Error('useI18n must be used within an I18nProvider');
  }
  return context;
};

// Export context and hook
export { I18nProvider, useI18n };
```
{% endraw %}


### **i18n Component Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import React, { useState } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Modal } from 'react-native';
import { useI18n } from './i18nHook';

const LanguageSelector = () => {
  const { t, currentLocale, availableLocales, changeLocale, isRTL } = useI18n();
  const [showModal, setShowModal] = useState(false);

  const handleLanguageChange = async (locale) => {
    const success = await changeLocale(locale);
    if (success) {
      setShowModal(false);
    }
  };

  const getLanguageName = (locale) => {
    const languageNames = {
      en: 'English',
      es: 'Español',
      fr: 'Français',
      ar: 'العربية',
    };
    return languageNames[locale] || locale;
  };

  return (
    <View style={styles.container}>
      <TouchableOpacity
        style={styles.languageButton}
        onPress={() => setShowModal(true)}
        accessible={true}
        accessibilityRole="button"
        accessibilityLabel={t('selectLanguage')}
      >
        <Text style={styles.languageButtonText}>
          {t('currentLanguage')}
        </Text>
      </TouchableOpacity>

      <Modal
        visible={showModal}
        transparent={true}
        animationType="slide"
        onRequestClose={() => setShowModal(false)}
      >
        <View style={styles.modalOverlay}>
          <View style={styles.modal}>
            <Text 
              style={styles.modalTitle}
              accessible={true}
              accessibilityRole="header"
            >
              {t('selectLanguage')}
            </Text>

            {availableLocales.map((locale) => (
              <TouchableOpacity
                key={locale}
                style={[
                  styles.languageOption,
                  currentLocale === locale && styles.selectedOption
                ]}
                onPress={() => handleLanguageChange(locale)}
                accessible={true}
                accessibilityRole="button"
                accessibilityLabel={`${t('selectLanguage')}: ${getLanguageName(locale)}`}
                accessibilityState={{#123;{{#123; selected: currentLocale === locale }}#125;}}#125;
              >
                <Text style={[
                  styles.languageOptionText,
                  currentLocale === locale && styles.selectedOptionText
                ]}>
                  {getLanguageName(locale)}
                </Text>
              </TouchableOpacity>
            ))}

            <TouchableOpacity
              style={styles.cancelButton}
              onPress={() => setShowModal(false)}
              accessible={true}
              accessibilityRole="button"
              accessibilityLabel={t('cancel')}
            >
              <Text style={styles.cancelButtonText}>
                {t('cancel')}
              </Text>
            </TouchableOpacity>
          </View>
        </View>
      </Modal>
    </View>
  );
};

const InternationalizationExample = () => {
  const { t, currentLocale, isRTL } = useI18n();

  return (
    <View style={[styles.container, isRTL && styles.rtlContainer]}>
      <Text 
        style={[styles.title, isRTL && styles.rtlText]}
        accessible={true}
        accessibilityRole="header"
      >
        {t('welcome')}
      </Text>

      <Text 
        style={[styles.subtitle, isRTL && styles.rtlText]}
        accessible={true}
        accessibilityRole="text"
      >
        {t('hello')}
      </Text>

      <LanguageSelector />

      <View style={styles.infoContainer}>
        <Text 
          style={[styles.infoText, isRTL && styles.rtlText]}
          accessible={true}
          accessibilityRole="text"
        >
          Current Locale: {currentLocale}
        </Text>
        <Text 
          style={[styles.infoText, isRTL && styles.rtlText]}
          accessible={true}
          accessibilityRole="text"
        >
          RTL: {isRTL ? 'Yes' : 'No'}
        </Text>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
  },
  rtlContainer: {
    direction: 'rtl',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
    color: '#333',
    textAlign: 'left',
  },
  rtlText: {
    textAlign: 'right',
  },
  subtitle: {
    fontSize: 18,
    marginBottom: 30,
    color: '#666',
    textAlign: 'left',
  },
  languageButton: {
    backgroundColor: '#007bff',
    padding: 15,
    borderRadius: 5,
    marginBottom: 20,
  },
  languageButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  modal: {
    backgroundColor: '#fff',
    borderRadius: 10,
    padding: 20,
    margin: 20,
    minWidth: 300,
  },
  modalTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 20,
    color: '#333',
    textAlign: 'center',
  },
  languageOption: {
    padding: 15,
    borderBottomWidth: 1,
    borderBottomColor: '#e9ecef',
  },
  selectedOption: {
    backgroundColor: '#e3f2fd',
  },
  languageOptionText: {
    fontSize: 16,
    color: '#333',
  },
  selectedOptionText: {
    fontWeight: 'bold',
    color: '#007bff',
  },
  cancelButton: {
    backgroundColor: '#6c757d',
    padding: 15,
    borderRadius: 5,
    marginTop: 20,
  },
  cancelButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  infoContainer: {
    marginTop: 30,
    padding: 15,
    backgroundColor: '#f8f9fa',
    borderRadius: 5,
  },
  infoText: {
    fontSize: 14,
    color: '#495057',
    marginBottom: 5,
    textAlign: 'left',
  },
});

export default InternationalizationExample;
```
{% endraw %}


---

## 🔄 **RTL Support**

### **RTL Layout Implementation**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import React from 'react';
import { View, Text, StyleSheet, I18nManager } from 'react-native';

const RTLSupportExample = () => {
  const isRTL = I18nManager.isRTL;

  return (
    <View style={[styles.container, isRTL && styles.rtlContainer]}>
      <Text 
        style={[styles.title, isRTL && styles.rtlText]}
        accessible={true}
        accessibilityRole="header"
      >
        RTL Support Demo
      </Text>

      <View style={[styles.card, isRTL && styles.rtlCard]}>
        <View style={[styles.cardHeader, isRTL && styles.rtlCardHeader]}>
          <Text 
            style={[styles.cardTitle, isRTL && styles.rtlText]}
            accessible={true}
            accessibilityRole="header"
          >
            Card Title
          </Text>
          <Text 
            style={[styles.cardSubtitle, isRTL && styles.rtlText]}
            accessible={true}
            accessibilityRole="text"
          >
            Card Subtitle
          </Text>
        </View>

        <View style={[styles.cardContent, isRTL && styles.rtlCardContent]}>
          <Text 
            style={[styles.cardText, isRTL && styles.rtlText]}
            accessible={true}
            accessibilityRole="text"
          >
            This is a sample card content that demonstrates RTL support.
            The text direction and layout should adapt based on the current language.
          </Text>
        </View>

        <View style={[styles.cardActions, isRTL && styles.rtlCardActions]}>
          <View style={[styles.actionButton, isRTL && styles.rtlActionButton]}>
            <Text 
              style={[styles.actionButtonText, isRTL && styles.rtlText]}
              accessible={true}
              accessibilityRole="button"
            >
              Action 1
            </Text>
          </View>
          <View style={[styles.actionButton, isRTL && styles.rtlActionButton]}>
            <Text 
              style={[styles.actionButtonText, isRTL && styles.rtlText]}
              accessible={true}
              accessibilityRole="button"
            >
              Action 2
            </Text>
          </View>
        </View>
      </View>

      <View style={[styles.list, isRTL && styles.rtlList]}>
        <View style={[styles.listItem, isRTL && styles.rtlListItem]}>
          <View style={[styles.listItemIcon, isRTL && styles.rtlListItemIcon]}>
            <Text style={styles.iconText}>📱</Text>
          </View>
          <View style={[styles.listItemContent, isRTL && styles.rtlListItemContent]}>
            <Text 
              style={[styles.listItemTitle, isRTL && styles.rtlText]}
              accessible={true}
              accessibilityRole="text"
            >
              Mobile App
            </Text>
            <Text 
              style={[styles.listItemDescription, isRTL && styles.rtlText]}
              accessible={true}
              accessibilityRole="text"
            >
              React Native application with RTL support
            </Text>
          </View>
        </View>

        <View style={[styles.listItem, isRTL && styles.rtlListItem]}>
          <View style={[styles.listItemIcon, isRTL && styles.rtlListItemIcon]}>
            <Text style={styles.iconText}>🌍</Text>
          </View>
          <View style={[styles.listItemContent, isRTL && styles.rtlListItemContent]}>
            <Text 
              style={[styles.listItemTitle, isRTL && styles.rtlText]}
              accessible={true}
              accessibilityRole="text"
            >
              Internationalization
            </Text>
            <Text 
              style={[styles.listItemDescription, isRTL && styles.rtlText]}
              accessible={true}
              accessibilityRole="text"
            >
              Multi-language support with proper RTL layout
            </Text>
          </View>
        </View>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
  },
  rtlContainer: {
    direction: 'rtl',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
    color: '#333',
    textAlign: 'left',
  },
  rtlText: {
    textAlign: 'right',
  },
  card: {
    backgroundColor: '#f8f9fa',
    borderRadius: 10,
    padding: 20,
    marginBottom: 20,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  rtlCard: {
    direction: 'rtl',
  },
  cardHeader: {
    marginBottom: 15,
  },
  rtlCardHeader: {
    direction: 'rtl',
  },
  cardTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 5,
    textAlign: 'left',
  },
  cardSubtitle: {
    fontSize: 14,
    color: '#666',
    textAlign: 'left',
  },
  cardContent: {
    marginBottom: 15,
  },
  rtlCardContent: {
    direction: 'rtl',
  },
  cardText: {
    fontSize: 16,
    color: '#333',
    lineHeight: 24,
    textAlign: 'left',
  },
  cardActions: {
    flexDirection: 'row',
    justifyContent: 'flex-end',
  },
  rtlCardActions: {
    flexDirection: 'row-reverse',
    justifyContent: 'flex-start',
  },
  actionButton: {
    backgroundColor: '#007bff',
    paddingHorizontal: 15,
    paddingVertical: 8,
    borderRadius: 5,
    marginLeft: 10,
  },
  rtlActionButton: {
    marginLeft: 0,
    marginRight: 10,
  },
  actionButtonText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  list: {
    marginTop: 20,
  },
  rtlList: {
    direction: 'rtl',
  },
  listItem: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 15,
    borderBottomWidth: 1,
    borderBottomColor: '#e9ecef',
  },
  rtlListItem: {
    flexDirection: 'row-reverse',
  },
  listItemIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#e3f2fd',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 15,
  },
  rtlListItemIcon: {
    marginRight: 0,
    marginLeft: 15,
  },
  iconText: {
    fontSize: 20,
  },
  listItemContent: {
    flex: 1,
  },
  rtlListItemContent: {
    direction: 'rtl',
  },
  listItemTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 5,
    textAlign: 'left',
  },
  listItemDescription: {
    fontSize: 14,
    color: '#666',
    textAlign: 'left',
  },
});

export default RTLSupportExample;
```
{% endraw %}


---

## 📅 **Date & Number Formatting**

### **Locale-Aware Formatting**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { useI18n } from './i18nHook';

const LocaleFormattingExample = () => {
  const { currentLocale, t } = useI18n();
  const [currentDate, setCurrentDate] = useState(new Date());
  const [currentTime, setCurrentTime] = useState(new Date());

  useEffect(() => {
    const timer = setInterval(() => {
      const now = new Date();
      setCurrentDate(now);
      setCurrentTime(now);
    }, 1000);

    return () => clearInterval(timer);
  }, []);

  // Format date based on locale
  const formatDate = (date, locale) => {
    const options = {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      weekday: 'long',
    };

    return new Intl.DateTimeFormat(locale, options).format(date);
  };

  // Format time based on locale
  const formatTime = (date, locale) => {
    const options = {
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
      hour12: locale === 'en' ? true : false,
    };

    return new Intl.DateTimeFormat(locale, options).format(date);
  };

  // Format number based on locale
  const formatNumber = (number, locale) => {
    return new Intl.NumberFormat(locale).format(number);
  };

  // Format currency based on locale
  const formatCurrency = (amount, locale) => {
    const currencyCodes = {
      en: 'USD',
      es: 'EUR',
      fr: 'EUR',
      ar: 'SAR',
    };

    const currency = currencyCodes[locale] || 'USD';
    return new Intl.NumberFormat(locale, {
      style: 'currency',
      currency: currency,
    }).format(amount);
  };

  // Format percentage based on locale
  const formatPercentage = (value, locale) => {
    return new Intl.NumberFormat(locale, {
      style: 'percent',
      minimumFractionDigits: 2,
    }).format(value);
  };

  // Format relative time
  const formatRelativeTime = (date, locale) => {
    const now = new Date();
    const diffInSeconds = Math.floor((now - date) / 1000);

    if (diffInSeconds < 60) {
      return new Intl.RelativeTimeFormat(locale, { numeric: 'auto' })
        .format(-diffInSeconds, 'second');
    } else if (diffInSeconds < 3600) {
      const diffInMinutes = Math.floor(diffInSeconds / 60);
      return new Intl.RelativeTimeFormat(locale, { numeric: 'auto' })
        .format(-diffInMinutes, 'minute');
    } else if (diffInSeconds < 86400) {
      const diffInHours = Math.floor(diffInSeconds / 3600);
      return new Intl.RelativeTimeFormat(locale, { numeric: 'auto' })
        .format(-diffInHours, 'hour');
    } else {
      const diffInDays = Math.floor(diffInSeconds / 86400);
      return new Intl.RelativeTimeFormat(locale, { numeric: 'auto' })
        .format(-diffInDays, 'day');
    }
  };

  const sampleData = {
    number: 1234567.89,
    currency: 99.99,
    percentage: 0.1234,
    relativeDate: new Date(Date.now() - 2 * 60 * 60 * 1000), // 2 hours ago
  };

  return (
    <View style={styles.container}>
      <Text 
        style={styles.title}
        accessible={true}
        accessibilityRole="header"
      >
        Locale Formatting Demo
      </Text>

      <View style={styles.section}>
        <Text 
          style={styles.sectionTitle}
          accessible={true}
          accessibilityRole="header"
        >
          Current Locale: {currentLocale}
        </Text>
      </View>

      <View style={styles.section}>
        <Text 
          style={styles.sectionTitle}
          accessible={true}
          accessibilityRole="header"
        >
          Date & Time
        </Text>
        
        <View style={styles.formatItem}>
          <Text style={styles.formatLabel}>Full Date:</Text>
          <Text 
            style={styles.formatValue}
            accessible={true}
            accessibilityRole="text"
          >
            {formatDate(currentDate, currentLocale)}
          </Text>
        </View>

        <View style={styles.formatItem}>
          <Text style={styles.formatLabel}>Time:</Text>
          <Text 
            style={styles.formatValue}
            accessible={true}
            accessibilityRole="text"
          >
            {formatTime(currentTime, currentLocale)}
          </Text>
        </View>

        <View style={styles.formatItem}>
          <Text style={styles.formatLabel}>Relative Time:</Text>
          <Text 
            style={styles.formatValue}
            accessible={true}
            accessibilityRole="text"
          >
            {formatRelativeTime(sampleData.relativeDate, currentLocale)}
          </Text>
        </View>
      </View>

      <View style={styles.section}>
        <Text 
          style={styles.sectionTitle}
          accessible={true}
          accessibilityRole="header"
        >
          Numbers & Currency
        </Text>
        
        <View style={styles.formatItem}>
          <Text style={styles.formatLabel}>Number:</Text>
          <Text 
            style={styles.formatValue}
            accessible={true}
            accessibilityRole="text"
          >
            {formatNumber(sampleData.number, currentLocale)}
          </Text>
        </View>

        <View style={styles.formatItem}>
          <Text style={styles.formatLabel}>Currency:</Text>
          <Text 
            style={styles.formatValue}
            accessible={true}
            accessibilityRole="text"
          >
            {formatCurrency(sampleData.currency, currentLocale)}
          </Text>
        </View>

        <View style={styles.formatItem}>
          <Text style={styles.formatLabel}>Percentage:</Text>
          <Text 
            style={styles.formatValue}
            accessible={true}
            accessibilityRole="text"
          >
            {formatPercentage(sampleData.percentage, currentLocale)}
          </Text>
        </View>
      </View>

      <View style={styles.section}>
        <Text 
          style={styles.sectionTitle}
          accessible={true}
          accessibilityRole="header"
        >
          Locale Examples
        </Text>
        
        {['en', 'es', 'fr', 'ar'].map((locale) => (
          <View key={locale} style={styles.localeExample}>
            <Text style={styles.localeLabel}>{locale.toUpperCase()}:</Text>
            <Text 
              style={styles.localeValue}
              accessible={true}
              accessibilityRole="text"
            >
              {formatDate(currentDate, locale)} - {formatCurrency(sampleData.currency, locale)}
            </Text>
          </View>
        ))}
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
    color: '#333',
  },
  section: {
    marginBottom: 30,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 15,
    color: '#333',
  },
  formatItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 8,
    borderBottomWidth: 1,
    borderBottomColor: '#e9ecef',
  },
  formatLabel: {
    fontSize: 16,
    color: '#666',
    flex: 1,
  },
  formatValue: {
    fontSize: 16,
    color: '#333',
    fontWeight: '500',
    flex: 2,
    textAlign: 'right',
  },
  localeExample: {
    marginBottom: 10,
  },
  localeLabel: {
    fontSize: 14,
    fontWeight: 'bold',
    color: '#007bff',
    marginBottom: 5,
  },
  localeValue: {
    fontSize: 14,
    color: '#333',
    marginLeft: 10,
  },
});

export default LocaleFormattingExample;
```
{% endraw %}


---

## 🎯 **Best Practices**

### **1. Internationalization**
- Use translation keys instead of hardcoded text
- Implement proper locale detection
- Support RTL languages
- Test with different locales

### **2. Localization**
- Format dates, numbers, and currency properly
- Use appropriate text direction
- Consider cultural differences
- Validate translations

### **3. Performance**
- Lazy load translation files
- Cache formatted values
- Optimize bundle size
- Use efficient formatting

---

## ❓ **Interview Questions**

### **Basic Questions**
1. **What is the difference between i18n and l10n?**
2. **How do you implement multi-language support?**
3. **What is RTL and how do you support it?**

### **Advanced Questions**
1. **How would you implement locale-aware date formatting?**
2. **Explain the challenges of RTL layout implementation.**
3. **How do you handle pluralization in different languages?**

### **Practical Questions**
1. **Implement a language switcher with RTL support.**
2. **Create locale-aware number and currency formatting.**
3. **Set up i18n for a React Native app with multiple languages.**

---

## 🧭 Navigation

<div class="navigation">
    <a href="./01-Accessibility-Basics.md" class="nav-link prev">⬅️ Previous: Accessibility Basics</a>
    <a href="./03-Accessibility-Testing.md" class="nav-link next">Next: Accessibility Testing ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
