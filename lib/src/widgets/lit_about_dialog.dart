import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LitAboutDialog extends StatefulWidget {
  final String title;
  final String appName;
  final String? infoDescription;
  final EdgeInsets padding;
  final Widget art;
  const LitAboutDialog({
    Key? key,
    this.title = "About",
    required this.appName,
    this.infoDescription,
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

  // void _onPop() {
  //   return Navigator.of(context).pop();
  // }

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
        child: _packageInfo != null
            ? _AboutDialogContent(
                appName: widget.appName,
                art: widget.art,
                infoDescription: widget.infoDescription,
                version: _packageInfo!.version,
              )
            : SizedBox(),
      ),
    );
  }
}

class _AboutDialogContent extends StatelessWidget {
  final Widget art;
  final String appName;
  final String version;
  final String? infoDescription;
  const _AboutDialogContent({
    Key? key,
    required this.art,
    required this.appName,
    required this.version,
    required this.infoDescription,
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
