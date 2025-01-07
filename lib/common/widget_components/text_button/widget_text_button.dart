import 'package:example/import.dart';

class WidgetTextButton extends StatelessWidget with BaseMixin {
  const WidgetTextButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.textColor});
  final Function() onPressed;
  final String title;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: Get.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        height: 45,
        alignment: Alignment.center,
        child: Text(
          title,
          style:
              textStyle.regular(size: 14, color: textColor ?? color.redColor),
        ),
      ),
    );
  }
}
