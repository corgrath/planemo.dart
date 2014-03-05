import "dart:io";

import "package:path/path.dart" as path;
import "AbstractDataCollector.dart";
import "interfaces/data-event-observer-interfaces.dart";
import "../util/DirectoryUtilLibrary.dart" as DirectoryUtil;
import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../services/DataEventService.dart";

class DirectoryFoundDataCollector extends AbstractDataCollector implements OnDirectoryFoundObserverInterface {

    DirectoryFoundDataCollector(Reporters reporters, DataEventService dataEventService) : super(reporters, dataEventService);

    void onDirectoryFound(Reporters reporters, Directory directory, List<Directory> directoriesToIgnore) {

        reporters.verbose("Evaluating the directory \"$directory\".");

        if (!directory.existsSync()) {
            throw new Exception("The directory \"$directory\" does not exist.");
        }

        for (Directory directoryToIgnore in directoriesToIgnore) {

            //            print("0 " + directory.path);
            //            print("1 " + directoryToIgnore.path);
            if (DirectoryUtil.isSameDirectory(directory, directoryToIgnore)) {

                reporters.verbose("Ignoring to go into directory \"$directory.path\".");
                return;
            }

        }

        //        if (directory.path.contains("translate")) {
        //            print(directory);
        //            print(directoriesToIgnore);
        //            throw new Error();return;
        //        }

        //        if (directoriesToIgnore.contains(directory)) {
        //            reporters.verbose("Ignoring to go into folder \"" + newDirectory + "\" (\"" + fileService.getResolvedPath(newDirectory) + "\").");
        //            return;
        //        }

        List<FileSystemEntity> items = directory.listSync();

        for (FileSystemEntity entity in items) {

            if (entity is Directory) {

                reporters.verbose("Found the new directory \"$entity\".");

                dataEventService.directoryFound(entity, directoriesToIgnore);

            } else if (entity is File) {

                reporters.verbose("Found the file \"$entity\".");

                String fileName = path.basename(entity.path);

                dataEventService.fileFound(entity, fileName);

            } else {

                throw new Exception("Unknown type for entity \"$entity\".");

            }

        }

    }

}