import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../error/StaticCodeAnalysisError.dart";

abstract class AbstractPlugin {

    String userMessage;

    Reporters _reporters;

    ErrorReporter _errorReporter;

    AbstractPlugin(String this.userMessage);

    registerErrorReporter(Reporters reporters, ErrorReporter errorReporter) {
        _reporters = reporters;
        _errorReporter = errorReporter;
    }

    reportError(StaticCodeAnalysisError error) {
        _errorReporter.error(error);
        _reporters.error(error);
    }

    void init(DataEventService dataEventService);

}