library AssertUtil;


import "dart:io";

abstract class AssertUtil {

    void isDirectory(String path) {
        Directory directory = new Directory(path);

        if (!directory.existsSync()) {
            throw new Exception("The directory \"$fileName\" does not exist.");
        }

       FileStat.statSync(path).is

    }


}