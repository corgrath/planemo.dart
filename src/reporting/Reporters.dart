import "Reporter.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../reporting/ErrorReporter.dart";

class Reporters implements Reporter {

    List<Reporter> _reporters;

    Reporters(List<Reporter> this._reporters);

    void start(String version) {
        _reporters.forEach((reporter) => reporter.start(version));
    }

    void verbose(String message) {
        _reporters.forEach((reporter) => reporter.verbose(message));
    }

    void error(StaticCodeAnalysisError error) {
        _reporters.forEach((reporter) => reporter.error(error));
    }

    void done(ErrorReporter errorReporter, int executionDuration) {
        _reporters.forEach((reporter) => reporter.done(errorReporter, executionDuration));
    }

}