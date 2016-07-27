library AssertUtil;

import "dart:io";

import "package:path/path.dart" as pathLib;

abstract class AssertUtil {

    static void shouldBeDirectory(String path) {
        Directory directory = new Directory(path);

        if (!directory.existsSync()) {
            throw new Exception("The directory \"${pathLib.absolute(path)}\" does not exist.");
        }

        if (!FileSystemEntity.isDirectorySync(path)) {
            throw new Exception("The path \"${pathLib.absolute(path)}\" is not a directory.");
        }
    }


}