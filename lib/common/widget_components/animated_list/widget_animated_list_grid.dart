import 'package:example/import.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class WidgetAnimatedListGrid<T> extends StatefulWidget {
  const WidgetAnimatedListGrid({
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
    this.crossAxisSpacing = 5,
    this.mainAxisSpacing = 5,
    this.mainAxisExtent = 155,
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
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double mainAxisExtent;
  @override
  @override
  State<WidgetAnimatedListGrid<T>> createState() =>
      _WidgetAnimatedListGridState<T>();
}

class _WidgetAnimatedListGridState<T> extends State<WidgetAnimatedListGrid<T>> {
  int keyValue = 0;
  @override
  void didUpdateWidget(covariant WidgetAnimatedListGrid<T> oldWidget) {
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
        child: SingleChildScrollView(
          padding: widget.padding,
          physics: widget.physics ??
              const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: widget.crossAxisSpacing,
              mainAxisSpacing: widget.mainAxisSpacing,
              mainAxisExtent: widget.mainAxisExtent.h,
            ),
            itemCount: widget.itemCount,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            cacheExtent: 1000,
            itemBuilder: (_, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 300),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  child: FadeInAnimation(
                    duration: const Duration(milliseconds: 300),
                    child: Padding(
                      padding: widget.itemPadding ?? EdgeInsets.zero,
                      child: widget.itemBuilder(context, index),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
