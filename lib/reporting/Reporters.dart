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

library Reporters;

import "Reporter.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../reporting/ErrorReporter.dart";

class Reporters implements Reporter {

	List<Reporter> _reporters;

	Reporters(List<Reporter> this._reporters);

	void start(String version) {
		_reporters.forEach((reporter) => reporter.start(version));
	}

	void verbose(String message) {
		_reporters.forEach((reporter) => reporter.verbose(message));
	}

	void error(StaticCodeAnalysisError error) {
		_reporters.forEach((reporter) => reporter.error(error));
	}

	void done(ErrorReporter errorReporter, int executionDuration) {
		_reporters.forEach((reporter) => reporter.done(errorReporter, executionDuration));
	}

}