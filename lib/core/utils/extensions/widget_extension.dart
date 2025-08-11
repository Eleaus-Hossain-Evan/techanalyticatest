part of 'extensions.dart';

extension WidgetListExtension on Iterable<Widget> {
  List<Widget> withSeparator(Widget separator) {
    if (isEmpty) return [];
    if (length == 1) return [first];

    return expand((widget) => [widget, separator]).toList()..removeLast(); // Remove the last separator
  }
}
