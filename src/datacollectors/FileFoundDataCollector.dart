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

library FileFoundDataCollector;

import "dart:io";

import "../core/PlanemoConfiguration.dart";
import "./AbstractDataCollector.dart";
import "./interfaces/data-event-observer-interfaces.dart";
import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../reporting/Reporters.dart";
import "../services/DataEventService.dart";

class FileFoundDataCollector extends AbstractDataCollector implements OnFileFoundObserverInterface {

	final PlanemoConfiguration _configuration;

	FileFoundDataCollector(PlanemoConfiguration this._configuration, Reporters reporters, DataEventService dataEventService) : super(reporters, dataEventService);

	void onFileFound(Reporters reporters, File file, String fileName) {

		reporters.verbose("Evaluating the file \"$file\".");

		if (!file.existsSync()) {

			throw new Exception("The file \"$file\" does not exist.");

		} else if (isJavaScriptFile(file)) {

			dataEventService.javaScriptFileFound(file, fileName);
			_FileReadResults results = readFile(file);
			dataEventService.onJavaScriptFileRead(file, fileName, results.contents, results.contentRows);

		} else if (isLESSFile(file)) {

			dataEventService.LESSFileFound(file, fileName);
			_FileReadResults results = readFile(file);
			dataEventService.onLESSFileRead(file, fileName, results.contents, results.contentRows);

		} else if (isHTMLFile(file)) {

			dataEventService.HTMLFileFound(file, fileName);

		}

	}

	_FileReadResults readFile(File file) {

		reporters.verbose("Reading file \"${file.path}\".");

		String contents = file.readAsStringSync();

		return new _FileReadResults(contents);

	}

	bool isJavaScriptFile(File file) {
		return file.path.toLowerCase().endsWith(".js");
	}

	bool isHTMLFile(File file) {
		return file.path.toLowerCase().endsWith(".html");
	}

	bool isLESSFile(File file) {
		return file.path.toLowerCase().endsWith(".less");
	}

}

class _FileReadResults {

	final String contents;

	_FileReadResults(String this.contents);

	List<String> get contentRows {
		return contents.split("\n");
	}

}