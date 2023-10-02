import 'package:flutter/material.dart';

import '../../widgets/rounded_lowopacity_button.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.imgSrc,
    required this.height,
  });

  final String imgSrc;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: height,
          width: double.infinity,
          child: Image.asset(
            imgSrc,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundedLowOpacityButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  // size: 20,
                ),
              ),
              RoundedLowOpacityButtonAnimated(
                onTap: () {
                  print("liked");
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
