import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

class CoverageFile {
  CoverageFile(this.file);

  final File file;

  String get path => file.path;

  String get packagePath => p.dirname(p.dirname(file.absolute.path));

  Stream<String> convert() {
    return LineSplitter().bind(Utf8Decoder().bind(file.openRead())).map((String line) {
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
