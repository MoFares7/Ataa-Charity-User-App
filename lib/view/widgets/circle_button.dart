import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key? key,
    required this.image,
    required this.onPressed,
  }) : super(key: key);

  final String image;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: SvgPicture.asset(
          image,
          height: 30,
          width: 30,
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
