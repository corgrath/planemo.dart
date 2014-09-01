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
 * File: src\error\StaticCodeAnalysisError.dart
 */

library StaticCodeAnalysisError;

/**
 * Class: StaticCodeAnalysisError
 *
 * 		An error from thrown from a plugin.
 *
 * 	Arguments:
 *
 * 		_message - The error message
 * 		_userMessage - A custom message to the user
 */

class StaticCodeAnalysisError {

	final String _message;
	final String _userMessage;

	Map<String, Object> _metaData;

	StaticCodeAnalysisError(String this._message, String this._userMessage) {
		_metaData = new Map<String, Object>();
	}

	/**
	 * Method: getMessage
	 *
	 * 		Returns the message.
	 *
	 * 	Returns:
	 *
	 * 		The message.
	 */

	String getMessage() {
		return _message;
	}

	/**
	 * Method: getUserMessage
	 *
	 * 		Returns the user message.
	 *
	 * 	Returns:
	 *
	 * 		The user message.
	 */

	String getUserMessage() {
		return _userMessage;
	}

	/**
	 * Method: addMetaData
	 *
	 * 		Add meta information to the error.
	 *
	 * 	Arguments:
	 *
	 * 		name - Name of the meta data
	 * 		value - The value of the meta data
	 */

	void addMetaData(String name, Object value) {
		_metaData[name] = value;
	}

	Map<String, String> getMetaData() {
		return _metaData;
	}

}