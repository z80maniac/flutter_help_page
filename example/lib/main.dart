// SPDX-License-Identifier: GPL-3.0-only

import 'package:flutter/material.dart';

import 'package:help_page/help_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Help page example',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      home: HelpPage(
        appTitle: 'Help Page Test',
        githubAuthor: 'z80maniac',
        githubProject: 'flutter_help_page',
        manualHtml: '''
          <p>Hello, world!</p>
          <p>I feel the <icon code="${Icons.ac_unit.codePoint}"></icon> in northern winds.</p>
        ''',
        license: HelpPageLicense.gpl,
        author: 'Алексей Парфёнов (Alexey Parfenov) aka ZXED',
        authorWebsite: 'https://alkatrazstudio.net/',
        libraries: [
          HelpPagePackage.foss(name: 'help_page', url: 'https://github.com/z80maniac/flutter_help_page', license: HelpPageLicense.mpl),
          HelpPagePackage.flutter('flutter_lints', HelpPageLicense.bsd3),
          const HelpPagePackage(name: 'CustomLib', url: 'https://example.com', licenseName: 'CustomLicense', licenseUrl: 'https://example.com')
        ],
        assets: const []
      )
    );
  }
}
