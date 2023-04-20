import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageViewerComponent extends StatefulWidget {
  final String imageUrl;
  const ImageViewerComponent({super.key, required this.imageUrl});

  @override
  State<ImageViewerComponent> createState() => _ImageViewerComponentState();
}

class _ImageViewerComponentState extends State<ImageViewerComponent> {
  bool get isPortrait => MediaQuery.of(context).orientation == Orientation.portrait;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: isPortrait
            ? MediaQuery.of(context).size.height * 0.3
            : MediaQuery.of(context).size.height * 0.5,
        child: AspectRatio(
          aspectRatio: 0.7,
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
