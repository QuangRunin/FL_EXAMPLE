import 'package:example/import.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.activeColor,
    this.inActiveColor,
    this.indicatorWidth = 10,
    this.indicatorHeight = 10,
    this.onPressed,
  });
  final int count;
  final int currentIndex;
  final Color? activeColor;
  final Color? inActiveColor;
  final double indicatorWidth;
  final double indicatorHeight;
  final Function(int index)? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        count,
        (index) => currentIndex == index
            ? _indicator(true, index)
            : _indicator(false, index),
      ),
    );
  }

  Widget _indicator(bool isActive, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (onPressed != null) {
          onPressed!(index);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 4.5.sp),
        height: indicatorWidth.sp,
        curve: Curves.linearToEaseOut,
        width: isActive ? indicatorWidth.sp : indicatorHeight.sp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0.sp),
            color: isActive ? activeColor : inActiveColor ?? Colors.grey),
      ),
    );
  }
}
