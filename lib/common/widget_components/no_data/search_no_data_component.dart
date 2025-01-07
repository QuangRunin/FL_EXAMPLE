import 'package:example/import.dart';

class SearchNoData extends StatelessWidget with BaseMixin {
  SearchNoData({
    super.key,
    required this.message,
    required this.isError,
  });

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text(
              message,
              style: textStyle.bold(
                  size: 20, color: isError ? color.redColor : color.black),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
