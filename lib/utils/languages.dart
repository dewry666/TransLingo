class Translation_languages {
  static final select_languages = <String>[
    'Filipino',
    'English',
    'Spanish',
    'Japanese',
    'Hindi',
    'French',
    'German',
    'Italian',
    'Russian',
    'Marathi',
    'Bengali',
    'Gujarati',
    'Kannada',
    'Malayalam',
    'Punjabi',
    'Tamil',
    'Telugu'
  
  ];

  static String getLanguageCode(String language) {
    switch (language) {
      case 'Hindi':
        return 'hi';
      case 'Marathi':
        return 'mr';
      case 'Bengali':
        return 'bn';
      case 'Gujarati':
        return 'gu';
      case 'Malayalam':
        return 'ml';
      case 'Kannada':
        return 'kn';
      case 'Punjabi':
        return 'pa';
      case 'Tamil':
        return 'ta';
      case 'English':
        return 'en';
      case 'French':
        return 'fr';
      case 'Italian':
        return 'it';
      case 'Russian':
        return 'ru';
      case 'Spanish':
        return 'es';
      case 'German':
        return 'de';
      case 'Telugu':
        return 'te';
      case 'Japanese':
        return 'ja';
      case 'Filipino':
        return 'tl';
      default:
        return 'en';
    }
  }
}
