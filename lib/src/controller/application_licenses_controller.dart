import 'package:flutter/foundation.dart';

/// A Leitmotif 'controller' class to retrieve all licenses registered on
/// the application.
class ApplicationLicensesController {
  /// Gets all licenses-keys (junctions) that are assigned to the provided
  /// package.
  ///
  /// Multiple licenses could be used by muliple packages. This will allow to
  /// reuse licences on several packages.
  List<int>? getPackageLicenseContracts(
      Map<String, List<int>> packageLicenseBindings, String packageName) {
    final List<int>? bindings = packageLicenseBindings[packageName];
    return bindings;
  }

  /// Gets all packages including their licences registered on the app.
  List<LicenseEntry> getLicenseEntries(
      List<int> bindings, List<LicenseEntry> licenses) {
    return bindings.map((int i) => licenses[i]).toList(growable: false);
  }

  /// Gets a [PackageLicenseBundle] future object to retrive on a future builder.
  final Future<PackageLicenseBundle> licenses = LicenseRegistry.licenses
      .fold<PackageLicenseBundle>(
        // (Define the initial value)
        // Initalize the PackageDetails object.
        PackageLicenseBundle(),
        // Define a method to combine the streams.
        // First arg: the to be returned object (PackageLicenses).
        // Second arg: the derivated stream (of LicenseEntry objects)
        (PackageLicenseBundle prev, LicenseEntry license) =>
            // Combine the streams.
            prev..addLicense(license),
      )
      // Sort the licenses
      .then((PackageLicenseBundle licenseData) => licenseData..sortPackages());
}

/// A Leitmotif class containing all licences and packages registered to the
/// app.
class PackageLicenseBundle {
  /// Stores all licenses used and registered on the application.
  final List<LicenseEntry> licenses = <LicenseEntry>[];

  /// Stores all junctions of packages and licences that are related.
  final Map<String, List<int>> packageLicenseJunctions = <String, List<int>>{};

  /// Stores all packages registered on the app.
  final List<String> packages = <String>[];

  /// Adds a license to the [licenses] list while adding the created junction
  /// to the [packageLicenseJunctions] map to track its relation.
  void addLicense(LicenseEntry entry) {
    for (final String package in entry.packages) {
      _addPackage(package);
      // Bind this license to the package using the next index value.
      packageLicenseJunctions[package]!.add(licenses.length);
    }
    licenses.add(entry); // Completion of the contract above.
  }

  /// Adds a package to the [packages] list while creating a new junction entry
  /// on the [packageLicenseJunctions] map.
  ///
  /// If the package is already registered, the provided [package] will not be
  /// added to avoid any duplicates.
  void _addPackage(String package) {
    if (!packageLicenseJunctions.containsKey(package)) {
      packageLicenseJunctions[package] = [];
      packages.add(package);
    }
  }

  /// Sort the packages their labels.
  void sortPackages([int compare(String a, String b)?]) {
    packages.sort(
      compare ??
          (String a, String b) {
            return a.toLowerCase().compareTo(b.toLowerCase());
          },
    );
  }
}
