import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `screen` displaying the provided package's licenses.
class ApplicationLicenseDetailsScreen extends StatelessWidget {
  /// The package's name.
  final String packageName;

  /// All licenses associated to the package.
  final List<LicenseEntry> licenseEntries;

  /// The screen padding.
  final EdgeInsets padding;

  /// Creates an [ApplicationLicenseDetailsScreen].
  const ApplicationLicenseDetailsScreen({
    Key? key,
    required this.packageName,
    required this.licenseEntries,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 16.0,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      backgroundColor: Colors.white,
      appBar: LitAppBar(
        title: packageName,
      ),
      body: LitScrollbar(
        child: ListView.builder(
          padding: padding,
          physics: BouncingScrollPhysics(),
          itemCount: licenseEntries.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: Builder(
                builder: (context) {
                  List<Text> children = [];
                  for (LicenseParagraph paragraph
                      in licenseEntries[index].paragraphs) {
                    children.add(
                      Text(
                        paragraph.text,
                        style: LitMonospaceStyles.body2,
                      ),
                    );
                  }
                  return Column(
                    children: children,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
