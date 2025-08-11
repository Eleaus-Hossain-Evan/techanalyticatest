part of 'extensions.dart';

extension RefExtension on Ref {
  void cachedFor({int seconds = 10}) {
    print('****** - ${container.runtimeType} cachedFor: $seconds - ******');
    Timer? timer;

    onResume(() {
      timer?.cancel();
      print('****** - ${container.runtimeType} TIMER CANCELLED - ******');
    });

    final keepAliveLink = keepAlive();

    onCancel(
      () {
        timer = Timer(
          Duration(seconds: seconds),
          () => keepAliveLink.close(),
        );
        print('****** - ${container.runtimeType} TIMER STARTED For $seconds - ******');
      },
    );
    onDispose(() {
      timer?.cancel();
      print('****** - ${container.runtimeType} TIMER CANCELLED****** - ');
    });
  }
}

extension SnackbarRefX on GlobalKey<ScaffoldMessengerState> {
  void showSnackbar(String s, {bool error = false}) {
    currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          s,
          style: TextStyle(
            color: error ? currentContext?.color.error : currentContext?.color.primary,
          ),
        ),
        backgroundColor: error ? currentContext?.color.errorContainer : currentContext?.color.primaryContainer,
      ));
  }
}

extension AsyncValueListener on WidgetRef {
  void handleAsyncValue<T>(
    BuildContext context,
    AsyncValue<T> next,
  ) {
    if (next is AsyncLoading) {
      BotToast.showLoading();
    }
    if (next is AsyncData) {
      BotToast.closeAllLoading();
    }
    if (next is AsyncError) {
      BotToast.closeAllLoading();
      String errText = '';
      if (next.error is AppException) {
        errText = (next.error as AppException).message;
      } else {
        errText = next.error.toString();
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: AppText(
                errText,
                color: context.color.onError,
              ),
              backgroundColor: context.color.error,
            ),
          );
      }
    }
  }
}
