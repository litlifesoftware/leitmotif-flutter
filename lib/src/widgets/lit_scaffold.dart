import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// [Widget] used to overlay multiple functinal [Widget]s to ensure no
/// unintended overlapping will occur.
///
/// The default [Scaffold] will be used as foundation  which will be extended by
/// the custom widgets. By passing on the arguments, the corresponding [Widget]s
/// will be played into a [Stack].
///
/// The layer will be dependend on the [Widget]'s usecase. E.g. a [LitSnackbar]
/// will always be displayed on top of a [CustomAppBar].
///
/// The [body] is adjusted to fit the [CustomAppBar] using a top padding, if it
/// is provided and it if is not the [LitBlurredAppBar].
class LitScaffold extends StatefulWidget {
  /// The [Color] of the background.
  final Color backgroundColor;

  /// The main [Widget] to be displayed on the [LitScaffold].
  final Widget body;

  /// The [CustomAppBar] displays additional information.
  final CustomAppBar? appBar;

  /// The [LitSnackbar]s are displaying changes triggered by the user. The
  /// snackbars are stacked on top of each other. To avoid stacked snackbars,
  /// you could use the [LitNotificationContainer].
  ///
  /// You can you one of the following [LitSnackbar]s:
  ///
  ///  * [LitIconSnackbar] to display an icon alongside a text.
  ///  * [LitBaseSnackbar] to display a custom widget.
  ///  * [LitTransparentIconSnackbar] to display an icon alongside a text on a
  ///    transparent background
  ///  * [LitTransparentSnackbar] to display a custom widget on a transparent
  ///    background.
  final List<LitSnackbar> snackbars;
  final CustomActionButton? actionButton;
  final CollapsibleCard? collapsibleCard;
  final LitSettingsPanel? settingsPanel;
  final bool wrapInSafeArea;
  final PreferredSizeWidget? materialAppBar;
  final Widget? materialDrawer;
  final Widget? materialBottomSheet;

  /// Creates a [LitScaffold] [Widget].

  const LitScaffold({
    Key? key,
    this.backgroundColor = Colors.white,
    required this.body,
    this.snackbars = const [],
    this.appBar,
    this.actionButton,
    this.collapsibleCard,
    this.settingsPanel,
    this.wrapInSafeArea = true,
    this.materialAppBar,
    this.materialDrawer,
    this.materialBottomSheet,
  }) : super(key: key);

  @override
  _LitScaffoldState createState() => _LitScaffoldState();
}

class _LitScaffoldState extends State<LitScaffold>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    for (LitSnackbar bar in widget.snackbars) {
      bar.controller!.init(this);
    }

    if (widget.collapsibleCard != null) {
      widget.collapsibleCard!.controller.init(this);
    }

    if (widget.settingsPanel != null) {
      widget.settingsPanel!.controller.init(this);
    }
  }

  @override
  void dispose() {
    for (LitSnackbar bar in widget.snackbars) {
      bar.controller!.dispose();
    }

    if (widget.collapsibleCard != null) {
      widget.collapsibleCard!.controller.dispose();
    }

    if (widget.settingsPanel != null) {
      widget.settingsPanel!.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _body = _LitScaffoldBody(appBar: widget.appBar, body: widget.body);
    Widget _stack = Stack(
      children: [
        widget.settingsPanel != null
            ? CleanInkWell(
                onTap: () {
                  if (widget.settingsPanel!.controller.isShown) {
                    widget.settingsPanel!.controller.dismissSettingsPanel();
                  }
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      _body,
                      LitSettingsPanelBackgroundOverlay(
                        controller: widget.settingsPanel!.controller,
                      )
                    ],
                  ),
                ),
              )
            : _body,
        widget.appBar ?? SizedBox(),
        widget.collapsibleCard ?? SizedBox(),
        _SnackbarBuilder(bars: widget.snackbars),
        widget.actionButton ?? SizedBox(),
        widget.settingsPanel ?? SizedBox(),
      ],
    );
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: widget.wrapInSafeArea ? SafeArea(child: _stack) : _stack,
      appBar: widget.materialAppBar,
      drawer: widget.materialDrawer,
      bottomSheet: widget.materialBottomSheet,
    );
  }
}

/// A builder mapping the provided [LitSnackbar] widgets onto a [Stack].
class _SnackbarBuilder extends StatefulWidget {
  final List<LitSnackbar> bars;
  const _SnackbarBuilder({
    Key? key,
    required this.bars,
  }) : super(key: key);

  @override
  __SnackbarBuilderState createState() => __SnackbarBuilderState();
}

class __SnackbarBuilderState extends State<_SnackbarBuilder> {
  List<Widget> get _snackbars {
    final List<Widget> children = [];
    for (LitSnackbar bar in widget.bars) {
      children.add(bar);
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Stack(
        children: _snackbars,
      );
    });
  }
}

/// The [LitScaffold]'s body [Widget].
///
/// Depending on the provided [CustomAppBar] the [Padding] should be adjusted.
class _LitScaffoldBody extends StatefulWidget {
  final Widget body;
  final CustomAppBar? appBar;

  const _LitScaffoldBody({
    Key? key,
    required this.body,
    required this.appBar,
  }) : super(key: key);

  @override
  __LitScaffoldBodyState createState() => __LitScaffoldBodyState();
}

class __LitScaffoldBodyState extends State<_LitScaffoldBody> {
  /// States whether to implement a safe area on the `Scaffold`'s body
  /// (required when using always-on app bars).
  bool get _safeArea {
    if (widget.appBar is LitBlurredAppBar) {
      return false;
    }
    if (widget.appBar is FixedOnScrollTitledAppbar) {
      return false;
    }

    if (widget.appBar is FixedOnScrollAppbar) {
      return false;
    }

    if (widget.appBar is MinimalistAppBar) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return widget.appBar != null && _safeArea
        ? Padding(
            padding: const EdgeInsets.only(top: CustomAppBar.height),
            child: widget.body,
          )
        : widget.body;
  }
}
