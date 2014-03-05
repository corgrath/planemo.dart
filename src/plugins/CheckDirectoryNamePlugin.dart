import "dart:io";
import "package:path/path.dart" as path;

import "AbstractPlugin.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../data_collectors/interfaces/data-event-observer-interfaces.dart";
import "../reporting/ErrorReporter.dart";
import "../reporting/Reporters.dart";
import "../services/DataEventService.dart";

class CheckDirectoryNamePlugin extends AbstractPlugin implements OnDirectoryFoundObserverInterface {

    String pattern;

    CheckDirectoryNamePlugin({String this.pattern: "^[a-z|-]+\$", String userMessage:""}): super(userMessage);

    void init(DataEventService dataEventService) {
        dataEventService.registerOnDirectoryFound(this);
    }

    void onDirectoryFound(Reporters reporters, Directory directory, List<Directory> directoriesToIgnore) {

        String fileName = path.basename(directory.path);
        String fullPath = directory.path;

        RegExp expression = new RegExp(pattern);

        Iterable<Match> matches = expression.allMatches(fileName);

        if (matches.isEmpty) {

            StaticCodeAnalysisError error = new StaticCodeAnalysisError("The directory name \"$fileName\" is not valid as it does not comply with the pattern \"$pattern\".", userMessage);
            error.addMetaData("filename", fileName);
            error.addMetaData("fullpath", fullPath);
            error.addMetaData("pattern", pattern);

            reportError(error);

        }

    }

}