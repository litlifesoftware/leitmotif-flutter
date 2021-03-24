import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';
import 'package:lit_ui_kit/src/util/sync_animation_on_scroll_controller.dart';
import 'package:lit_ui_kit/src/widgets/settings_panel/settings_tile.dart';
import 'package:lit_ui_kit/src/widgets/settings_panel/settings_panel_controller.dart';

/// A [StatelessWidget] to allow the user to enable and disable
/// various options.
class SettingsPanel extends StatefulWidget {
  final SettingsPanelController controller;
  final String title;
  final bool darkMode;

  /// The [SettingsTile]s displayed in a list on the [SettingsPanel].
  final List<SettingsTile> settingsTiles;
  final List<Widget> children;

  final double height;
  final double width;

  /// Creates a [SettingsPanel].
  ///
  /// It will be used to allow the user to enable and disable
  /// various options.
  const SettingsPanel({
    Key key,
    @required this.controller,
    @required this.title,
    this.darkMode = false,
    this.settingsTiles = const <SettingsTile>[],
    this.children = const <Widget>[],
    this.height = 300.0,
    this.width = 300.0,
  }) : super(key: key);

  @override
  _SettingsPanelState createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel>
    with TickerProviderStateMixin {
  ScrollController _scrollController;
  SyncAnimationOnScrollController _syncAnimationOnScrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _syncAnimationOnScrollController = SyncAnimationOnScrollController(
      scrollController: _scrollController,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _syncAnimationOnScrollController.dispose();
    super.dispose();
  }

  AnimationController get _syncedAnimation {
    return _syncAnimationOnScrollController.animationController;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller.animationController,
      builder: (context, child) {
        return Align(
          alignment: Alignment.bottomRight,
          child: AnimatedOpacity(
            duration: widget.controller.animationController.duration,
            opacity: widget.controller.animationController.value,
            child: Transform(
              transform: Matrix4.translationValues(
                  widget.width +
                      (widget.controller.animationController.value *
                          -widget.width),
                  0,
                  0),
              child: LayoutBuilder(
                builder: (context, constrained) {
                  return Container(
                    height: widget.height,
                    width: widget.width,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8.0,
                            color: Colors.black38,
                            offset: Offset(2, 2),
                            spreadRadius: 1.0,
                          )
                        ],
                        color:
                            widget.darkMode ? LitColors.darkBlue : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                        )),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50.0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Builder(
                                      builder: (BuildContext context) {
                                        final List<Widget> settingTilechildren =
                                            List<Widget>();
                                        widget.settingsTiles
                                            .forEach((settingTile) {
                                          settingTilechildren.add(Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8.0,
                                            ),
                                            child: settingTile,
                                          ));
                                        });
                                        return Column(
                                          children: settingTilechildren,
                                        );
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: widget.children,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          AnimatedBuilder(
                              animation: _syncedAnimation,
                              builder: (BuildContext context, Widget child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: widget.darkMode
                                        ? LitColors.darkBlue
                                            .withOpacity(_syncedAnimation.value)
                                        : Colors.white.withOpacity(
                                            _syncedAnimation.value),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      bottomLeft: Radius.circular(25.0),
                                    ),
                                  ),
                                  width: widget.width,
                                  height: 58.0,
                                );
                              }),
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              CircularCloseButton(
                                onPressed:
                                    widget.controller.dismissSettingsPanel,
                                borderColor: widget.darkMode
                                    ? LitColors.mintGreen
                                    : LitColors.lightRed,
                                color: widget.darkMode
                                    ? Colors.white
                                    : LitColors.lightRed.withOpacity(0.8),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14.0,
                                    horizontal: 12.0,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: LitColors.mediumGrey.withOpacity(
                                        widget.darkMode ? 0.2 : 0.5,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 16.0),
                                      child: ClippedText(
                                        widget.title,
                                        style: LitTextStyles.sansSerif.copyWith(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
