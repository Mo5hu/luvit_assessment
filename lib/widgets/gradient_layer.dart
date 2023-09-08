import 'package:flutter/material.dart';

class GradientLayer extends StatelessWidget {
  const GradientLayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0x30202020), Color(0xFF1B1A21)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
      ),
    );
  }
}
