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

/**
 * File: src/plugins/CheckForDuplicatedFilesPlugin.dart
 */

library CheckForDuplicatedFilesPlugin;

import "dart:io";
import "package:crypto/crypto.dart";

import "AbstractPlugin.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../datacollectors/interfaces/data-event-observer-interfaces.dart";
import "../reporting/Reporters.dart";
import "../services/DataEventService.dart";

/**
 * Class: CheckForDuplicatedFilesPlugin
 * Plugin that checks for duplicated files.
 */

class CheckForDuplicatedFilesPlugin extends AbstractPlugin implements OnFileFoundObserverInterface {

	final String ignoreFilesMatchingPattern;
	List<FileData> checksums;

	CheckForDuplicatedFilesPlugin({String this.ignoreFilesMatchingPattern:null, String userMessage}): super(userMessage) {
		checksums = new List<FileData>();
	}

	void init(DataEventService dataEventService) {
		dataEventService.registerOnFileFound(this);
	}

	void onFileFound(Reporters reporters, File file, String fileName) {

		if (ignoreFilesMatchingPattern != null) {

			RegExp regexp = new RegExp(ignoreFilesMatchingPattern);

			if (fileName.contains(regexp)) {
				reporters.verbose("Ignoring file \"${fileName}\".");
				return;
			}

		}

		String checksum = md5.convert(file.readAsBytesSync()).toString();
		print("CHIRSTOFFER $checksum");

		for (int i = 0; i < checksums.length ;i++) {

			FileData data = checksums[i];

			if (data.fileName == fileName && data.checksum == checksum) {

				StaticCodeAnalysisError error = new StaticCodeAnalysisError("Found duplicated file \"$fileName\".", userMessage);
				error.addMetaData("filename", fileName);
				error.addMetaData("file1", file.path);
				error.addMetaData("file2", data.file.path);
				error.addMetaData("checksum", checksum);

				reportError(error);

			}

		}

		/*
         * Add the file data
         */

		FileData data = new FileData(fileName, checksum, file);
		checksums.add(data);

	}

}

class FileData {

	final String fileName;
	final String checksum;
	final File file;

	FileData(String this.fileName, String this.checksum, File this.file);

}