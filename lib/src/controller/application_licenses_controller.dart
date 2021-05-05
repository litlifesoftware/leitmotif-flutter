import 'package:flutter/foundation.dart';
import '../model/package_licenses.dart';

/// A controller class to retrieve the licenses registered in the application.

class ApplicationLicensesController {
  /// Get the contract of the package and its licenses by setting the bindings [Map]
  /// key to the provided package name. This will extract the corresponsing index
  /// values of the independend [List] objects.
  List<int>? getPackageLicenseContracts(
      Map<String, List<int>> packageLicenseBindings, String packageName) {
    final List<int>? bindings = packageLicenseBindings[packageName];
    return bindings;
  }

  /// Create [List] of [LicenseEntry]s to include package specific licensed based on
  /// the bindings and the [List] of [LicenseEntry]s containing all licenses.
  /// [List] of []
  List<LicenseEntry> getLicenseEntries(
      List<int> bindings, List<LicenseEntry> licenses) {
    return bindings.map((int i) => licenses[i]).toList(growable: false);
  }

  /// Creates a Future PackageDetails which will join the LicenseRegistry
  /// licenses with the provided index value.
  final Future<PackageLicenses> licenses = LicenseRegistry.licenses
      .fold<PackageLicenses>(
        // (Define the initial value)
        // Initalize the PackageDetails object.
        PackageLicenses(),
        // Define a method to combine the streams.
        // First arg: the to be returned object (PackageLicenses).
        // Second arg: the derivated stream (of LicenseEntry objects)
        (PackageLicenses prev, LicenseEntry license) =>
            // Combine the streams
            // Add the LicenseEntry object to the PackageDetails list
            // by executing its addLicense method.
            prev..addLicense(license),
      )
      // Sort the licenses
      .then((PackageLicenses licenseData) => licenseData..sortPackages());
}
