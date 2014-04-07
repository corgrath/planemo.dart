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

isSameDirectory(Directory d1, Directory d2) {

    String path1 = d1.path;
    String path2 = d2.path;

    if (!path1.endsWith(path.separator)) {
        path1 = path1 + path.separator;
    }

    if (!path2.endsWith(path.separator)) {
        path2 = path2 + path.separator;
    }

    return path1 == path2;

}