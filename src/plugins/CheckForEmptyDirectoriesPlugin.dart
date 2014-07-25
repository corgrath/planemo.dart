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

library CheckForEmptyDirectoriesPlugin;

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

class CheckForEmptyDirectoriesPlugin extends AbstractPlugin implements OnDirectoryFoundObserverInterface {

	CheckForEmptyDirectoriesPlugin({String userMessage}): super(userMessage);

	void init(DataEventService dataEventService) {
		dataEventService.registerOnDirectoryFound(this);
	}

	onDirectoryFound(Reporters reporters, Directory directory, List<Directory> directoriesToIgnore) {

		String fileName = path.basename(directory.path);
		String fullPath = directory.path;

		List<FileSystemEntity> items = directory.listSync();

		if (items.isEmpty) {

			StaticCodeAnalysisError error = new StaticCodeAnalysisError("The directory \"$fileName\" isEmpty.", userMessage);
			error.addMetaData("filename", fileName);
			error.addMetaData("fullpath", fullPath);

			reportError(error);

		}

	}

}