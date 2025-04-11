import 'package:example/import.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

enum AnimationType { fade, slide, scale, flip }

class WidgetAnimatedList<T> extends StatefulWidget {
  const WidgetAnimatedList({
    super.key,
    required this.itemBuilder,
    this.itemCount = 0,
    this.message,
    this.physics,
    this.padding,
    this.isExpanded = false,
    this.isLoading = false,
    this.scrollDirection = Axis.vertical,
    this.animType = AnimationType.slide,
    this.curve = Curves.easeInOut,
  });
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final String? message;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final bool isExpanded;
  final bool isLoading;
  final Axis scrollDirection;
  final AnimationType animType;
  final Curve curve;
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
        cacheExtent: 300,
        physics: widget.physics ?? const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 350),
            child: _animation(
              type: widget.animType,
              curve: widget.curve,
              child: FadeInAnimation(
                duration: const Duration(milliseconds: 400),
                child: widget.itemBuilder(context, index),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _animation({
    required AnimationType type,
    required Widget child,
    required Curve curve,
  }) {
    switch (type) {
      case AnimationType.fade:
        return FadeInAnimation(
          duration: const Duration(milliseconds: 250),
          curve: curve,
          child: child,
        );
      case AnimationType.slide:
        return SlideAnimation(
          verticalOffset: 50.0,
          duration: const Duration(milliseconds: 250),
          curve: curve,
          child: child,
        );
      case AnimationType.scale:
        return ScaleAnimation(
          duration: const Duration(milliseconds: 250),
          curve: curve,
          child: child,
        );
      case AnimationType.flip:
        return FlipAnimation(
          duration: const Duration(milliseconds: 250),
          curve: curve,
          flipAxis: FlipAxis.y,
          child: child,
        );
    }
  }
}
