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
 * File: src/reporting/Reporter.dart
 */

library Reporter;

import "ErrorReporter.dart";
import "../error/StaticCodeAnalysisError.dart";

/**
 * Interface: Reporter
 *
 * 		Interface for a reporter.
 */

abstract class Reporter {

	/**
	 * Method: start
	 *
	 *		Called when Planemo is started.
	 *
	 * Arguments:
	 *
	 * 		version - The Planemo version number.
	 */

	void start(String version);

	/**
	 * Method: verbose
	 *
	 *		Called when different verbose stuff happens.
	 *
	 * Arguments:
	 *
	 * 		message - The message that is classified as verbose.
	 */

	void verbose(String message);

	/**
	 * Method: error
	 *
	 *		Called when a plugin throws an error.
	 *
	 * Arguments:
	 *
	 * 		<StaticCodeAnalysisError> message - A <StaticCodeAnalysisError> error.
	 */

	void error(StaticCodeAnalysisError error);

	void done(ErrorReporter errorReporter, int executionDuration);

}