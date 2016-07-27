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

library DefaultJUnitTestReporter;

import "dart:io";
import "dart:convert";

import "Reporter.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../reporting/ErrorReporter.dart";

class DefaultJUnitTestReporter implements Reporter {

    bool verbosed;

    String _resultsFile;

    HtmlEscape _htmlEscaper;

    DefaultJUnitTestReporter(String this._resultsFile, {bool this.verbosed: false}) {
        _htmlEscaper = new HtmlEscape();

        verbose("Default JUnit test report created. Path to save the result is \"$_resultsFile\".");
    }

    /*
     * Reporting functions
     */

    void start(String version) {
    }

    void verbose(String message) {
        if (verbosed) {
            print(message);
        }
    }

    void error(StaticCodeAnalysisError error) {
    }

    void done(ErrorReporter errorReporter, int executionDuration) {
        var numberOfErrors = errorReporter
            .getErrors()
            .length;

        String xml = "<testsuite tests=\"$numberOfErrors\">\n";

        for (StaticCodeAnalysisError error in errorReporter.getErrors()) {
            String message = _encode(error.getMessage());
            Map<String, String> metaData = error.getMetaData();

            String details = "";

            if (error.getUserMessage() != null) {
                details += _encode("${error.getUserMessage()}\n");
            }

            for (String data in metaData.keys) {
                details += _encode("${data}=${metaData[data]}\n");
            }

            xml += "\t<testcase classname=\"Planemo\" name=\"$message\">\n";
            xml += "\t\t<failure>$details</failure>\n";
            xml += "\t</testcase>\n";
        }

        xml += "</testsuite>";

        // Save the file
        verbose("Writing JUnit test report to \"$_resultsFile\".");
        new File(_resultsFile).writeAsStringSync(xml);
    }

    _encode(String s) {
        return _htmlEscaper.convert(s);
    }

}