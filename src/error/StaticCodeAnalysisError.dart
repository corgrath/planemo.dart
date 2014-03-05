class StaticCodeAnalysisError {

    String _message;

    String _userMessage;

    Map<String, String> _metaData;

    StaticCodeAnalysisError(String this._message, String this._userMessage) {
        _metaData = new Map<String, String>();
    }

    String getMessage() {
        return _message;
    }

    String getUserMessage() {
        return _userMessage;
    }

    void addMetaData(String name, String value) {
        _metaData[name] = value;
    }

    Map<String, String> getMetaData() {
        return _metaData;
    }

}