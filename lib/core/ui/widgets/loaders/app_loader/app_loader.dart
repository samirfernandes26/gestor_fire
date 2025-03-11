import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.size, this.color});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: color ?? Colors.blueAccent,
        size: size ?? 60,
      ),
    );
  }
}
