// SPDX-License-Identifier: MPL-2.0

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'generated/l10n.dart';

class _Tab {
  final String Function(BuildContext) label;
  final IconData icon;
  final Future<String> Function(BuildContext) htmlFunc;
  Future<String>? _html;

  _Tab({
    required this.label,
    required this.icon,
    required this.htmlFunc
  });

  Future<String> html(BuildContext context) {
    var result = _html ??= htmlFunc(context);
    return result;
  }
}

String _esc(String s) {
  return const HtmlEscape().convert(s);
}

class _KeyValRow {
  final String key;
  final String? keyLink;
  final String val;
  final String? valLink;

  _KeyValRow({
    required this.key,
    this.keyLink,
    required this.val,
    this.valLink
  });

  static String renderLink(String text, String? link) {
    if(link == null)
      return _esc(text);
    return '<a href="${_esc(link)}">${_esc(text)}</a>';
  }

  static String renderRows(List<_KeyValRow> rows) {
    return rows.map((row) {
      return '<tr><td>${renderLink(row.key, row.keyLink)}</td><td>${renderLink(row.val, row.valLink)}</td></tr>';
    }).join();
  }

  static String renderParagraphs(List<_KeyValRow> rows) {
    return rows.map((row) {
      return '<strong style="font-size: 16px">${renderLink(row.key, row.keyLink)}:</strong>'
        '<div style="padding-bottom: 20px">${renderLink(row.val, row.valLink)}</div>';
    }).join();
  }
}

enum HelpPageLicense {
  gpl3('GPLv3', 'https://www.gnu.org/licenses/gpl-3.0.txt'),
  mpl2('MPL 2.0', 'https://www.mozilla.org/en-US/MPL/2.0/'),
  bsd2('BSD 2-Clause', 'https://opensource.org/licenses/BSD-2-Clause'),
  bsd3('BSD 3-Clause', 'https://opensource.org/licenses/BSD-3-Clause'),
  mit('MIT', 'https://opensource.org/licenses/MIT'),
  apache2('Apache License 2.0', 'https://www.apache.org/licenses/LICENSE-2.0.txt'),
  ccZero1('CC0 1.0 Universal', 'https://creativecommons.org/publicdomain/zero/1.0/legalcode'),
  ;

  final String name;
  final String url;
  const HelpPageLicense(this.name, this.url);
}

class HelpPagePackage {
  const HelpPagePackage({
    required this.name,
    required this.url,
    required this.licenseName,
    required this.licenseUrl
  });

  final String name;
  final String url;
  final String licenseName;
  final String licenseUrl;

  HelpPagePackage.foss({
    required this.name,
    required this.url,
    required HelpPageLicense license
  }):
    licenseName = license.name,
    licenseUrl = license.url;

  HelpPagePackage.flutter(this.name, HelpPageLicense license) :
    url = 'https://pub.dev/packages/$name',
    licenseName = license.name,
    licenseUrl = license.url;

  _KeyValRow _toKeyValRow() {
    return _KeyValRow(
      key: name,
      keyLink: url,
      val: licenseName,
      valLink: licenseUrl
    );
  }
}

//////

class HelpPage extends StatefulWidget {
  const HelpPage({
    required this.appTitle,
    required this.githubAuthor,
    required this.githubProject,
    this.githubBranch = 'master',
    required this.manualHtml,
    this.manualHtmlWidgets = const {},
    this.changelogFilename = 'CHANGELOG.md',
    this.showGooglePlayLink = false,
    this.showGitHubReleasesLink = false,
    required this.license,
    this.author = '',
    this.authorWebsite = '',
    required this.libraries,
    required this.assets
  });

  final String appTitle;
  final String githubAuthor;
  final String githubProject;
  final String githubBranch;
  final String manualHtml;
  final Map<String, Widget> manualHtmlWidgets;
  final String changelogFilename;
  final bool showGooglePlayLink;
  final bool showGitHubReleasesLink;
  final HelpPageLicense license;
  final String author;
  final String authorWebsite;
  final List<HelpPagePackage> libraries;
  final List<HelpPagePackage> assets;

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  var selectedIndex = 0;

  var pageController = PageController(
    initialPage: 0,
    keepPage: true
  );
  var indexValue = ValueNotifier(0);

  late var tabs = [
    _manualTab(),
    _aboutTab(),
    _licensesTab()
  ];

  String get appBaseUrl => 'https://github.com/${widget.githubAuthor}/${widget.githubProject}';

