import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';
import 'package:package_info/package_info.dart';

class LitAboutDialog extends StatefulWidget {
  final String title;
  final String appName;
  final String? infoDescription;
  final EdgeInsets padding;
  final Widget art;
  final bool showBackButton;
  const LitAboutDialog({
    Key? key,
    this.title = "About",
    required this.appName,
    this.infoDescription = "",
    this.padding = const EdgeInsets.only(top: 16.0, bottom: 16.0),
    this.art = const SizedBox(),
    this.showBackButton = true,
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

  void _onPop() {
    return Navigator.of(context).pop();
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
      leading:
          widget.showBackButton ? DialogBackButton(onPressed: _onPop) : null,
      child: SingleChildScrollView(
        padding: widget.padding,
        physics: BouncingScrollPhysics(),
        child: _packageInfo != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: widget.art,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "${widget.appName}",
                      style: LitTextStyles.sansSerifSmallHeader,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "Version: ${_packageInfo!.version}",
                    style: LitTextStyles.sansSerifBody,
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
                          child:
                              Text("for", style: LitTextStyles.sansSerifBody),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: LitColors.beigeGrey),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                                horizontal: 8.0,
                              ),
                              child: Text(
                                PlatformInfo.platformLabel,
                                style: LitTextStyles.sansSerifBodyTighterSmaller
                                    .copyWith(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        widget.infoDescription != null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                  horizontal: 24.0,
                                ),
                                child: Text(
                                  "${widget.infoDescription}",
                                  style:
                                      LitTextStyles.sansSerifBodyTighterSmaller,
                                  textAlign: TextAlign.start,
                                ),
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      PlatformInfo.legalNotice,
                      style: LitTextStyles.sanSerifBodySmall,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )
            : JugglingLoadingIndicator(
                indicatorColor: Colors.grey,
                backgroundColor: Colors.white,
                shadowOpacity: 0.3),
      ),
    );
  }
}
