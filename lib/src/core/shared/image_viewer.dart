import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/color_constants.dart';
import '../utils/enums.dart';

/// ImageViewer - Display different kind of images such as png, svg, network and IconData.
class ImageViewer extends StatelessWidget {
  const ImageViewer({
    super.key,
    this.color,
    required this.imageData,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  final Color? color;
  final BoxFit fit;
  final ImageData imageData;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    if (imageData.type == ImageType.icon && imageData.iconData == null) {
      return const SizedBox.shrink();
    }
    const validImageTypes = {ImageType.asset, ImageType.network, ImageType.svg};
    if (imageData.src == null && validImageTypes.contains(imageData.type)) {
      return const SizedBox.shrink();
    }

    switch (imageData.type) {
      case ImageType.icon:
        return Icon(
          imageData.iconData,
          size: width ?? height,
          color: color,
        );
      case ImageType.asset:
        return Image.asset(
          imageData.src ?? '',
          height: height,
          width: width,
          fit: fit,
          color: color,
        );
      case ImageType.network:
        return CachedNetworkImage(
          imageUrl: imageData.src ?? '',
          height: height,
          width: width,
          fit: fit,
          color: color,
          fadeOutDuration: const Duration(milliseconds: 100),
          placeholder: (context, url) {
            return Container(
              height: height,
              width: width,
              color: ColorConstants.secondary,
            );
          },
          errorWidget: (context, url, error) => ImageViewer(
            imageData: ImageData(
              type: ImageType.icon,
              iconData: Icons.error,
            ),
          ),
        );
      case ImageType.svg:
        return SvgPicture.asset(
          imageData.src ?? '',
          height: height,
          width: width,
          fit: fit,
          colorFilter: color == null
              ? null
              : ColorFilter.mode(
                  color!,
                  BlendMode.srcIn,
                ),
        );
    }
  }
}

/// ImageData - ImageViewer widget will required this model class to extract type of
/// widget to be shown.
class ImageData {
  ImageData({
    required this.type,
    this.src,
    this.iconData,
  });

  ImageType type;
  String? src;
  IconData? iconData;
}
