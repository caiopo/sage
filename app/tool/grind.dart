import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart' show StreamGroup;
import 'package:grinder/grinder.dart';

void main(List<String> args) => grind(args);

@Task('Generate dart files with build_runner (watch mode)')
gen() => flutter([
      'pub',
      'run',
      'build_runner',
      'watch',
      '--delete-conflicting-outputs',
      '--verbose',
    ]);

@Task('Generate dart files with build_runner (only once)')
gen_once() => flutter([
      'pub',
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs',
      '--verbose',
    ]);

// TODO
@Task('Run dart analyzer')
lint() {}

// TODO
@Task('Run tests')
test() {}

@Task('Delete build outputs and intemediate files')
clean() {
  defaultClean();
  delete(Directory('.dart_tool'));
  flutter(['pub', 'get']);
}

Future<void> _log(Future<Process> proc) async {
  final process = await proc;
  final output = StreamGroup.merge([process.stdout, process.stderr]);
  await for (final message in output) {
    log(utf8.decode(message));
  }
}

Future<void> flutter(List<String> subcommands) {
  return _log(
    Process.start(
      'flutter',
      subcommands,
    ),
  );
}
