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
 * File: src/services/DataEventService.dart
 */

library DataEventService;

import "dart:io";
import "../core/ObserverList.dart";
import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../datacollectors/interfaces/data-event-observer-interfaces.dart";

/**
 * Class: DataEventService
 *
 * 		Service that handles all the data events.
 *
 * Arguments:
 *
 * 		_reporters - <Reporters>
 * 		errorReporter - <ErrorReporter>
 *
 */

class DataEventService {

	ObserverList<OnDirectoryFoundObserverInterface> onDirectoryFoundObservers;
	ObserverList<OnFileFoundObserverInterface> onFileFoundObservers;
	ObserverList<OnJavaScriptFileFoundObserverInterface> onJavaScriptFileFoundObservers;
	ObserverList<OnHTMLFileFoundObserverInterface> onHTMLFileFoundObservers;
	ObserverList<OnLESSFileFoundObserverInterface> onLESSFileFoundObservers;
	ObserverList<OnJavaScriptFileReadObserver> _onJavaScriptFileReadObservers;
	ObserverList<OnLESSFileReadObserver> _onLESSFileReadObservers;
	ObserverList<OnHTMLFileReadObserver> _onHTMLFileReadObservers;

	final Reporters _reporters;
	final ErrorReporter errorReporter;

	DataEventService(Reporters this._reporters, ErrorReporter this.errorReporter) {
		onFileFoundObservers = new ObserverList();
		onDirectoryFoundObservers = new ObserverList();
		onJavaScriptFileFoundObservers = new ObserverList();
		onHTMLFileFoundObservers = new ObserverList();
		onLESSFileFoundObservers = new ObserverList<OnLESSFileFoundObserverInterface>();
		_onJavaScriptFileReadObservers = new ObserverList<OnJavaScriptFileReadObserver>();
		_onLESSFileReadObservers = new ObserverList<OnLESSFileReadObserver>();
		_onHTMLFileReadObservers = new ObserverList<OnHTMLFileReadObserver>();
	}

	void registerOnDirectoryFound(OnDirectoryFoundObserverInterface observer) {
		onDirectoryFoundObservers.add(observer);
	}

	void directoryFound(Directory directory, List<Directory> directoriesToIgnore) {
		onDirectoryFoundObservers.getAll().forEach((observer) => observer.onDirectoryFound(_reporters, directory, directoriesToIgnore));
	}

	void registerOnFileFound(OnFileFoundObserverInterface observer) {
		onFileFoundObservers.add(observer);
	}

	void fileFound(File file, String fileName) {
		onFileFoundObservers.getAll().forEach((observer) => observer.onFileFound(_reporters, file, fileName));
	}

	void registerOnJavaScriptFileFound(OnJavaScriptFileFoundObserverInterface observer) {
		onJavaScriptFileFoundObservers.add(observer);
	}

	void javaScriptFileFound(File file, String fileName) {
		onJavaScriptFileFoundObservers.getAll().forEach((observer) => observer.onJavaScriptFileFound(_reporters, file, fileName));
	}

	void registerOnHTMLFileFound(OnHTMLFileFoundObserverInterface observer) {
		onHTMLFileFoundObservers.add(observer);
	}

	void HTMLFileFound(File file, String fileName) {
		onHTMLFileFoundObservers.getAll().forEach((observer) => observer.onHTMLFileFound(_reporters, file, fileName));
	}

	void registerOnLESSFileFound(OnLESSFileFoundObserverInterface observer) {
		onLESSFileFoundObservers.add(observer);
	}

	void LESSFileFound(File file, String fileName) {
		onLESSFileFoundObservers.getAll().forEach((observer) => observer.onLESSFileFound(_reporters, file, fileName));
	}

	void registerOnJavaScriptFileReadObserver(OnJavaScriptFileReadObserver observer) {
		_onJavaScriptFileReadObservers.add(observer);
	}

	void onJavaScriptFileRead(File file, String fileName, String fileContents, List<String> fileContentsRows) {
		_onJavaScriptFileReadObservers.getAll().forEach((observer) => observer.onJavaScriptFileRead(_reporters, file, fileName, fileContents, fileContentsRows));
	}

	void registerOnLESSFileReadObserver(OnLESSFileReadObserver observer) {
		_onLESSFileReadObservers.add(observer);
	}

	void onLESSFileRead(File file, String fileName, String fileContents, List<String> fileContentsRows) {
		_onLESSFileReadObservers.getAll().forEach((observer) => observer.onLESSFileRead(_reporters, file, fileName, fileContents, fileContentsRows));
	}

	void registerOnHTMLFileReadObserver(OnHTMLFileReadObserver observer) {
		_onHTMLFileReadObservers.add(observer);
	}

	void onHTMLFileRead(File file, String fileName, String fileContents, List<String> fileContentsRows) {
		_onHTMLFileReadObservers.getAll().forEach((observer) => observer.onHTMLFileRead(_reporters, file, fileName, fileContents, fileContentsRows));
	}

}