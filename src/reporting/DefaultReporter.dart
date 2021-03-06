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

library DefaultReporter;

import "Reporter.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../reporting/ErrorReporter.dart";

class DefaultReporter implements Reporter {

	bool _colored;

	bool _verbosed;

	DefaultReporter(bool this._colored, bool this._verbosed) {
		verbose("Default reporter created. Colored mode is \"$_colored\" and verbosed is \"$_verbosed\".");
	}

	/*
     * Colors
     */

	String getRedColor() {
		return _colored ? "\x1b[31m" : "";
	}

	String getGreenColor() {
		return _colored ? "\x1b[32m" : "";
	}

	String getCloseColor() {
		return _colored ? "\x1b[0m" : "";
	}

	/*
     * Reporting functions
     */

	void start(String version) {
		print("Starting Planemo, version \"$version\".");
	}

	void verbose(String message) {

		if (_verbosed) {
			print("$message");
		}

	}

	void error(StaticCodeAnalysisError error) {

		String message = error.getMessage();
		String userMessage = error.getUserMessage();
		Map<String, String> metaData = error.getMetaData();

		print("\n${getRedColor()}${message}${getCloseColor()}");

		if (userMessage != null) {
			print("${getRedColor()}${userMessage}${getCloseColor()}");
		}

		for (String data in metaData.keys) {
			print("   ${getRedColor()}${data}=${metaData[data]}${getCloseColor()}");
		}

	}

	void done(ErrorReporter errorReporter, int executionDuration) {

		int numberOfErrors = errorReporter.getErrors().length;

		if (numberOfErrors > 0) {

			print("\r\n${getRedColor()}Planemo static code analysis failed with \"$numberOfErrors\" errors after $executionDuration ms.${getCloseColor()}");

		} else {

			print("\r\n${getGreenColor()}Planemo static code analysis done after $executionDuration ms. No errors found. Happy times!${getCloseColor()}");

		}

	}

}