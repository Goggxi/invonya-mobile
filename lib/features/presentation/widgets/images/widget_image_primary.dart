import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WidgetImagePrimary extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit? fit;

  const WidgetImagePrimary({
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
    String urlFinal = "${dotenv.env['IMG_URL']}";
    if (imageUrl.startsWith("https://")) {
      urlFinal = imageUrl;
    } else if (imageUrl.startsWith("http://")) {
      urlFinal = imageUrl;
    } else {
      urlFinal = "${dotenv.env['IMG_URL']}";
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        imageUrl: urlFinal,
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
