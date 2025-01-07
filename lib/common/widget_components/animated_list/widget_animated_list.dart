import 'package:example/import.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class WidgetAnimatedList<T> extends StatefulWidget {
  const WidgetAnimatedList({
    super.key,
    required this.itemBuilder,
    this.itemCount = 0,
    this.message,
    this.physics,
    this.padding,
    this.isExpanded = false,
    this.itemPadding,
    this.onSlidablePressed,
    this.widgetNoData,
    this.isLoading = false,
    this.scrollDirection = Axis.vertical,
  });
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final String? message;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final bool isExpanded;
  final EdgeInsets? itemPadding;
  final Function(int index)? onSlidablePressed;
  final Widget? widgetNoData;
  final bool isLoading;
  final Axis scrollDirection;
  @override
  @override
  State<WidgetAnimatedList<T>> createState() => _WidgetAnimatedListState<T>();
}

class _WidgetAnimatedListState<T> extends State<WidgetAnimatedList<T>> {
  int keyValue = 0;
  @override
  void didUpdateWidget(covariant WidgetAnimatedList<T> oldWidget) {
    if (widget.isLoading != oldWidget.isLoading && widget.isLoading == false) {
      keyValue += 1;
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      key: ValueKey(keyValue),
      child: ListView.builder(
        itemCount: widget.itemCount,
        padding: widget.padding ?? EdgeInsets.zero,
        scrollDirection: widget.scrollDirection,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 350),
            child: SlideAnimation(
              verticalOffset: 50.0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: FadeInAnimation(
                duration: const Duration(milliseconds: 400),
                child: Padding(
                  padding: widget.itemPadding ?? EdgeInsets.zero,
                  child: widget.itemBuilder(context, index),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
