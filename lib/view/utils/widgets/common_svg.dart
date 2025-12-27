import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonSVG extends StatelessWidget {
  final String strIcon;
  final ColorFilter? colorFilter;
  final double? height;
  final double? width;
  final BoxFit boxFit;
  final bool isRotate;

  const CommonSVG({super.key, this.strIcon = '', this.height, this.width, this.boxFit = BoxFit.fill, this.colorFilter, this.isRotate = false,});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: height,
      width: width,
      child: SvgPicture.asset(strIcon, colorFilter: colorFilter, height: height, width: width, fit: boxFit),
    );
  }
}
