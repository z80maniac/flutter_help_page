// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Manual`
  String get manualHeader {
    return Intl.message('Manual', name: 'manualHeader', desc: '', args: []);
  }

  /// `About`
  String get aboutHeader {
    return Intl.message('About', name: 'aboutHeader', desc: '', args: []);
  }

  /// `Website`
  String get aboutWebsite {
    return Intl.message('Website', name: 'aboutWebsite', desc: '', args: []);
  }

  /// `Releases on GitHub`
  String get aboutGitHubReleases {
    return Intl.message(
      'Releases on GitHub',
      name: 'aboutGitHubReleases',
      desc: '',
      args: [],
    );
  }

  /// `File a bug report`
  String get aboutBug {
    return Intl.message(
      'File a bug report',
      name: 'aboutBug',
      desc: '',
      args: [],
    );
  }

  /// `Changelog`
  String get aboutChangelog {
    return Intl.message(
      'Changelog',
      name: 'aboutChangelog',
      desc: '',
      args: [],
    );
  }

  /// `Build date`
  String get aboutBuildDate {
    return Intl.message(
      'Build date',
      name: 'aboutBuildDate',
      desc: '',
      args: [],
    );
  }

  /// `Git hash`
  String get aboutGitHash {
    return Intl.message('Git hash', name: 'aboutGitHash', desc: '', args: []);
  }

  /// `Package name`
  String get aboutPackage {
    return Intl.message(
      'Package name',
      name: 'aboutPackage',
      desc: '',
      args: [],
    );
  }

  /// `Build signature`
  String get aboutBuildSignature {
    return Intl.message(
      'Build signature',
      name: 'aboutBuildSignature',
      desc: '',
      args: [],
    );
  }

  /// `Build number`
  String get aboutBuildNumber {
    return Intl.message(
      'Build number',
      name: 'aboutBuildNumber',
      desc: '',
      args: [],
    );
  }

  /// `Author`
  String get aboutAuthor {
    return Intl.message('Author', name: 'aboutAuthor', desc: '', args: []);
  }

  /// `Author's website`
  String get aboutAuthorWebsite {
    return Intl.message(
      'Author\'s website',
      name: 'aboutAuthorWebsite',
      desc: '',
      args: [],
    );
  }

  /// `Licenses`
  String get licensesHeader {
    return Intl.message('Licenses', name: 'licensesHeader', desc: '', args: []);
  }

  /// `{appTitle} itself is licensed under {appLicenseHtml}.`
  String licensesAppHtml(Object appTitle, Object appLicenseHtml) {
    return Intl.message(
      '$appTitle itself is licensed under $appLicenseHtml.',
      name: 'licensesAppHtml',
      desc: '',
      args: [appTitle, appLicenseHtml],
    );
  }

  /// `Libraries`
  String get licensesLibraries {
    return Intl.message(
      'Libraries',
      name: 'licensesLibraries',
      desc: '',
      args: [],
    );
  }

  /// `Below is the list of all libraries that are directly used by {appTitle}. These libraries can use some other libraries. Tap on a library name to go to its website. Tap on a license name to read the license text online.`
  String licensesLibrariesDetailsHtml(Object appTitle) {
    return Intl.message(
      'Below is the list of all libraries that are directly used by $appTitle. These libraries can use some other libraries. Tap on a library name to go to its website. Tap on a license name to read the license text online.',
      name: 'licensesLibrariesDetailsHtml',
      desc: '',
      args: [appTitle],
    );
  }

  /// `Library`
  String get licensesHeaderLibrary {
    return Intl.message(
      'Library',
      name: 'licensesHeaderLibrary',
      desc: '',
      args: [],
    );
  }

  /// `License`
  String get licensesHeaderLicense {
    return Intl.message(
      'License',
      name: 'licensesHeaderLicense',
      desc: '',
      args: [],
    );
  }

  /// `Assets`
  String get licensesAssets {
    return Intl.message('Assets', name: 'licensesAssets', desc: '', args: []);
  }

  /// `Below is the list of all third-party assets that are directly used by {appTitle}. Some libraries that are used in {appTitle} may contain and/or use other assets. Tap on an asset name to go to its website. Tap on a license name to read the license text online.`
  String licensesAssetsHtml(Object appTitle) {
    return Intl.message(
      'Below is the list of all third-party assets that are directly used by $appTitle. Some libraries that are used in $appTitle may contain and/or use other assets. Tap on an asset name to go to its website. Tap on a license name to read the license text online.',
      name: 'licensesAssetsHtml',
      desc: '',
      args: [appTitle],
    );
  }

  /// `Asset`
  String get licensesHeaderAsset {
    return Intl.message(
      'Asset',
      name: 'licensesHeaderAsset',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
