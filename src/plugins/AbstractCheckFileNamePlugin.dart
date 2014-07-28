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

library AbstractCheckFileNamePlugin;

import "dart:io";
import "package:path/path.dart" as path;

import "AbstractPlugin.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../datacollectors/interfaces/data-event-observer-interfaces.dart";
import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../error/StaticCodeAnalysisError.dart";

abstract class AbstractCheckFileNamePlugin extends AbstractPlugin {

	final String pattern;
	final String ignoreFilesPattern;

	AbstractCheckFileNamePlugin(String this.pattern, String this.ignoreFilesPattern, String userMessage): super(userMessage);

	void checkFileName(Reporters reporters, File file, String fileName) {

		if (ignoreFilesPattern != null) {

			RegExp regexpIgnoreFilesPattern = new RegExp(ignoreFilesPattern);

			if (file.path.contains(regexpIgnoreFilesPattern)) {
				return;
			}

		}

		RegExp expression = new RegExp(pattern);

		if (!fileName.contains(expression)) {

			StaticCodeAnalysisError error = new StaticCodeAnalysisError("The file name \"$fileName\" is not valid as it does not comply with the pattern \"$pattern\".", userMessage);
			error.addMetaData("filename", fileName);
			error.addMetaData("file", file.path);

			reportError(error);

		}

	}

}