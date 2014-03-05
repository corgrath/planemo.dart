import "dart:io";
import "package:path/path.dart" as path;

isSameDirectory(Directory d1, Directory d2) {

    String path1 = d1.path;
    String path2 = d2.path;

    if (!path1.endsWith(path.separator)) {
        path1 = path1 + path.separator;
    }

    if (!path2.endsWith(path.separator)) {
        path2 = path2 + path.separator;
    }

    return path1 == path2;

}