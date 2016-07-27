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

library CheckHTMLFileNamePlugin;

import "dart:io";

import "AbstractCheckFileNamePlugin.dart";
import "../datacollectors/interfaces/data-event-observer-interfaces.dart";
import "../reporting/Reporters.dart";
import "../services/DataEventService.dart";

class CheckHTMLFileNamePlugin extends AbstractCheckFileNamePlugin implements OnHTMLFileFoundObserverInterface {

    CheckHTMLFileNamePlugin(String pattern, {String ignoreFilesPattern: null, String userMessage}) : super(pattern, ignoreFilesPattern, userMessage);

    void init(DataEventService dataEventService) {
        dataEventService.registerOnHTMLFileFound(this);
    }

    void onHTMLFileFound(Reporters reporters, File file, String fileName) {
        checkFileName(reporters, file, fileName);
    }

}