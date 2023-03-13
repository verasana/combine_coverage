import 'dart:io';

import 'package:args/args.dart';
import 'package:combine_coverage/combine_coverage.dart';
import 'package:path/path.dart' as p;

void main(List<String> arguments) {
  exitCode = 0;

  final parser = ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information',
    )
    ..addOption(
      'repo-path',
      abbr: 'p',
      mandatory: true,
      help: 'The path to the root of your monorepo',
    )
    ..addOption(
      'output-directory',
      abbr: 'o',
      mandatory: false,
      help: 'The path where you want to output the combined coverage '
          'file. Defaults to <repo-path>/coverage',
    );

  late final String repoPath;
  late final String? outputDirectory;

  try {
    final ArgResults argResults = parser.parse(arguments);
    if (argResults['help']) printHelp(parser.usage);
    repoPath = argResults['repo-path'];
    outputDirectory = argResults['output-directory'];
  } on FormatException catch (e) {
    stderr.write('$e\n\n');
    printHelp(parser.usage);
  }

  combineCoverage(repoPath, outputDirectory ?? p.join(repoPath, 'coverage'));
}
