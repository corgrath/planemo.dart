/*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*
* See the NOTICE file distributed with this work for additional
* information regarding copyright ownership.
*/

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