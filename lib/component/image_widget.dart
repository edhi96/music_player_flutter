import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxShape? shape;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final BoxFit? fit;

  const ImageWidget({
    Key? key,
    this.fit,
    this.borderRadiusGeometry,
    this.shape,
    required this.imageUrl,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
          borderRadius: borderRadiusGeometry,
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, progress) {
        return Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 230, 230, 230),
          highlightColor: const Color.fromARGB(255, 212, 212, 212),
          child: Container(
            margin: const EdgeInsets.only(right: 5),
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        size: height,
      ),
    );
  }
}
