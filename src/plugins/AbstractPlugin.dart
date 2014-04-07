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