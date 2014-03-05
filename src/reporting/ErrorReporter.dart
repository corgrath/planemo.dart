import "Reporters.dart";
import "../error/StaticCodeAnalysisError.dart";

class ErrorReporter {

    List<StaticCodeAnalysisError> _errors;

    ErrorReporter() {
        _errors = new List<StaticCodeAnalysisError>();
    }

    void error(StaticCodeAnalysisError error) {
        _errors.add(error);
    }

    List<StaticCodeAnalysisError> getErrors() {
        return _errors;
    }

}