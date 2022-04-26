import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BuildImagePrimary extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit? fit;

  const BuildImagePrimary({
    Key? key,
    this.height,
    this.width,
    this.radius,
    this.fit,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/images/dimg.svg';
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        filterQuality: FilterQuality.medium,
        progressIndicatorBuilder: (_, __, ___) {
          return SizedBox(
            width: width,
            height: height,
            child: SvgPicture.asset(
              assetName,
              semanticsLabel: 'image-loading',
              fit: BoxFit.cover,
            ),
          );
        },
        errorWidget: (_, __, ___) {
          return SizedBox(
            width: width,
            height: height,
            child: SvgPicture.asset(
              assetName,
              semanticsLabel: 'image-loading',
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
