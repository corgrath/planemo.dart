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

import "dart:io";
import "package:path/path.dart" as path;

import "AbstractPlugin.dart";
import "AbstractCheckFileNamePlugin.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../datacollectors/interfaces/data-event-observer-interfaces.dart";
import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../services/DataEventService.dart";

class CheckForEmptyFilesPlugin extends AbstractPlugin implements OnFileFoundObserverInterface {

    List<String> filesToIgnore;

    CheckForEmptyFilesPlugin({List<String> this.filesToIgnore, String userMessage}): super(userMessage);

    void init(DataEventService dataEventService) {
        dataEventService.registerOnFileFound(this);
    }

    void onFileFound(Reporters reporters, File file, String fileName) {

        String fullPath = file.path;

        if (filesToIgnore != null) {

            for (String fileToIgnore in filesToIgnore) {

                if (fileToIgnore == fullPath) {
                    reporters.verbose("Ignoring to see if the file \"$fullPath\" is empty.");
                    return;
                }

            }

        }

        int length = file.lengthSync();

        if (length == 0) {

            StaticCodeAnalysisError error = new StaticCodeAnalysisError("The file \"$fileName\" is empty.", userMessage);
            error.addMetaData("filename", fileName);
            error.addMetaData("fullpath", fullPath);

            reportError(error);

        }

    }

}