import "dart:io";
import "package:path/path.dart" as path;

import "AbstractPlugin.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../data_collectors/interfaces/data-event-observer-interfaces.dart";
import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../error/StaticCodeAnalysisError.dart";

abstract class AbstractCheckFileNamePlugin extends AbstractPlugin {

    String pattern;

    AbstractCheckFileNamePlugin(String this.pattern, String userMessage): super(userMessage);

    void checkFileName(Reporters reporters, File file) {

        String fileName = path.basename(file.path);
        String fullPath = file.path;

        RegExp expression = new RegExp(pattern);
        Iterable<Match> matches = expression.allMatches(fileName);

        if (matches.isEmpty) {

            StaticCodeAnalysisError error = new StaticCodeAnalysisError("The file name \"$fileName\" is not valid as it does not comply with the pattern \"$pattern\".", userMessage);
            error.addMetaData("filename", fileName);
            error.addMetaData("fullpath", fullPath);

            reportError.error(error);

        }

    }

}