import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `screen` widget displaying all packages registered in the
/// application.
///
/// Allows to navigate to a detail screen to view the package's license.
class ApplicationLicensesScreen extends StatefulWidget {
  /// The screen's title.
  ///
  /// Defaults to the localized screen title.
  final String? title;
  final Duration animationDuration;

  /// Creates an [ApplicationLicensesScreen].
  const ApplicationLicensesScreen({
    Key? key,
    this.title,
    this.animationDuration = const Duration(
      milliseconds: 450,
    ),
  }) : super(key: key);

  @override
  _ApplicationLicensesScreenState createState() =>
      _ApplicationLicensesScreenState();
}

class _ApplicationLicensesScreenState extends State<ApplicationLicensesScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late LitTweenController _tweenController;
  late ApplicationLicensesController _licensesController;
  final ScrollController _scrollController = ScrollController();

  /// Navigates to the [ApplicationLicenseDetailsScreen].
  void _showDetailScreen(
    PackageLicenseBundle packageLicenseBundle,
    int index,
  ) {
    final List<int> bindings = _licensesController.getPackageLicenseContracts(
      packageLicenseBundle.packageLicenseJunctions,
      packageLicenseBundle.packages.elementAt(index),
    )!;

    LitRouteController(context).pushMaterialWidget(
      ApplicationLicenseDetailsScreen(
        packageName: packageLicenseBundle.packages.elementAt(index),
        licenseEntries: _licensesController.getLicenseEntries(
          bindings,
          packageLicenseBundle.licenses,
        ),
      ),
    );
  }

  @override
  void initState() {
    _licensesController = ApplicationLicensesController();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _tweenController = LitTweenController(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      backgroundColor: Colors.white,
      appBar: FixedOnScrollTitledAppbar(
        scrollController: _scrollController,
        title: widget.title ?? LeitmotifLocalizations.of(context).licensesLabel,
      ),
      body: FutureBuilder(
        future: _licensesController.licenses,
        builder: (BuildContext context,
            AsyncSnapshot<PackageLicenseBundle> bundleSnap) {
          return bundleSnap.hasData
              ? AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    // Only play the animation once fetching has been completed.
                    _animationController.forward();
                    return _AnimatedContent(
                      animationController: _animationController,
                      packageLicenseBundle: bundleSnap.data!,
                      onShowDetailScreen: _showDetailScreen,
                      scrollController: _scrollController,
                      tweenController: _tweenController,
                    );
                  },
                  child: _AnimatedContent(
                    animationController: _animationController,
                    packageLicenseBundle: bundleSnap.data!,
                    onShowDetailScreen: _showDetailScreen,
                    scrollController: _scrollController,
                    tweenController: _tweenController,
                  ),
                )
              : Center(
                  child: JugglingLoadingIndicator(),
                );
        },
      ),
    );
  }
}

/// The [ApplicationLicensesScreen]'s animated list view.
class _AnimatedContent extends StatelessWidget {
  final AnimationController animationController;
  final LitTweenController tweenController;
  final ScrollController scrollController;
  final PackageLicenseBundle packageLicenseBundle;
  final void Function(
    PackageLicenseBundle bundle,
    int index,
  ) onShowDetailScreen;
  const _AnimatedContent({
    Key? key,
    required this.animationController,
    required this.tweenController,
    required this.scrollController,
    required this.packageLicenseBundle,
    required this.onShowDetailScreen,
  }) : super(key: key);

  /// Returns a specific package name using the provided package bundle and
  /// its index.
  String _getPackageListItemLabelAt(int index) {
    return packageLicenseBundle.packages.elementAt(index);
  }

  /// Returns the currently animated opacity.
  double get _opacity {
    return 0.5 + 0.5 * animationController.value;
  }

  /// The horizontal transform.
  static const double _x = 300.0;

  @override
  Widget build(BuildContext context) {
    return LitScrollbar(
      scrollController: scrollController,
      child: ListView.builder(
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 16.0),
        itemCount: packageLicenseBundle.packages.length,
        itemBuilder: (context, index) {
          return Transform(
            transform: tweenController.listItemTransform(
              index,
              packageLicenseBundle.licenses.length,
              x: _x,
            ),
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: animationController.duration!,
              child: _PackageListItem(
                label: _getPackageListItemLabelAt(index),
                onPressed: () => onShowDetailScreen(
                  packageLicenseBundle,
                  index,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// A list view item allowing to navigate to the package's detail screen.
class _PackageListItem extends StatelessWidget {
  final String label;
  final EdgeInsets padding;
  final void Function() onPressed;
  const _PackageListItem({
    Key? key,
    required this.label,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 8.0,
    ),
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: LitPushedThroughButton(
        child: Container(
          height: 42.0,
          child: Center(
            child: Text(
              label,
              style: LitSansSerifStyles.body2,
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
