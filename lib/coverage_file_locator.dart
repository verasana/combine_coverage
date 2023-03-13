import 'dart:io';

import 'package:file/local.dart';
import 'package:glob/glob.dart';

class CoverageFileLocator {
  CoverageFileLocator(this.repoPath);

  final String repoPath;

  Stream<File> findAll({required String exclude}) {
    return Glob('**.info', recursive: true)
        .listFileSystem(LocalFileSystem(), root: repoPath)
        .where((FileSystemEntity file) => exclude != file.path)
        .map((FileSystemEntity file) => file as File);
  }
}
