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

library AbstractDisallowFileContentsPlugin;

import "dart:io";

import "AbstractPlugin.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../reporting/Reporters.dart";

abstract class AbstractEnforceFileContentsPlugin extends AbstractPlugin {

    final String _enforceContentPattern;
    final String matchingFilesPattern;
    final String ignoreFilesPattern;

    AbstractEnforceFileContentsPlugin(String this._enforceContentPattern, {String this.matchingFilesPattern: null, String this.ignoreFilesPattern: null, String userMessage: null}) : super(userMessage);

    void checkFileContents(Reporters reporters, File file, String fileName, String fileContents, List<String> fileContentRows) {
        if (matchingFilesPattern != null) {
            RegExp regexpMatchingFilesPattern = new RegExp(matchingFilesPattern, caseSensitive: false);

            if (!file.path.contains(regexpMatchingFilesPattern)) {
                return;
            }
        }

        if (ignoreFilesPattern != null) {
            RegExp regexpIgnoreFilesPattern = new RegExp(ignoreFilesPattern, caseSensitive: false);

            if (file.path.contains(regexpIgnoreFilesPattern)) {
                return;
            }
        }

        RegExp regexpDisallowContentsPattern = new RegExp(_enforceContentPattern, caseSensitive: false);

        if (!fileContents.contains(regexpDisallowContentsPattern)) {
            StaticCodeAnalysisError error = new StaticCodeAnalysisError("The file \"${fileName}\" does not contain the pattern \"${_enforceContentPattern}\".", userMessage);
            error.addMetaData("file", file.path);
            error.addMetaData("disallowContentsPattern", _enforceContentPattern);
            error.addMetaData("fileMathingPattern", matchingFilesPattern);

            reportError(error);
        }
    }

}