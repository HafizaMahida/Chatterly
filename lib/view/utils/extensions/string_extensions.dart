extension StringExtension on String {
  String get capsFirstLetterOfSentence => '${this[0].toUpperCase()}${substring(1)}';

  String get allInCaps => toUpperCase();

  String get allInSmall => toLowerCase();

  String get capitalizeFirstLetterOfSentence => split(' ').map((str) => str.capsFirstLetterOfSentence).join(' ');

  String get removeWhiteSpace => replaceAll(' ', '');

  bool get isEmptyString => removeWhiteSpace.isEmpty;

  String get trimSpace => trim().replaceAll(RegExp(r'\s+'), ' ');

  String get encodedURL => Uri.encodeFull(this);

}