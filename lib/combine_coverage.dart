import 'dart:io';

import 'package:combine_coverage/combined_coverage_file.dart';
import 'package:combine_coverage/coverage_file.dart';
import 'package:combine_coverage/coverage_file_locator.dart';

void combineCoverage(String repoPath, String outputDirectory) async {
  Directory(outputDirectory).createSync(recursive: true);

  final coverageFileLocator = CoverageFileLocator(repoPath);
  final combinedCoverageFile = CombinedCoverageFile(outputDirectory);

  final content = (await coverageFileLocator
          .findAll(exclude: combinedCoverageFile.path)
          .map(CoverageFile.new)
          .map((CoverageFile file) {
            stdout.writeln('Found coverage file: ${file.path} with ${file.packagePath}');
            return file.convert();
          })
          .asyncExpand((Stream<String> stream) => stream)
          .toList())
      .join('\r\n');

  await combinedCoverageFile.write(content).then((_) {
    stdout.writeln('Coverage info combined successfully!');
    stdout.writeln('See combined file @ ${combinedCoverageFile.path}');
  });
}

void printHelp(String usage) {
  print("""
A CLI tool for combining Dart & Flutter code coverage reports in a monorepo.

Usage: combine_coverage [arguments]

Global options:
$usage
  """);
  exit(1);
}
