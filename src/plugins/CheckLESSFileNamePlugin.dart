import "dart:io";
import "package:path/path.dart" as path;

import "AbstractCheckFileNamePlugin.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../data_collectors/interfaces/data-event-observer-interfaces.dart";
import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../services/DataEventService.dart";

class CheckLESSFileNamePlugin extends AbstractCheckFileNamePlugin implements OnLESSFileFoundObserverInterface {

    CheckLESSFileNamePlugin({String pattern: "^[a-z|-]+\\.less\$", String userMessage}): super(pattern, userMessage);

    void init(DataEventService dataEventService) {
        dataEventService.registerOnLESSFileFound(this);
    }

    void onLESSFileFound(Reporters reporters, File file) {
        checkFileName(reporters, file);
    }

}