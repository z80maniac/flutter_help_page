// SPDX-License-Identifier: MPL-2.0

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  gpl('GPLv3', 'https://www.gnu.org/licenses/gpl-3.0.txt'),
  mpl('MPL 2.0', 'https://www.mozilla.org/en-US/MPL/2.0/'),
  bsd2('BSD 2-Clause', 'https://opensource.org/licenses/BSD-2-Clause'),
  bsd3('BSD 3-Clause', 'https://opensource.org/licenses/BSD-3-Clause'),
  mit('MIT', 'https://opensource.org/licenses/MIT'),
  apache2('Apache License 2.0', 'https://www.apache.org/licenses/LICENSE-2.0.txt'),
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
    this.changelogFilename = 'CHANGELOG.md',
    this.showGooglePlayLink = false,
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
  final String changelogFilename;
  final bool showGooglePlayLink;
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle)
      ),
      body: Center(
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
                        if(element.localName == 'icon' && element.attributes.containsKey('code')) {
                          var code = int.tryParse(element.attributes['code'] ?? '') ?? 0;
                          return InlineCustomWidget(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(IconData(code, fontFamily: 'MaterialIcons')),
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
    );
  }

  _Tab _manualTab() {
    return _Tab(
      label: (context) => 'Manual',
      icon: Icons.menu_book,
      htmlFunc: (context) async => '<h1 style="text-align: center">Manual</h1>\n${widget.manualHtml}'
    );
  }

  _Tab _aboutTab() {
    return _Tab(
      label: (context) => 'About',
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
            _KeyValRow(key: 'Website', val: appBaseUrl, valLink: appBaseUrl),
            if(widget.showGooglePlayLink)
              _KeyValRow(key: 'Google Play page', val: 'https://play.google.com/store/apps/details?id=${info.packageName}', valLink: 'https://play.google.com/store/apps/details?id=${info.packageName}'),
            _KeyValRow(key: 'File a bug report', val: '$appBaseUrl/issues', valLink: '$appBaseUrl/issues'),
            _KeyValRow(key: 'Changelog', val: '$appBaseUrl/blob/${widget.githubBranch}/${widget.changelogFilename}', valLink: '$appBaseUrl/blob/master/${widget.changelogFilename}'),
            if(buildStr != null)
              _KeyValRow(key: 'Build date', val: buildStr),
            if(appGitHash.isNotEmpty)
              _KeyValRow(key: 'Git hash', val: appGitHash, valLink: '$appBaseUrl/tree/$appGitHash'),
            _KeyValRow(key: 'Package name', val: info.packageName),
            _KeyValRow(key: 'Build signature', val: info.buildSignature),
            _KeyValRow(key: 'Build number', val: info.buildNumber),
            if(widget.author.isNotEmpty)
              _KeyValRow(key: 'Author', val: widget.author),
            if(widget.authorWebsite.isNotEmpty)
              _KeyValRow(key: "Author's website", val: widget.authorWebsite, valLink: widget.authorWebsite)
          ])}
        ''';
      }
    );
  }

  _Tab _licensesTab() {
    return _Tab(
      label: (context) => 'Licenses',
      icon: Icons.copyright,
      htmlFunc: (context) async => '''
        <h1 style="text-align: center">Licenses</h1>
  
        <p>${_esc(widget.appTitle)} itself is licensed under ${_KeyValRow.renderLink(widget.license.name, widget.license.url)}</p>
  
        <h2>Libraries</h2>
        <p>
          Below is the list of all libraries that are directly used by ${_esc(widget.appTitle)}.
          These libraries can use some other libraries.
          Tap on a library name to go to its website.
          Tap on a license name to read the license text online.
        </p>
  
        <table>
          <thead>
            <tr>
              <th>Library</th>
              <th>License</th>
            </tr>
          </thead>
          <tbody>
          ${_KeyValRow.renderRows([
            HelpPagePackage.foss(name: 'Flutter', url: 'https://flutter.dev', license: HelpPageLicense.bsd3),
            ...widget.libraries
          ].map((package) => package._toKeyValRow()).toList())}
          </tbody>
        </table>
  
        <h2>Assets</h2>
        <p>
          Below is the list of all assets that are directly used by ${_esc(widget.appTitle)}.
          Some libraries that are used in ${_esc(widget.appTitle)} may contain and/or use other assets.
          Tap on an asset name to go to its website. Tap on a license name to read the license text online.
        </p>
  
        <table>
          <thead>
            <tr>
              <th>Asset</th>
              <th>License</th>
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
