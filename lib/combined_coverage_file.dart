import 'dart:io';

import 'package:path/path.dart' as p;

class CombinedCoverageFile {
  CombinedCoverageFile(String outputDirectory, {String? fileName})
      : _outputDirectory = outputDirectory,
        _fileName = fileName ?? 'lcov.info';

  final String _outputDirectory;
  final String _fileName;

  File get _file => File(path);

  String get path => p.join(_outputDirectory, _fileName);

  Future<void> write(String content) => _file.writeAsString(content, mode: FileMode.write);
}
