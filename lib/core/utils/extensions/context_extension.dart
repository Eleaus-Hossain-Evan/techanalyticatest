part of 'extensions.dart';

extension SnackbarX on BuildContext {
  void showSnackbar(String text, {bool error = false}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(
          text,
          style: TextStyle(
            color: error ? color.error : color.primary,
          ),
        ),
        backgroundColor: error ? color.errorContainer : color.primaryContainer,
      ));
  }
}
