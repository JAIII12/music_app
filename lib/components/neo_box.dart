import 'package:flutter/material.dart';
import 'package:music_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class NeoBox extends StatelessWidget {
  final Widget child;

  const NeoBox({super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {

    //is dark mode
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;


    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // darker shadow on bottom right
          BoxShadow(
            color: isDarkMode ? Colors.black : Colors.grey.shade500,
            offset: const Offset(4, 4),
            blurRadius: 15,
          ),

          // lighter shadow on top left
          BoxShadow(
            color: isDarkMode ? Colors.grey.shade800 : Colors.white,
            offset: const Offset(-4, - 4),
            blurRadius: 15,
          ),  
        ]),
        padding: const EdgeInsets.all(12),
    child: child,
    );
  }
}