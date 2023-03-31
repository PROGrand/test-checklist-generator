import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:test_checklist_generator/test_spec.dart';

enum _Format {
  markdown,
  pdf,
}

class MakeChecklistCommand extends Command {
  @override
  final name = "make";

  @override
  final description = "Make checklist.";

  MakeChecklistCommand() {
    argParser.addOption('format',
        abbr: 'f',
        allowed: _Format.values.map((e) => e.name),
        defaultsTo: 'markdown',
        help: 'specify format');

    argParser.addOption('input', abbr: 'i', help: 'input spec file (json)');
  }

  @override
  void run() {
    final format = _Format.values.firstWhere(
      (element) => element.name == argResults?['format'],
      orElse: () => _Format.markdown,
    );
    print(format);

    final text =
        null != argResults?['input'] ? File(argResults!['input']).readAsStringSync() : _readStdin();

    final config = TestSpec.fromJson(json.decode(text));

    print(_generate(config.variants, section: config.section));
  }

  String _readStdin() {
    var res = '';
    String? line;
    while ((line = stdin.readLineSync(encoding: utf8)) != null) {
      res += line!;
    }

    return res;
  }

  String _generate(List variants, {String? section, String prefix = '', String indent = ''}) {
    //if (null != section) stdout.writeln('$indent ');

    var ret = '$indent $section';

    for (final variant in variants) {
      if (variant is String) {
        ret += '$indent $prefix\n$indent [ ] $variant';
      } else if (variant is Map<String, dynamic>) {
        final testSpec = TestSpec.fromJson(variant);
        ret +=
            '$indent $prefix\n$indent [ ] ${_generate(testSpec.variants, section: testSpec.section, prefix: prefix, indent: '  $indent')}';
      }
    }

    return ret;
  }
}
