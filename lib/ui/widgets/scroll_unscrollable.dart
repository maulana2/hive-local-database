import 'package:flutter/material.dart';

class ScrollUnscrollablle extends StatelessWidget {
  final Widget child;

  const ScrollUnscrollablle({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: child,
        )
      ],
    );
  }
}
