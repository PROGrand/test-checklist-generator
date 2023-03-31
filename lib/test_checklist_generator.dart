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

  List<List<String>> tests = [];

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

    tests.clear();

    final node = StepNode(config.section, _makeSteps(config, 0));

    final output = <String>[];
    printAllPathToLeafNonRecursive(node, output);

    output.sort();

    print(output.mapIndexed((i, e) => '### ${i + 1}. $e').join('\n'));
  }

  String _readStdin() {
    var res = '';
    String? line;
    while ((line = stdin.readLineSync(encoding: utf8)) != null) {
      res += line!;
    }

    return res;
  }

  static void printAllPathToLeafNonRecursive(Node root, List<String> output) {
    List q = [];
    q.add(root);
    q.add(root.displayString);
    q.add('  ');

    while (q.isNotEmpty) {
      Node head = q.removeAt(0);
      String headPath = q.removeAt(0);
      String prefix = q.removeAt(0);

      if (head.isLeaf) {
        output.add(headPath);
        continue;
      }

      final hasMultipleLeafs = (head.leafs?.length ?? 0) > 1;

      for (final leaf in head.leafs!) {
        q.add(leaf);
        q.add('$headPath${hasMultipleLeafs ? ' ' : prefix}${leaf.displayString}');
        q.add('$prefix${hasMultipleLeafs ? '  ' : ''}');
      }
    }
  }

  List<Node>? _makeSteps(specIn, int level) {
    if (null == specIn) {
      return null;
    }

    final spec = specIn is Map<String, dynamic> ? TestSpec.fromJson(specIn) : specIn;

    if (spec is! TestSpec) {
      //return [TextNode(spec)];
      return null;
    }

    final steps = spec.steps;

    if (null == steps || level >= steps.length) {
      return null;
    }

    final step = steps[level];

    final leafs = _makeSteps(spec, level + 1);

    if (step is Map<String, dynamic>) {
      final stepSpec = TestSpec.fromJson(step);

      if (stepSpec.steps?.isNotEmpty ?? false) {
        return [StepNode(stepSpec.section, _makeSteps(stepSpec, 0))..appendLeafs(leafs)];
      } else if (stepSpec.variants?.isNotEmpty ?? false) {
        return [
          VariantSectionNode(
              stepSpec.section,
              stepSpec.variants!
                  .mapIndexed<Node>((index, variant) => VariantNode(
                        index,
                        _specName(variant),
                        _makeSteps(variant, 0),
                      )..appendLeafs(leafs))
                  .toList())
        ];
      } else {
        return [TextNode(stepSpec.section)..leafs = leafs];
      }
    } else {
      return [TextNode(step)..leafs = leafs];
    }
  }

  String _specName(variant) => (variant is Map<String, dynamic>)
      ? TestSpec.fromJson(variant).section ?? ''
      : variant.toString();
}

class TextNode extends Node {
  TextNode(super.data);

  @override
  // TODO: implement displayString
  get displayString => '$data\n';
}

class StepNode extends Node {
  StepNode(super.data, super.leafs);

  @override
  get displayString => data;
}

class VariantSectionNode extends Node {
  VariantSectionNode(super.data, super.leafs);

  @override
  get displayString => '$data:';
}

class VariantNode extends Node {
  final int index;

  VariantNode(this.index, super.data, super.leafs);

  @override
  get displayString => '$data\n';
}

abstract class Node {
  final dynamic data;
  List<Node>? leafs;

  Node(this.data, [this.leafs]);

  bool get isLeaf => leafs?.isEmpty ?? true;

  get displayString;

  void appendLeafs(List<Node>? nodes) {
    List<Node> leafs = getLeafs(<Node>[]);

    for (final leaf in leafs) {
      leaf.leafs = nodes;
    }
  }

  List<Node> getLeafs(List<Node> leafs) {
    if (isLeaf) {
      leafs.add(this);
      return leafs;
    }

    for (final leaf in this.leafs!) {
      leafs = leaf.getLeafs(leafs);
    }

    return leafs;
  }
}

extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but the callback has index as second argument
  Iterable<T> mapIndexed<T>(T Function(int i, E e) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }

  void forEachIndexed(void Function(E e, int i) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }
}
