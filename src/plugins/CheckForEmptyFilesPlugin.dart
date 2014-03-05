import "dart:io";
import "package:path/path.dart" as path;

import "AbstractPlugin.dart";
import "AbstractCheckFileNamePlugin.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../data_collectors/interfaces/data-event-observer-interfaces.dart";
import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../services/DataEventService.dart";

class CheckForEmptyFilesPlugin extends AbstractPlugin implements OnFileFoundObserverInterface {

    List<String> filesToIgnore;

    CheckForEmptyFilesPlugin({List<String> this.filesToIgnore, String userMessage}): super(userMessage);

    void init(DataEventService dataEventService) {
        dataEventService.registerOnFileFound(this);
    }

    void onFileFound(Reporters reporters, File file, String fileName) {

        String fullPath = file.path;

        if (filesToIgnore != null) {

            for (String fileToIgnore in filesToIgnore) {

                if (fileToIgnore == fullPath) {
                    reporters.verbose("Ignoring to see if the file \"$fullPath\" is empty.");
                    return;
                }

            }

        }

        int length = file.lengthSync();

        if (length == 0) {

            StaticCodeAnalysisError error = new StaticCodeAnalysisError("The file \"$fileName\" is empty.", userMessage);
            error.addMetaData("filename", fileName);
            error.addMetaData("fullpath", fullPath);

            reportError(error);

        }

    }

}