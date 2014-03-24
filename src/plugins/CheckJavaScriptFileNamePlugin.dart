import "dart:io";
import "package:path/path.dart" as path;

import "AbstractCheckFileNamePlugin.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../data_collectors/interfaces/data-event-observer-interfaces.dart";
import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../services/DataEventService.dart";

class CheckJavaScriptFileNamePlugin extends AbstractCheckFileNamePlugin implements OnJavaScriptFileFoundObserverInterface {

    CheckJavaScriptFileNamePlugin(String pattern, { String userMessage}): super(pattern, userMessage);

    void init(DataEventService dataEventService) {
        dataEventService.registerOnJavaScriptFileFound(this);
    }

    void onJavaScriptFileFound(Reporters reporters, File file) {
        checkFileName(reporters, file);
    }

}