  static const appBuildTimestamp = int.fromEnvironment('APP_BUILD_TIMESTAMP');
  static const appGitHash = String.fromEnvironment('APP_GIT_HASH');

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      delegates: const [
        S.delegate,
        ...GlobalMaterialLocalizations.delegates
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.appTitle)
        ),
        body: SafeArea(
          child: Center(
            child: PageView.builder(
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  key: PageStorageKey('help-tab:$index'),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: FutureBuilder<String>(
                    future: tabs[index].html(context),
                      builder: (context, htmlData) {
                        var html = htmlData.data;
                        if(html == null)
                          return const CircularProgressIndicator();
                        return HtmlWidget(
                          html,
                          onTapUrl: (url) async {
                            if(!await canLaunchUrlString(url))
                              return false;
                            await launchUrlString(url, mode: LaunchMode.externalApplication);
                            return true;
                          },
                          customStylesBuilder: (element) {
                            if(element.localName == 'ul')
                              return {'padding-left': '15px'};
                            return null;
                          },
                          customWidgetBuilder: (element) {
                            if(element.localName == 'widget') {
                              var name = element.attributes['name']!;
                              var inlineWidget = widget.manualHtmlWidgets[name]!;
                              return InlineCustomWidget(
                                alignment: PlaceholderAlignment.middle,
                                child: inlineWidget
                              );
                            }
                            return null;
                          },
                        );
                      }
                    )
                  )
                );
              },
              itemCount: tabs.length,
              controller: pageController,
              onPageChanged: (value) {
                indexValue.value = value;
              }
            )
          )
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: indexValue,
          builder: (context, int value, child) {
            return BottomNavigationBar(
              items: tabs.map((tab) => BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.label(context)
              )).toList(),
              currentIndex: value,
              onTap: (newIndex) {
                pageController.animateToPage(
                  newIndex,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear
                );
              }
            );
          }
        )
      )
    );
  }

  _Tab _manualTab() {
    return _Tab(
      label: (context) => S.of(context).manualHeader,
      icon: Icons.menu_book,
      htmlFunc: (context) async => '<h1 style="text-align: center">${_esc(S.of(context).manualHeader)}</h1>\n${widget.manualHtml}'
    );
  }

  _Tab _aboutTab() {
    return _Tab(
      label: (context) => S.of(context).aboutHeader,
      icon: Icons.info,
      htmlFunc: (context) async {
        var info = await PackageInfo.fromPlatform();
        String? buildStr;
        if(appBuildTimestamp != 0) {
          var buildDate = DateTime.fromMillisecondsSinceEpoch(appBuildTimestamp * 1000);
          buildStr = DateFormat.yMMMMd().format(buildDate);
        }

        return '''
          <h1 style="text-align: center">${_esc(widget.appTitle)}</h1>
          <div style="text-align: center; padding-bottom: 50"><strong><em>v${_esc(info.version)}</em></strong></div>
          ${_KeyValRow.renderParagraphs([
            _KeyValRow(key: S.of(context).aboutWebsite, val: appBaseUrl, valLink: appBaseUrl),
            if(widget.showGooglePlayLink)
              _KeyValRow(key: S.of(context).aboutGooglePlay, val: 'https://play.google.com/store/apps/details?id=${info.packageName}', valLink: 'https://play.google.com/store/apps/details?id=${info.packageName}'),
            if(widget.showGitHubReleasesLink)
              _KeyValRow(key: S.of(context).aboutGitHubReleases, val: '$appBaseUrl/releases', valLink: '$appBaseUrl/releases'),
            _KeyValRow(key: S.of(context).aboutBug, val: '$appBaseUrl/issues', valLink: '$appBaseUrl/issues'),
            _KeyValRow(key: S.of(context).aboutChangelog, val: '$appBaseUrl/blob/${widget.githubBranch}/${widget.changelogFilename}', valLink: '$appBaseUrl/blob/master/${widget.changelogFilename}'),
            if(buildStr != null)
              _KeyValRow(key: S.of(context).aboutBuildDate, val: buildStr),
            if(appGitHash.isNotEmpty)
              _KeyValRow(key: S.of(context).aboutGitHash, val: appGitHash, valLink: '$appBaseUrl/tree/$appGitHash'),
            _KeyValRow(key: S.of(context).aboutPackage, val: info.packageName),
            _KeyValRow(key: S.of(context).aboutBuildSignature, val: info.buildSignature),
            _KeyValRow(key: S.of(context).aboutBuildNumber, val: info.buildNumber),
            if(widget.author.isNotEmpty)
              _KeyValRow(key: S.of(context).aboutAuthor, val: widget.author),
            if(widget.authorWebsite.isNotEmpty)
              _KeyValRow(key: S.of(context).aboutAuthorWebsite, val: widget.authorWebsite, valLink: widget.authorWebsite)
          ])}
        ''';
      }
    );
  }

  _Tab _licensesTab() {
    return _Tab(
      label: (context) => S.of(context).licensesHeader,
      icon: Icons.copyright,
      htmlFunc: (context) async => '''
        <h1 style="text-align: center">${_esc(S.of(context).licensesHeader)}</h1>

        <p>${S.of(context).licensesAppHtml(_esc(widget.appTitle), _KeyValRow.renderLink(widget.license.name, widget.license.url))}</p>

        <h2>${_esc(S.of(context).licensesLibraries)}</h2>
        <p>${S.of(context).licensesLibrariesDetailsHtml(_esc(widget.appTitle))}</p>

        <table>
          <thead>
            <tr>
              <th>${_esc(S.of(context).licensesHeaderLibrary)}</th>
              <th>${_esc(S.of(context).licensesHeaderLicense)}</th>
            </tr>
          </thead>
          <tbody>
          ${_KeyValRow.renderRows([
            HelpPagePackage.foss(name: 'Flutter', url: 'https://flutter.dev', license: HelpPageLicense.bsd3),
            ...widget.libraries,
            HelpPagePackage.foss(name: 'flutter_help_page', url: 'https://github.com/z80maniac/flutter_help_page', license: HelpPageLicense.mpl2)
          ].map((package) => package._toKeyValRow()).toList())}
          </tbody>
        </table>

        <h2>${_esc(S.of(context).licensesAssets)}</h2>
        <p>${S.of(context).licensesAssetsHtml(_esc(widget.appTitle))}</p>

        <table>
          <thead>
            <tr>
              <th>${_esc(S.of(context).licensesHeaderAsset)}</th>
              <th>${_esc(S.of(context).licensesHeaderLicense)}</th>
            </tr>
          </thead>
          <tbody>
          ${_KeyValRow.renderRows([
            HelpPagePackage.foss(name: 'Material design icons', url: 'https://developers.google.com/fonts/docs/material_icons', license: HelpPageLicense.bsd3),
            ...widget.assets
          ].map((package) => package._toKeyValRow()).toList())}
          </tbody>
        </table>
      '''
    );
  }
}
