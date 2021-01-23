import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A controller class used to precache a [List] of images provided inside the asset
/// bundle.
///
/// This will reduce the loading times whenever an image is displayed.
class ImageCacheController {
  final BuildContext context;
  final List<String> assetImages;

  /// Creates an [ImageCacheController] and initalizes the precache precedure.
  ImageCacheController({
    @required this.context,
    @required this.assetImages,
  }) {
    _cacheAssetBundleImages();
  }

  /// Precaches a single image asset.
  void _cacheImage(String asset) {
    precacheImage(
      AssetImage(asset),
      context,
    );
    print("AssetImage on '$asset' precached.");
  }

  /// Precaches all images.
  void _cacheAssetBundleImages() {
    for (String asset in assetImages) {
      try {
        _cacheImage(asset);
      } catch (e) {
        print("Invalid asset url has been provided.");
      }
    }
  }
}
