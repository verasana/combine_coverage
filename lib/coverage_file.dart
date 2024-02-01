import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

/// A class that represents the individual coverage files in the monorepo.
class CoverageFile {
  /// An instance of a coverage file in the monorepo. Requires a [File].
  CoverageFile(this.file);

  /// The coverage [file] instance
  final File file;

  /// The [path] to the coverage [file].
  String get path => file.path;

  /// The absolute [packagePath] where this coverage file exists.
  String get packagePath => p.dirname(p.dirname(file.absolute.path));

  /// [convert] the [CoverageFile] contents to standardize how paths are
  /// represented.
  ///
  /// This normalizes the paths in coverage reports from Dart and Flutter
  /// projects.
  Stream<String> convert() {
    return LineSplitter()
        .bind(Utf8Decoder().bind(file.openRead()))
        .map((String line) {
      // If the line does not require processing
      if (!line.startsWith('SF:')) {
        return line;
      }
      final thisPath = line.substring(3);
      final resolvedPath = !p.isAbsolute(thisPath) //
          ? p.join(packagePath, thisPath)
          : thisPath;
      return 'SF:$resolvedPath';
    });
  }
}
