import 'dart:io';

import 'package:file/local.dart';
import 'package:glob/glob.dart';

/// A utility class for locating all of the coverage files in a monorepo.
class CoverageFileLocator {
  /// Accepts a [repoPath] to search for coverage files.
  CoverageFileLocator(this.repoPath);

  /// The root path of your monorepo.
  final String repoPath;

  /// Finds all `.info` files in the repo and returns them as a [Stream].
  ///
  /// [exclude] parameter is used to ignore the combined file.
  Stream<File> findAll({required String exclude}) {
    return Glob('**.info', recursive: true)
        .listFileSystem(LocalFileSystem(), root: repoPath)
        .where((FileSystemEntity file) => exclude != file.path)
        .map((FileSystemEntity file) => file as File);
  }
}
