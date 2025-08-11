part of 'extensions.dart';

extension BotToastX on BotToast {
  showTitleLoading({String? title}) {
    BotToast.showCustomLoading(
      toastBuilder: (cancel) => Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
            12.verticalSpace,
            AppText(
              title ?? 'Loading...',
              style: ContentTextStyle.bodyText1.colorWhite(),
            ),
          ],
        ),
      ),
    );
  }

  showProgressLoading({required Widget Function() titleBuilder}) {
    BotToast.showCustomLoading(
      toastBuilder: (cancel) => Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
            12.verticalSpace,
            titleBuilder(),
          ],
        ),
      ),
    );
  }
}
