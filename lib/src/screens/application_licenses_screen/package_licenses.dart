import 'package:flutter/foundation.dart';

/// [packageLicenseJunctions]
class PackageLicenses {
  /// Stores all licenses used and registered on the application.
  final List<LicenseEntry> licenses = <LicenseEntry>[];

  /// A [Map] of containing all package names and their corresponding list of packages.
  /// To bind one package with muliple licenses, the corresponding index values of the
  /// [List] of [LicenseEntry]s (containing the license) will be used. A list of license
  /// index values  will be allocated to each package name.
  final Map<String, List<int>> packageLicenseJunctions = <String, List<int>>{};
  final List<String> packages = <String>[];

  void addLicense(LicenseEntry entry) {
    // Before the license can be added, we must first record the packages to
    // which it belongs.
    for (final String package in entry.packages) {
      _addPackage(package);
      // Bind this license to the package using the next index value. This
      // creates a contract that this license must be inserted at this same
      // index value.
      packageLicenseJunctions[package]!.add(licenses.length);
    }
    licenses.add(entry); // Completion of the contract above.
  }

  /// Add the provided package to the corresponding packages list. If the
  /// [packageLicenseJunctions] [Map] already has the package name as one of its keys, the
  /// package will not be added to avoid multiple entries of the same package. Also the
  /// value of the package license bindings will be set to an initalized list to later add
  /// the package index values.
  void _addPackage(String package) {
    if (!packageLicenseJunctions.containsKey(package)) {
      packageLicenseJunctions[package] = [];
      packages.add(package);
    }
  }

  /// Sort the packages inside the list by comparing two provided [String]s to each other.
  void sortPackages([int compare(String a, String b)?]) {
    packages.sort(compare ??
        (String a, String b) {
          return a.toLowerCase().compareTo(b.toLowerCase());
        });
  }
}
