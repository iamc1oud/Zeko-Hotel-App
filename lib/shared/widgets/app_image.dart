import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:zeko_hotel_crm/utils/extensions/extension.dart';

class AppImage extends StatelessWidget {
  final String? src;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const AppImage(
      {super.key, required this.src, this.width, this.height, this.fit});

  @override
  Widget build(BuildContext context) {
    if (src == null) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: Colors.grey.shade200),
        child: const Icon(Linecons.food),
      );
    }

    return CachedNetworkImage(
      imageUrl: src!,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) =>
          const CircularProgressIndicator().centerAlign(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
