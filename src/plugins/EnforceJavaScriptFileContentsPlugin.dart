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
 * File: src/plugins/EnforceJavaScriptFileContentsPlugin.dart
 */

library EnforceJavaScriptFileContentsPlugin;

import "dart:io";

import "AbstractPlugin.dart";
import "AbstractEnforceFileContentsPlugin.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../datacollectors/interfaces/data-event-observer-interfaces.dart";
import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../services/DataEventService.dart";

/**
 * Class: EnforceJavaScriptFileContentsPlugin
 *
 * 		Extends: <AbstractEnforceFileContentsPlugin>
 * 		Implements: <OnJavaScriptFileReadObserver>
 *
 * 		Enforces that a JavaScript file contains a specific pattern.
 *
 * Arguments:
 *
 * 		enforceContentPattern - A RegExp pattern
 * 		matchingFilesPattern - The JavaScript file needs to follow this pattern in order to be evaluated.
 * 		userMessage - Custom user message
 *
 */

class EnforceJavaScriptFileContentsPlugin extends AbstractEnforceFileContentsPlugin implements OnJavaScriptFileReadObserver {

	EnforceJavaScriptFileContentsPlugin(String enforceContentPattern, {String matchingFilesPattern:null, String ignoreFilesPattern:null, String userMessage:null}): super(enforceContentPattern, matchingFilesPattern: matchingFilesPattern, ignoreFilesPattern:ignoreFilesPattern, userMessage:userMessage);

	void init(DataEventService dataEventService) {
		dataEventService.registerOnJavaScriptFileReadObserver(this);
	}

	void onJavaScriptFileRead(Reporters reporters, File file, String fileName, String fileContents, List<String> fileContentRows) {
		checkFileContents(reporters, file, fileName, fileContents, fileContentRows);
	}

}