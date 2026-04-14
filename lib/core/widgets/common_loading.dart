import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CommonLineLoading extends StatelessWidget {
  final double size;
  final Color? color;

  const CommonLineLoading({
    super.key,
    this.size = 30,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWave(
        size: size,
        color: color ?? Theme.of(context).primaryColor,
      ),
    );
  }
}