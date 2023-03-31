import 'package:args/command_runner.dart';
import 'package:test_checklist_generator/test_checklist_generator.dart';

Future<void> main(List<String> arguments) async {
  // Setup command line
  final runner = CommandRunner('server', 'Make checklist server')
    ..addCommand(MakeChecklistCommand());

  await runner.run(arguments);
}
