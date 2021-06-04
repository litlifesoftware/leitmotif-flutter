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

  /// Creates an [ApplicationLicensesScreen].
  ///
  /// Define the [darkMode] value for a different color scheme.
  const ApplicationLicensesScreen({
    Key? key,
    this.darkMode = false,
  }) : super(key: key);

  @override
  _ApplicationLicensesScreenState createState() =>
      _ApplicationLicensesScreenState();
}

class _ApplicationLicensesScreenState extends State<ApplicationLicensesScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late ApplicationLicensesController licensesController;

  @override
  void initState() {
    super.initState();
    licensesController = ApplicationLicensesController();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1000,
      ),
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
        title: "Open Source Licenses",
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
                        top: LitBlurredAppBar.height + 16.0,
                        bottom: 16.0,
                      ),
                      itemCount: packageLicencesSnapshot.data!.packages.length,
                      itemBuilder: (context, index) {
                        Animation tween = Tween<double>(
                                begin: 1 -
                                    (index /
                                        packageLicencesSnapshot
                                            .data!.packages.length),
                                end: 1.0)
                            .animate(animationController);
                        return Transform(
                          transform: Matrix4.translationValues(
                              -300 + (300 * tween.value as double), 0, 0),
                          child: AnimatedOpacity(
                            opacity: (tween.value),
                            duration: animationController.duration!,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        final List<int> bindings =
                                            licensesController
                                                .getPackageLicenseContracts(
                                                    packageLicencesSnapshot
                                                        .data!
                                                        .packageLicenseJunctions,
                                                    packageLicencesSnapshot
                                                        .data!.packages
                                                        .elementAt(index))!;

                                        return ApplicationLicenseDetailsScreen(
                                          darkMode: widget.darkMode,
                                          packageName: packageLicencesSnapshot
                                              .data!.packages
                                              .elementAt(index),
                                          licenseEntries: licensesController
                                              .getLicenseEntries(
                                                  bindings,
                                                  packageLicencesSnapshot
                                                      .data!.licenses),
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 52.0,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: widget.darkMode
                                        ? LitColors.mediumGrey
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      12.0,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: widget.darkMode
                                            ? Colors.black38
                                            : Colors.black38,
                                        blurRadius:
                                            widget.darkMode ? 10.0 : 15.0,
                                        offset: Offset(-2.0, -2.0),
                                        spreadRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                        child: Text(
                                      "${packageLicencesSnapshot.data!.packages.elementAt(index)}",
                                      style: LitTextStyles.sansSerif.copyWith(
                                        color: widget.darkMode
                                            ? Colors.white
                                            : LitColors.mediumGrey,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  })
              : Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: JugglingLoadingIndicator(
                      indicatorColor:
                          widget.darkMode ? Colors.white : LitColors.mediumGrey,
                      backgroundColor:
                          widget.darkMode ? LitColors.mediumGrey : Colors.white,
                      shadowOpacity: widget.darkMode ? 0.1 : 0.25,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
