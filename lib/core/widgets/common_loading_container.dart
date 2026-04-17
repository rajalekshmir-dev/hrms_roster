import 'package:flutter/material.dart';
import 'common_loading.dart';

class CommonLoadingContainer extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final Widget? loadingWidget;

  const CommonLoadingContainer({
    super.key,
    required this.isLoading,
    required this.child,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingWidget ?? const Center(child: CommonLineLoading());
    }
    return child;
  }
}
