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

import "dart:io";

import "package:path/path.dart" as path;
import "AbstractDataCollector.dart";
import "interfaces/data-event-observer-interfaces.dart";
import "../util/DirectoryUtilLibrary.dart" as DirectoryUtil;
import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../services/DataEventService.dart";

class DirectoryFoundDataCollector extends AbstractDataCollector implements OnDirectoryFoundObserverInterface {

    DirectoryFoundDataCollector(Reporters reporters, DataEventService dataEventService) : super(reporters, dataEventService);

    void onDirectoryFound(Reporters reporters, Directory directory, List<Directory> directoriesToIgnore) {

        reporters.verbose("Evaluating the directory \"${directory.path}\".");

        if (!directory.existsSync()) {
            throw new Exception("The directory \"${directory.path}\" does not exist.");
        }

        print("passed $directory");

        //        if (directory.path.contains("translate")) {
        //            print(directory);
        //            print(directoriesToIgnore);
        //            throw new Error();return;
        //        }

        //        if (directoriesToIgnore.contains(directory)) {
        //            reporters.verbose("Ignoring to go into folder \"" + newDirectory + "\" (\"" + fileService.getResolvedPath(newDirectory) + "\").");
        //            return;
        //        }

        List<FileSystemEntity> items = directory.listSync();
        //        print("contents of $directory is $items");

        forEachEntity: for (FileSystemEntity entity in items) {

            if (entity is Directory) {

                reporters.verbose("Found the new directory \"$entity\".");
                //                print("Found the new directory \"$entity\".");

                // Check if we should ignore the directory
                for (Directory directoryToIgnore in directoriesToIgnore) {

                    //                    print("0 " + entity.path);
                    //                    print("1 " + directoryToIgnore.path);
                    if (DirectoryUtil.isSameDirectory(entity, directoryToIgnore)) {
                        //                        print("Ignoring to go into directory \"${entity.path}\".");
                        reporters.verbose("Ignoring to go into directory \"${entity.path}\".");
                        continue forEachEntity;
                    }

                }
                //                print("really passed \"$entity\".");
                dataEventService.directoryFound(entity, directoriesToIgnore);

            } else if (entity is File) {

                reporters.verbose("Found the file \"$entity\".");

                String fileName = path.basename(entity.path);

                dataEventService.fileFound(entity, fileName);

            } else {

                throw new Exception("Unknown type for entity \"$entity\".");

            }

        }

    }

}