import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// A about app dialog widget.
///
/// Displays the app's title, art, description, version and copyright notice.
/// Also shows the current device's platform appropriate trademark notices.
class LitAboutDialog extends StatefulWidget {
  final String title;
  final String appName;
  final String? infoDescription;
  final String? copyrightNotice;
  final EdgeInsets padding;
  final Widget art;

  /// Creates a [LitAboutDialog].
  const LitAboutDialog({
    Key? key,
    this.title = "About",
    required this.appName,
    this.infoDescription,
    this.copyrightNotice,
    this.padding = const EdgeInsets.only(top: 16.0, bottom: 16.0),
    this.art = const SizedBox(),
  }) : super(key: key);
  @override
  _LitAboutDialogState createState() => _LitAboutDialogState();
}

class _LitAboutDialogState extends State<LitAboutDialog> {
  PackageInfo? _packageInfo;

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  String get _version {
    if (_packageInfo == null) return "";

    return _packageInfo!.version;
  }

  @override
  void initState() {
    super.initState();

    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return LitTitledDialog(
      titleText: widget.title,
      child: Container(
        child: _AboutDialogContent(
          appName: widget.appName,
          art: widget.art,
          infoDescription: widget.infoDescription,
          version: _version,
          copyrightNotice: widget.copyrightNotice,
        ),
      ),
    );
  }
}

class _AboutDialogContent extends StatelessWidget {
  final Widget art;
  final String appName;
  final String version;
  final String? infoDescription;
  final String? copyrightNotice;
  const _AboutDialogContent({
    Key? key,
    required this.art,
    required this.appName,
    required this.version,
    required this.infoDescription,
    required this.copyrightNotice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      child: ScrollableColumn(
        constrained: false,
        mainAxisSize: MainAxisSize.min,
        children: [
          art,
          SizedBox(height: 8.0),
          _AppDetails(
            appName: appName,
            version: version,
            infoDescription: infoDescription,
          ),
          SizedBox(height: 8.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              infoDescription != null
                  ? ClippedText(
                      infoDescription!,
                      style: LitSansSerifStyles.caption,
                      textAlign: TextAlign.start,
                      maxLines: 4,
                    )
                  : SizedBox()
            ],
          ),
          SizedBox(height: 8.0),
          _CopyrightNoticeText(
            copyrightNotice: copyrightNotice,
          ),
          Text(
            PlatformInfo.legalNotice,
            style: LitSansSerifStyles.overline,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _CopyrightNoticeText extends StatelessWidget {
  final String? copyrightNotice;
  const _CopyrightNoticeText({
    Key? key,
    required this.copyrightNotice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return copyrightNotice != null
        ? Column(
            children: [
              Text(
                copyrightNotice!,
                style: LitSansSerifStyles.overline,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.0),
            ],
          )
        : SizedBox();
  }
}

class _AppDetails extends StatelessWidget {
  final String appName;
  final String version;
  final String? infoDescription;
  const _AppDetails({
    Key? key,
    required this.appName,
    required this.version,
    required this.infoDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          appName,
          style: LitSansSerifStyles.subtitle1,
          textAlign: TextAlign.center,
        ),
        Text(
          ("Version: " + version),
          style: LitSansSerifStyles.caption,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text("for", style: LitSansSerifStyles.caption),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: LitBadge(
                  backgroundColor: LitColors.beigeGrey,
                  child: Text(
                    PlatformInfo.platformLabel,
                    style: LitSansSerifStyles.caption.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
