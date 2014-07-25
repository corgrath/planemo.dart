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

library DisallowFileContentsPlugin;

import "dart:io";

import "AbstractPlugin.dart";
import "AbstractCheckFileNamePlugin.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../datacollectors/interfaces/data-event-observer-interfaces.dart";
import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../services/DataEventService.dart";

class DisallowFileContentsPlugin extends AbstractPlugin implements OnFileReadObserver {

	final List<DisallowFileContentsRule> _rules;

	DisallowFileContentsPlugin(List<DisallowFileContentsRule> this._rules, {String userMessage:null}): super(userMessage);

	void init(DataEventService dataEventService) {
		dataEventService.registerOnFileReadObserver(this);
	}

	void onFileRead(Reporters reporters, File file, String fileName, String fileContents) {

		for (int i = 0 ; i < _rules.length ; i++) {

			DisallowFileContentsRule rule = _rules[i];

			RegExp regexpFileMatchingPattern = new RegExp(rule.fileMatchingPattern);

			if (file.path.contains(regexpFileMatchingPattern)) {

				for (String disallowContentsPattern in rule.disallowContentsPatterns) {

					RegExp regexpDisallowContentsPattern = new RegExp(disallowContentsPattern);

					if (fileContents.contains(regexpDisallowContentsPattern)) {

						StaticCodeAnalysisError error = new StaticCodeAnalysisError("The file \"${fileName}\" contains the pattern \"${disallowContentsPattern}\".", userMessage);
						error.addMetaData("file", file.path);
						error.addMetaData("fileMathingPattern", rule.fileMatchingPattern);
						error.addMetaData("disallowContentsPattern", disallowContentsPattern);

						reportError(error);

					}

				}

			}

		}

	}

}

class DisallowFileContentsRule {

	String fileMatchingPattern;
	List<String> disallowContentsPatterns;

	DisallowFileContentsRule(String this.fileMatchingPattern, List<String> this.disallowContentsPatterns);

}
