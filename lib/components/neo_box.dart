import 'package:flutter/material.dart';

class NeoBox extends StatelessWidget {
  final Widget child;

  const NeoBox({super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // darker shadow on bottom right
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(4, 4),
            blurRadius: 15,
          ),

          // lighter shadow on top left
          BoxShadow(
            color: Colors.white,
            offset: const Offset(-4, - 4),
            blurRadius: 15,
          ),  
        ]),
        padding: const EdgeInsets.all(12),
    child: child,
    );
  }
}