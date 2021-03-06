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

library DataEventObserverInterfaces;

import "dart:io";

import "../../reporting/Reporters.dart";

abstract class ObserverInterface {

}

abstract class OnDirectoryFoundObserverInterface implements ObserverInterface {
	onDirectoryFound(Reporters reporters, Directory directory, List<Directory> directoriesToIgnore);
}

abstract class OnFileFoundObserverInterface implements ObserverInterface {
	onFileFound(Reporters reporters, File file, String fileName);
}

abstract class OnJavaScriptFileFoundObserverInterface implements ObserverInterface {
	onJavaScriptFileFound(Reporters reporters, File file, String fileName);
}

abstract class OnHTMLFileFoundObserverInterface implements ObserverInterface {
	onHTMLFileFound(Reporters reporters, File file, String fileName);
}

abstract class OnLESSFileFoundObserverInterface implements ObserverInterface {
	onLESSFileFound(Reporters reporters, File file, String fileName);
}

abstract class OnJavaScriptFileReadObserver implements ObserverInterface {
	onJavaScriptFileRead(Reporters reporters, File file, String fileName, String fileContents, List<String> fileContentsRows);
}

abstract class OnLESSFileReadObserver implements ObserverInterface {
	onLESSFileRead(Reporters reporters, File file, String fileName, String fileContents, List<String> fileContentsRows);
}

abstract class OnHTMLFileReadObserver implements ObserverInterface {
	onHTMLFileRead(Reporters reporters, File file, String fileName, String fileContents, List<String> fileContentsRows);
}