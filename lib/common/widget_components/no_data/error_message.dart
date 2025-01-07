import 'package:example/core/api_error.dart';
import 'package:example/import.dart';

class ErrorMessage extends StatelessWidget with BaseMixin {
  ErrorMessage({
    super.key,
    this.message,
    this.err,
    this.errColor,
  });

  final String? message;
  final ApiError? err;
  final Color? errColor;
  @override
  Widget build(BuildContext context) {
    final bool isError = err != null && err!.message!.isNotEmpty;
    if (isError) {
      if (err?.message == LocaleKeys.noInternet) {
        return _widgetNoInterNet();
      } else {
        return _widgetErr();
      }
    } else {
      return _noData();
    }
  }

  Widget _widgetNoInterNet() {
    return SafeArea(
      bottom: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(AssetIcons.iconNotConnect, width: 250.r),
          Padding(
            padding: EdgeInsets.only(top: 16.r),
            child: Text('Oops!', style: textStyle.bold(size: 32)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.r),
            child: Text(
              LocaleKeys.noInternetConnection.tr,
              textAlign: TextAlign.center,
              style: textStyle.regular(size: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetErr() {
    return SafeArea(
      bottom: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(AssetIcons.iconErr, width: 250.r),
          Text(
            '${err?.message?.tr}',
            textAlign: TextAlign.center,
            style: textStyle.regular(size: 14),
          ),
        ],
      ),
    );
  }

  Widget _noData() {
    return SafeArea(
      bottom: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(AssetIcons.iconNoData, width: 250.r),
          Padding(
            padding: EdgeInsets.only(top: 16.r),
            child: Text(
              (message ?? LocaleKeys.noData).tr,
              textAlign: TextAlign.center,
              style: textStyle.regular(size: 14),
            ),
          ),
        ],
      ),
    );
  }
}
