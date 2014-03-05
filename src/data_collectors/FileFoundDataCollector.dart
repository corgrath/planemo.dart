import "dart:io";

import "./AbstractDataCollector.dart";
import "./interfaces/data-event-observer-interfaces.dart";
import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../reporting/Reporters.dart";
import "../services/DataEventService.dart";

class FileFoundDataCollector extends AbstractDataCollector implements OnFileFoundObserverInterface {

    FileFoundDataCollector(Reporters reporters, DataEventService dataEventService) : super(reporters, dataEventService);

    void onFileFound(Reporters reporters, File file, String fileName) {

        reporters.verbose("Evaluating the file \"$file\".");

        if (!file.existsSync()) {
            throw new Exception("The file \"$directory\" does not exist.");
        }

        if (isJavaScriptFile(file)) {
            dataEventService.javaScriptFileFound(file);
            return;
        }

        if (isHTMLFile(file)) {
            dataEventService.HTMLFileFound(file);
            return;
        }

    }

    bool isJavaScriptFile(File file) {
        return file.path.toLowerCase().endsWith(".js");
    }

    bool isHTMLFile(File file) {
        return file.path.toLowerCase().endsWith(".html");
    }

}