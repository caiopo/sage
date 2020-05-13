import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart' show StreamGroup;
import 'package:grinder/grinder.dart';

void main(List<String> args) => grind(args);

@Task('Generate dart files with build_runner (watch mode)')
gen() => _log(
      Process.start(
        'flutter',
        ['pub', 'run', 'build_runner', 'watch', '--delete-conflicting-outputs'],
      ),
    );

@Task('Generate dart files with build_runner (only once)')
gen_once() => _log(
      Process.start(
        'flutter',
        ['pub', 'run', 'build_runner', 'build'],
      ),
    );

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
  // TODO add gradle clean
}

Future<void> _log(Future<Process> proc) async {
  final process = await proc;
  final output = StreamGroup.merge([process.stdout, process.stderr]);
  await for (final message in output) {
    log(utf8.decode(message));
  }
}
