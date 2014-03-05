abstract class Reporter {

    void start(String version);

    void verbose(String message);

    void error(StaticCodeAnalysisError error);

    void done(ErrorReporter errorReporter, int executionDuration);

}