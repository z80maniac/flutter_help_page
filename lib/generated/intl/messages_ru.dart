// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(appTitle, appLicenseHtml) =>
      "${appTitle} лицензирован под ${appLicenseHtml}.";

  static String m1(appTitle) =>
      "Ниже представлен список всех сторонних ресурсов, которые напрямую используются в ${appTitle}. Некоторые библиотеки, используемые в ${appTitle} могут содержать и/или использовать другие ресурсы. Нажмите на название ресурса, чтобы перейти на его сайт. Нажмите на название лицензии, чтобы прочитать её текст в интернете.";

  static String m2(appTitle) =>
      "Ниже представлен список всех библиотек, которые напрямую используются в ${appTitle}. Эти библиотеки могут в свою очередь использовать другие библиотеки. Нажмите на название библиотеки, чтобы перейти на её сайт. Нажмите на название лицензии, чтобы прочитать её текст в интернете.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutAuthor": MessageLookupByLibrary.simpleMessage("Автор"),
        "aboutAuthorWebsite":
            MessageLookupByLibrary.simpleMessage("Сайт автора"),
        "aboutBug": MessageLookupByLibrary.simpleMessage("Сообщить об ошибке"),
        "aboutBuildDate": MessageLookupByLibrary.simpleMessage("Дата сборки"),
        "aboutBuildNumber":
            MessageLookupByLibrary.simpleMessage("Номер сборки"),
        "aboutBuildSignature":
            MessageLookupByLibrary.simpleMessage("Сигнатура сборки"),
        "aboutChangelog":
            MessageLookupByLibrary.simpleMessage("Список изменений"),
        "aboutGitHash":
            MessageLookupByLibrary.simpleMessage("Хэш коммита в git"),
        "aboutGooglePlay":
            MessageLookupByLibrary.simpleMessage("Страница на Google Play"),
        "aboutHeader": MessageLookupByLibrary.simpleMessage("О программе"),
        "aboutPackage": MessageLookupByLibrary.simpleMessage("Имя пакета"),
        "aboutWebsite": MessageLookupByLibrary.simpleMessage("Сайт"),
        "licensesAppHtml": m0,
        "licensesAssets": MessageLookupByLibrary.simpleMessage("Ресурсы"),
        "licensesAssetsHtml": m1,
        "licensesHeader": MessageLookupByLibrary.simpleMessage("Лицензии"),
        "licensesHeaderAsset": MessageLookupByLibrary.simpleMessage("Ресурс"),
        "licensesHeaderLibrary":
            MessageLookupByLibrary.simpleMessage("Библиотека"),
        "licensesHeaderLicense":
            MessageLookupByLibrary.simpleMessage("Лицензия"),
        "licensesLibraries": MessageLookupByLibrary.simpleMessage("Библиотеки"),
        "licensesLibrariesDetailsHtml": m2,
        "manualHeader": MessageLookupByLibrary.simpleMessage("Руководство")
      };
}
