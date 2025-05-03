// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(appTitle, appLicenseHtml) =>
      "${appTitle} itself is licensed under ${appLicenseHtml}.";

  static String m1(appTitle) =>
      "Below is the list of all third-party assets that are directly used by ${appTitle}. Some libraries that are used in ${appTitle} may contain and/or use other assets. Tap on an asset name to go to its website. Tap on a license name to read the license text online.";

  static String m2(appTitle) =>
      "Below is the list of all libraries that are directly used by ${appTitle}. These libraries can use some other libraries. Tap on a library name to go to its website. Tap on a license name to read the license text online.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutAuthor": MessageLookupByLibrary.simpleMessage("Author"),
    "aboutAuthorWebsite": MessageLookupByLibrary.simpleMessage(
      "Author\'s website",
    ),
    "aboutBug": MessageLookupByLibrary.simpleMessage("File a bug report"),
    "aboutBuildDate": MessageLookupByLibrary.simpleMessage("Build date"),
    "aboutBuildNumber": MessageLookupByLibrary.simpleMessage("Build number"),
    "aboutBuildSignature": MessageLookupByLibrary.simpleMessage(
      "Build signature",
    ),
    "aboutChangelog": MessageLookupByLibrary.simpleMessage("Changelog"),
    "aboutGitHash": MessageLookupByLibrary.simpleMessage("Git hash"),
    "aboutGitHubReleases": MessageLookupByLibrary.simpleMessage(
      "Releases on GitHub",
    ),
    "aboutHeader": MessageLookupByLibrary.simpleMessage("About"),
    "aboutPackage": MessageLookupByLibrary.simpleMessage("Package name"),
    "aboutWebsite": MessageLookupByLibrary.simpleMessage("Website"),
    "licensesAppHtml": m0,
    "licensesAssets": MessageLookupByLibrary.simpleMessage("Assets"),
    "licensesAssetsHtml": m1,
    "licensesHeader": MessageLookupByLibrary.simpleMessage("Licenses"),
    "licensesHeaderAsset": MessageLookupByLibrary.simpleMessage("Asset"),
    "licensesHeaderLibrary": MessageLookupByLibrary.simpleMessage("Library"),
    "licensesHeaderLicense": MessageLookupByLibrary.simpleMessage("License"),
    "licensesLibraries": MessageLookupByLibrary.simpleMessage("Libraries"),
    "licensesLibrariesDetailsHtml": m2,
    "manualHeader": MessageLookupByLibrary.simpleMessage("Manual"),
  };
}
