import 'package:charity_management_system/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeadCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, height - 80);
    path.quadraticBezierTo(width / 2, height, width, height - 80);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw UnimplementedError();
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HeadCliper(),
      child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.primary1, boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 11, 11, 11).withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: SvgPicture.asset(
                "assets/icons/light_logo.svg",
                height: 50,
                color: AppColors.textLigth,
              ),
            ),
          )),
    );
  }
}
