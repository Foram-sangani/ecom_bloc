class LanCon {
  static String languageCode = 'en';

  static String get hello => switch (languageCode) {
        "en" => 'Hello',
        "gu" => 'હેલો',
        "hi" => 'नमस्ते',
        String() => '',
      };

  static String get welcome => switch (languageCode) {
        "en" => 'Welcome',
        "gu" => 'સ્વાગત છે',
        "hi" => 'स्वागत है',
        String() => '',
      };

  static String get flutter => switch (languageCode) {
        "en" => 'This is Flutter',
        "gu" => 'આ છે ફ્લટર',
        "hi" => 'यह है फ्लटर',
        String() => '',
      };

  static String get localisation => switch (languageCode) {
        "en" => 'Localisation',
        "gu" => 'સ્થાનિકીકરણ',
        "hi" => 'स्थानिकीकरण',
        String() => '',
      };

  static String get selectLanguage => switch (languageCode) {
        "en" => 'SELECT LANGUAGE',
        "gu" => 'ભાષા પસંદ કરો',
        "hi" => 'भाषा चुने',
        String() => '',
      };

  static String get selectLanguageDesc => switch (languageCode) {
        "en" => 'Select language you are comfortable with',
        "gu" => 'તે ભાષા પસંદ કરો તમે સહજ હોવ',
        "hi" => 'वह भाषा चुनें जिसमें आप सहज हों',
        String() => '',
      };

  static String get changeLanguage => switch (languageCode) {
        "en" => 'Change Language',
        "gu" => 'ભાષા બદલો',
        "hi" => 'भाषा बदलें',
        String() => '',
      };
}
