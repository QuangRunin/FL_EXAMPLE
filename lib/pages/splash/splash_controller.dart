import 'dart:math';

import 'package:example/base/base_controller.dart';
import 'package:example/common/utils/functions.dart';
import 'package:example/data/model/spin/spin_data.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashController extends BaseController with GetTickerProviderStateMixin {
  Rx<SpinData?> result = RxNullable<SpinData?>().setNull();
  late AnimationController _controller;
  late Animation<double> _animation;
  RxDouble rotationAngle = 0.0.obs;
  int currentSegment = 0;
  int itemCount = 15;
  List<SpinData> data = [];
  RxBool showConfetti = false.obs;

  static const platform = MethodChannel('scroll_list_channel');
  final formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    _initialData();
    super.onInit();
  }

  void _initialData() {
    _randomData();
    rotationAngle.value = _rotationAngle;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _calculateSegment();
    _controller.addListener(() {
      rotationAngle.value = _animation.value;
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _calculateSegment();
      }
    });
  }

  double get _rotationAngle {
    int segments = data.length;
    double segmentAngle = 2 * pi / segments;
    return (3 * pi / 2) - (0 * segmentAngle) - (segmentAngle / 2);
  }

  void _randomData() {
    for (int i = 0; i < itemCount; i++) {
      data.add(
        SpinData(
          color: randomOpaqueColor,
          id: i + 1,
          name: 'Item ${i + 1}',
        ),
      );
    }
  }

  static Color get randomOpaqueColor {
    final int r = Random().nextInt(206) + 500;
    final int g = Random().nextInt(206) + 500;
    final int b = Random().nextInt(206) + 500;
    return Color.fromARGB(0xff, r, g, b);
  }

  void _calculateSegment() {
    final inverseAngle = pi / 2;
    int segments = itemCount;
    double segmentAngle = 2 * pi / segments;
    double normalizedAngle =
        (rotationAngle % (2 * pi) + 2 * pi) % (2 * pi) + inverseAngle;
    int segmentIndex =
        ((segments - (normalizedAngle / segmentAngle)) % segments).floor();
    currentSegment = segmentIndex;
    result.value = data[segmentIndex];
    showConfetti.value = true;
    Future.delayed(const Duration(seconds: 3), () {
      showConfetti.value = false;
    });
  }

  void spinWheel() {
    final random = Random();
    final int spins = random.nextInt(3) + 10;
    final double endAngle = spins * 2 * pi;
    final double randomOffset = random.nextDouble() * 2 * pi;
    final double targetAngle = rotationAngle.value + endAngle + randomOffset;

    _animation = Tween<double>(
      begin: rotationAngle.value,
      end: targetAngle,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutExpo,
      ),
    );

    _controller.forward(from: 0);
  }
}
