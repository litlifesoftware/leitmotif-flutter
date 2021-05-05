import 'package:flutter/widgets.dart';

/// A controller class to precache a list of provided images on startup.
///
/// The images are put onto the image cache to be displayed faster without
/// the need of fetching them on the widget itself which will reduce the
/// loading time of each image. In order to keep the loading time as short
/// as possible and to avoid to much memory alloation on runtime, the
/// precached image should be rather small. Compressing the image or reducing
/// the resolution can help reducing the image size.
class ImageCacheController {
  /// The context will provide a contract to the current widget tree's state.
  final BuildContext context;

  /// The image locations.
  final List<String?> assetImages;

  /// States whether to show debug output.
  final bool showDebugOutput;

  /// Creates an [ImageCacheController] and initalizes the precache precedure.
  ///
  /// * [context] will provide the contract to the widget tree.
  ///
  /// * [assetImages] defines the images to be precached.
  ///
  /// {@tool snippet}
  ///
  /// It is recommended to initialize the [ImageCacheController] as soon as
  /// possible e.g. on your root [MaterialApp] or [CupertinoApp]'s state by
  /// calling the constructor inside the initState method like stated below
  /// and use it as like a method call:
  /// ```dart
  /// ImageCacheController(
  ///    context: context,
  ///    assetImages: ["assets/images/image.png"],
  ///  );
  /// ```
  /// {@end-tool}

  ImageCacheController({
    required this.context,
    required this.assetImages,
    this.showDebugOutput = false,
  }) {
    _cacheAssetBundleImages();
  }

  /// Precaches a single image asset.
  void _cacheImage(String? asset) {
    try {
      precacheImage(
        AssetImage(asset!),
        context,
      ).then((_) {
        if (showDebugOutput) {
          print("AssetImage on '$asset' precached.");
        }
      });
    } catch (e) {
      print("Invalid asset url has been provided.");
    }
  }

  /// Precaches all images.
  void _cacheAssetBundleImages() {
    for (String? asset in assetImages) {
      _cacheImage(asset);
    }
  }
}
