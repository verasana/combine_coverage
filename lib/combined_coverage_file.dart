import 'dart:io';

import 'package:path/path.dart' as p;

/// The file where all monorepo coverage files will be merged.
class CombinedCoverageFile {
  /// The resulting [fileName] is `lcov.info` by default, but the file name can
  /// be optionally overridden.
  ///
  /// The file is written to the [outputDirectory].
  CombinedCoverageFile(String outputDirectory, {String? fileName})
      : _outputDirectory = outputDirectory,
        _fileName = fileName ?? 'lcov.info';

  final String _outputDirectory;
  final String _fileName;

  File get _file => File(path);

  /// The full path to the file
  String get path => p.join(_outputDirectory, _fileName);

  /// Writes the provided [content] to the file location
  Future<void> write(String content) =>
      _file.writeAsString(content, mode: FileMode.write);
}
