import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A screen [Widget] displaying package license details.
///
/// The provided [packageName] will be displayed alongside its [LicenseEntry]s
/// which will enable the package to display multiple licenses if necessary.
class ApplicationLicenseDetailsScreen extends StatefulWidget {
  final bool darkMode;
  final String packageName;
  final List<LicenseEntry> licenseEntries;
  final TextStyle? licenseTextStyle;

  /// Creates an [ApplicationLicenseDetailsScreen].
  ///
  /// Define the [darkMode] value for an alternative color scheme.
  /// Define the [licenseTextStyle] value to alter the default [TextStyle].
  const ApplicationLicenseDetailsScreen({
    Key? key,
    this.darkMode = false,
    required this.packageName,
    required this.licenseEntries,
    this.licenseTextStyle,
  }) : super(key: key);

  @override
  _ApplicationLicenseDetailsScreenState createState() =>
      _ApplicationLicenseDetailsScreenState();
}

class _ApplicationLicenseDetailsScreenState
    extends State<ApplicationLicenseDetailsScreen> {
  /// Returns a [List] of [Text] [Widgets]s containing the license
  /// paragraphs.
  List<Text> _buildLicenseText(LicenseEntry entry) {
    List<Text> textList = [];
    for (LicenseParagraph paragraph in entry.paragraphs) {
      textList.add(Text(
        paragraph.text,
        style: widget.licenseTextStyle ??
            LitTextStyles.monospace.copyWith(
              fontSize: 18.0,
              color: widget.darkMode ? Colors.white : LitColors.mediumGrey,
            ),
      ));
    }
    return textList;
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
        backgroundColor: widget.darkMode ? LitColors.darkBlue : Colors.white,
        appBar: LitBlurredAppBar(
          darkMode: widget.darkMode,
          title: "${widget.packageName}",
          textStyle: LitTextStyles.sansSerif,
        ),
        body: ListView.builder(
            padding: EdgeInsets.only(
              top: LitBlurredAppBar.height + 16.0,
              bottom: 16.0,
              right: 32.0,
              left: 32.0,
            ),
            physics: BouncingScrollPhysics(),
            itemCount: widget.licenseEntries.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: Column(
                    children: _buildLicenseText(widget.licenseEntries[index]),
                  ));
            })
        // _OpenSourceLicensesView(),

        );
  }
}
