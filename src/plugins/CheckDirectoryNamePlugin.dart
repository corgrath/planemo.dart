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

library CheckDirectoryNamePlugin;

import "dart:io";
import "package:path/path.dart" as path;

import "AbstractPlugin.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../datacollectors/interfaces/data-event-observer-interfaces.dart";
import "../reporting/ErrorReporter.dart";
import "../reporting/Reporters.dart";
import "../services/DataEventService.dart";

class CheckDirectoryNamePlugin extends AbstractPlugin implements OnDirectoryFoundObserverInterface {

	String pattern;

	CheckDirectoryNamePlugin(String this.pattern, {String userMessage:""}): super(userMessage);

	void init(DataEventService dataEventService) {
		dataEventService.registerOnDirectoryFound(this);
	}

	void onDirectoryFound(Reporters reporters, Directory directory, List<Directory> directoriesToIgnore) {

		String fileName = path.basename(directory.path);
		String fullPath = directory.path;

		RegExp expression = new RegExp(pattern);

		Iterable<Match> matches = expression.allMatches(fileName);

		if (matches.isEmpty) {

			StaticCodeAnalysisError error = new StaticCodeAnalysisError("The directory name \"$fileName\" is not valid as it does not comply with the pattern \"$pattern\".", userMessage);
			error.addMetaData("filename", fileName);
			error.addMetaData("fullpath", fullPath);
			error.addMetaData("pattern", pattern);

			reportError(error);

		}

	}

}