import "dart:io";
import "package:path/path.dart" as path;

import "AbstractPlugin.dart";
import "AbstractCheckFileNamePlugin.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../datacollectors/interfaces/data-event-observer-interfaces.dart";
import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../services/DataEventService.dart";

class CheckForEmptyDirectoriesPlugin extends AbstractPlugin implements OnDirectoryFoundObserverInterface {

    CheckForEmptyDirectoriesPlugin({String userMessage}): super(userMessage);

    void init(DataEventService dataEventService) {
        dataEventService.registerOnDirectoryFound(this);
    }

    onDirectoryFound(Reporters reporters, Directory directory, List<Directory> directoriesToIgnore) {

        String fileName = path.basename(directory.path);
        String fullPath = directory.path;

        List<FileSystemEntity> items = directory.listSync();

        if (items.isEmpty) {

            StaticCodeAnalysisError error = new StaticCodeAnalysisError("The directory \"$fileName\" isEmpty.", userMessage);
            error.addMetaData("filename", fileName);
            error.addMetaData("fullpath", fullPath);

            reportError(error);

        }

    }

}