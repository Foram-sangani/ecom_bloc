///* LANGUAGE
enum LanguageType {
  english(id: 1, label: 'English', slug: 'en'),
  hindi(id: 2, label: 'Hindi', slug: 'hi'),
  gujarati(id: 3, label: 'Gujarati', slug: 'gu');

  final int id;
  final String label;
  final String slug;

  const LanguageType({
    required this.id,
    required this.label,
    required this.slug,
  });

  static LanguageType fromSlug(String slug) {
    return LanguageType.values.firstWhere((e) => e.slug == slug);
  }
}

///* Login Status
enum LoginStatus { initial, loading, success, error }

///* Sign Up Status
enum SignUpStatus {
  loading(id: 1, label: 'loading', slug: 'Loading'),
  success(id: 2, label: 'success', slug: 'Successfully registered'),
  error(id: 3, label: 'error', slug: 'Some error occurred');

  final int id;
  final String label;
  final String slug;

  const SignUpStatus({
    required this.id,
    required this.label,
    required this.slug,
  });
}

///* APP TEXT-FORM-FIELD VARIANTS
enum TextFieldType { normal, date, time, search }