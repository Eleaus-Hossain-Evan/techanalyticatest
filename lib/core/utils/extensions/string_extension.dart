part of 'extensions.dart';

// extension StringNullCheckExtension on String? {
//   bool get isNotEmptyAndNotNull => this != null && this!.isNotEmpty;
//   bool get isEmptyOrNull => this?.isEmpty ?? true;
// }

extension StringCasingExtension on String {
  String toCapitalize() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() =>
      replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalize()).join(' ');

  List<String> iterable() {
    List<String> items = [];
    split('').forEach((item) => items.add(item));
    return items;
  }

  String toTitleCaseFromCamel() {
    return iterable()
        .map((e) {
          if (e == e.toUpperCase()) {
            return ' $e';
          } else {
            return e;
          }
        })
        .toList()
        .join('')
        .trim()
        .split(' ')
        .map((str) => str.toCapitalize())
        .join(' ');
  }

  String toTitleCaseFromSnack() {
    return iterable()
        .map((e) {
          if (e == '_') {
            return ' ';
          } else {
            return e;
          }
        })
        .toList()
        .join('')
        .trim()
        .split(' ')
        .map((str) => str.toCapitalize())
        .join(' ');
  }

  String toBanglaDigits() {
    final String number = toString();
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < number.length; i++) {
      sb.write(banglaDigits[number[i]] ?? number[i]);
    }
    return sb.toString();
  }
}

extension NullCheckString on String? {
  bool get isEmptyOrNull => this == null || this!.isEmpty;

  bool get isNotEmptyAndNotNull => this != null && this!.isNotEmpty;
}

extension NullCheckNum on num? {
  bool get isNull => null == this;

  bool get isNotNull => null != this;
}

extension NullCheckList<T> on List<T>? {
  bool get isEmptyOrNull => null == this || this!.isEmpty;

  bool get isNotEmptyAndNotNull => null != this && this!.isNotEmpty;
}

extension NullCheckMap<K, V> on Map<K, V>? {
  bool get isEmptyOrNull => null == this || this!.isEmpty;

  bool get isNotEmptyAndNotNull => null != this && this!.isNotEmpty;
}

extension IntConversion on String {
  int toInt() => int.parse(this);

  double toDouble() => double.parse(this);

  num toNum() => num.parse(this);

  int? toIntOrNull() => int.tryParse(this);

  double? toDoubleOrNull() => double.tryParse(this);

  num? toNumOrNull() => num.tryParse(this);
}
