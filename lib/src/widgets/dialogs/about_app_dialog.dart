import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';
import 'package:lit_ui_kit/src/widgets/dialogs/website_info.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AboutAppDialog extends StatefulWidget {
  final String launcherImageUrl;
  final String title;
  final String subtitle;
  final String appName;
  final String infoLabel;
  final String infoDescription;

  final Color backgroundColor;
  final TextStyle textStyle;
  final Color accentColor;
  final WebsiteInfo websiteInfo;
  final EdgeInsets padding;
  const AboutAppDialog({
    Key key,
    this.launcherImageUrl,
    this.title = "About",
    this.subtitle,
    @required this.appName,
    this.infoLabel,
    this.infoDescription,
    this.backgroundColor = LitColors.lightGrey,
    this.textStyle = LitTextStyles.sansSerif,
    this.accentColor = Colors.white,
    this.websiteInfo,
    this.padding = const EdgeInsets.only(top: 64.0, bottom: 16.0),
  })  : assert(
          title != null,
          appName != null,
        ),
        super(key: key);
  @override
  _AboutAppDialogState createState() => _AboutAppDialogState();
}

class _AboutAppDialogState extends State<AboutAppDialog> {
  PackageInfo _packageInfo;

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future<void> _launchURL() async {
    String url = "${widget.websiteInfo.websiteUrl}";
    if (await UrlLauncher.canLaunch(url)) {
      await UrlLauncher.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();

    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    const double radius = 25.0;
    return Dialog(
      backgroundColor: widget.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      elevation: 0.0,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            padding: widget.padding,
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.launcherImageUrl != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Image(
                          height: 84.0,
                          image: AssetImage("${widget.launcherImageUrl}"),
                        ),
                      )
                    : SizedBox(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    "${widget.appName}",
                    style: widget.textStyle.copyWith(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  "Version: ${_packageInfo != null ? _packageInfo.version : ''}",
                  style: widget.textStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
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
                        child: Text(
                          "for",
                          style: widget.textStyle.copyWith(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: widget.textStyle.color,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 8.0,
                            ),
                            child: Text(
                              PlatformInfo.platformLabel,
                              style: widget.textStyle.copyWith(
                                color: widget.accentColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                widget.subtitle != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "${widget.subtitle}",
                            style: widget.textStyle.copyWith(
                              color: widget.textStyle.color.withOpacity(0.9),
                              fontSize: 13.0,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : SizedBox(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.infoLabel != null
                          ? Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "${widget.infoLabel}",
                                style: widget.textStyle.copyWith(
                                  color:
                                      widget.textStyle.color.withOpacity(0.7),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : SizedBox(),
                      widget.infoDescription != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                                horizontal: 24.0,
                              ),
                              child: Text(
                                "${widget.infoDescription}",
                                style: widget.textStyle.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
                widget.websiteInfo != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: InkWell(
                          onTap: () => _launchURL(),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: widget.textStyle.color),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 16.0),
                              child: Text(
                                "${widget.websiteInfo.websiteDescription}",
                                style: widget.textStyle.copyWith(
                                  color: widget.accentColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    bottom: 8.0,
                  ),
                  child: Text(
                    PlatformInfo.legalNotice,
                    style: widget.textStyle.copyWith(
                      color: widget.textStyle.color.withOpacity(0.7),
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Container(
              height: 96.0,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: widget.textStyle.color,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 12.0,
                          ),
                          child: ScaledDownText(
                            "${widget.title}",
                            style: widget.textStyle.copyWith(
                              color: widget.accentColor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  CircularCloseButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    borderColor: widget.accentColor.withOpacity(0.7),
                    color: widget.textStyle.color,
                  )
                ],
              )),
        ],
      ),
    );
  }
}
