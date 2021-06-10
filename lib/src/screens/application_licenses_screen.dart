import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A screen [Widget] to display all packages registered in the application.
///
/// The packages are displayed in a [ListView] and are sorted by their name
/// in alpha-nummeric order. To display the license text, the user needs to
/// navigate to the details view by tapping on one of the list items.
class ApplicationLicensesScreen extends StatefulWidget {
  final bool darkMode;
  final String title;
  final Duration animationDuration;

  /// Creates an [ApplicationLicensesScreen].
  ///
  /// * [darkMode] states whether to apply the dark mode specific styling.
  ///
  /// * [title] is the title displayed on the app bar.
  ///
  /// * [animationDuration] is the duration the initial animation should have.
  const ApplicationLicensesScreen({
    Key? key,
    this.darkMode = false,
    this.title = "Open Source Licenses",
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
  late AnimationController animationController;
  late ApplicationLicensesController licensesController;

  /// Calculates a tween [Animation] based on the iterated listview index and
  /// the total list length possible (defined by the [PackageLicenses]).
  Animation _calcTweenAnimation(int index, PackageLicenses licenses) {
    return Tween<double>(
            begin: 1 - (index / licenses.packages.length), end: 1.0)
        .animate(animationController);
  }

  /// Returns a [Matrix4], which a tween animation has been applied on.
  Matrix4 _transform(int index, PackageLicenses licenses) {
    return Matrix4.translationValues(
        -300 + (300 * _calcTweenAnimation(index, licenses).value as double),
        0,
        0);
  }

  void _onPackageListItemPressed(
      AsyncSnapshot<PackageLicenses> packageLicencesSnapshot, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final List<int> bindings =
              licensesController.getPackageLicenseContracts(
                  packageLicencesSnapshot.data!.packageLicenseJunctions,
                  packageLicencesSnapshot.data!.packages.elementAt(index))!;

          return ApplicationLicenseDetailsScreen(
            darkMode: widget.darkMode,
            packageName:
                packageLicencesSnapshot.data!.packages.elementAt(index),
            licenseEntries: licensesController.getLicenseEntries(
                bindings, packageLicencesSnapshot.data!.licenses),
          );
        },
      ),
    );
  }

  String _getPackageListItemLabel(
      AsyncSnapshot<PackageLicenses> packageLicencesSnapshot, int index) {
    return "${packageLicencesSnapshot.data!.packages.elementAt(index)}";
  }

  @override
  void initState() {
    super.initState();
    licensesController = ApplicationLicensesController();
    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      backgroundColor: widget.darkMode ? LitColors.darkBlue : Colors.white,
      appBar: LitBlurredAppBar(
        title: widget.title,
        darkMode: widget.darkMode,
      ),
      body: FutureBuilder(
        future: licensesController.licenses,
        builder: (BuildContext context,
            AsyncSnapshot<PackageLicenses> packageLicencesSnapshot) {
          return packageLicencesSnapshot.hasData
              ? AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    animationController.forward();

                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        // Regarding the blurred app bar height, which has no
                        // safe area applied on the scaffold.
                        top: LitBlurredAppBar.height + 16.0,
                        bottom: 16.0,
                      ),
                      itemCount: packageLicencesSnapshot.data!.packages.length,
                      itemBuilder: (context, index) {
                        return Transform(
                          transform: _transform(
                            index,
                            packageLicencesSnapshot.data!,
                          ),
                          child: AnimatedOpacity(
                            opacity: (_calcTweenAnimation(
                                    index, packageLicencesSnapshot.data!)
                                .value),
                            duration: animationController.duration!,
                            child: _PackageListItem(
                              darkMode: widget.darkMode,
                              label: _getPackageListItemLabel(
                                packageLicencesSnapshot,
                                index,
                              ),
                              onPressed: () => _onPackageListItemPressed(
                                packageLicencesSnapshot,
                                index,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  })
              : _LoadingIndicator(
                  darkMode: widget.darkMode,
                );
        },
      ),
    );
  }
}

/// A package list item widget, whose styling is dependend on the provided
/// [darkMode] value.
class _PackageListItem extends StatefulWidget {
  final String label;
  final bool darkMode;
  final void Function() onPressed;

  /// Creates a [_PackageListItem].
  const _PackageListItem({
    Key? key,
    required this.label,
    required this.darkMode,
    required this.onPressed,
  }) : super(key: key);

  @override
  __PackageListItemState createState() => __PackageListItemState();
}

class __PackageListItemState extends State<_PackageListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(
          12.0,
        ),
        onTap: widget.onPressed,
        child: Container(
          height: 52.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: widget.darkMode ? LitColors.mediumGrey : Colors.white,
            borderRadius: BorderRadius.circular(
              12.0,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.darkMode ? Colors.black38 : Colors.black38,
                blurRadius: widget.darkMode ? 10.0 : 15.0,
                offset: Offset(-2.0, -2.0),
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
                child: Text(
              widget.label,
              style: LitTextStyles.sansSerif.copyWith(
                color: widget.darkMode ? Colors.white : LitColors.mediumGrey,
              ),
            )),
          ),
        ),
      ),
    );
  }
}

/// A loading indicator, whose styling is dependend on the [darkMode] value.
class _LoadingIndicator extends StatelessWidget {
  final bool darkMode;
  const _LoadingIndicator({
    Key? key,
    required this.darkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50.0,
        width: 50.0,
        child: JugglingLoadingIndicator(
          indicatorColor: darkMode ? Colors.white : LitColors.mediumGrey,
          backgroundColor: darkMode ? LitColors.mediumGrey : Colors.white,
          shadowOpacity: darkMode ? 0.1 : 0.25,
        ),
      ),
    );
  }
}
