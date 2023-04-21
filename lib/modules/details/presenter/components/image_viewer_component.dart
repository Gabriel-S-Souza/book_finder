import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: isPortrait
          ? MediaQuery.of(context).size.height * 0.34
          : MediaQuery.of(context).size.height * 0.5,
      child: LayoutBuilder(builder: (context, constraints) {
        return ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: constraints.maxHeight, maxWidth: constraints.maxWidth),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      height: constraints.maxHeight * 0.24,
                      width: constraints.maxWidth,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.onSurface.withAlpha(130),
                            BlendMode.screen,
                          ),
                          image: NetworkImage(
                            widget.imageUrl,
                          ),
                          fit: BoxFit.fill,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Theme.of(context).colorScheme.primary.withOpacity(0.3),
                            Theme.of(context).colorScheme.primary.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -30),
                    child: Container(
                      height: 32,
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.elliptical(24, 16),
                          topRight: Radius.elliptical(24, 16),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: -20,
                    child: SizedBox(
                      width: constraints.maxWidth,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          height: isPortrait
                              ? MediaQuery.of(context).size.height * 0.3
                              : MediaQuery.of(context).size.height * 0.5,
                          child: AspectRatio(
                            aspectRatio: 0.7,
                            child: CachedNetworkImage(
                              imageUrl: widget.imageUrl,
                              fadeInDuration: const Duration(milliseconds: 50),
                              fadeOutDuration: const Duration(milliseconds: 50),
                              placeholder: (context, url) => Center(
                                child: SizedBox.expand(
                                  child: Shimmer.fromColors(
                                    baseColor: Theme.of(context).colorScheme.onInverseSurface,
                                    highlightColor: Theme.of(context).colorScheme.onSecondary,
                                    child: Container(
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
