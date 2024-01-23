import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredImage extends StatelessWidget {
  final ImageProvider<Object> image;
  final Widget? child;

  const BlurredImage({super.key, required this.image, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Network image
          Image(
              image: image,
                  fit: BoxFit.cover,
          ),
          // Backdrop filter for blurring
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              color: Colors.black.withOpacity(0.5), // Adjust the opacity for shading
            ),
          ),
          // Your content goes here
          Center(
            widthFactor: 1,
            heightFactor: 1,
            child: child,
          ),
        ],
      ),
    );
  }
}