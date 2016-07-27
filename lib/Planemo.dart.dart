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
 * File: Planemo.dart
 */

library Planemo;

import "dart:io";

import "core/PlanemoConfiguration.dart";
import "services/DataEventService.dart";
import "reporting/Reporters.dart";
import "reporting/ErrorReporter.dart";
import "datacollectors/DirectoryFoundDataCollector.dart";
import "datacollectors/FileFoundDataCollector.dart";

/*
 * Export
 */

// Core functionality
export "core/PlanemoConfiguration.dart";

// Reporting
export "reporting/DefaultReporter.dart";
export "reporting/Reporter.dart";

// Plugins
export "plugins/CheckForEmptyDirectoriesPlugin.dart";
export "plugins/CheckForEmptyFilesPlugin.dart";
export "plugins/CheckHTMLFileNamePlugin.dart";
export "plugins/CheckForDuplicatedFilesPlugin.dart";
export "plugins/CheckJavaScriptFileNamePlugin.dart";
export "plugins/CheckLESSFileNamePlugin.dart";
export "plugins/CheckDirectoryNamePlugin.dart";

/**
 * Variable: VERSION
 *
 * 		Holds the current Planemo version.
 */

final String VERSION = "1.0.0";

/**
 * Class: Planemo
 *
 * 		This is the main class that triggers the Planemo analysis.
 *
 * Arguments:
 *
 * 		configuration - <PlanemoConfiguration>
 */

class Planemo {

    Planemo(PlanemoConfiguration configuration) {

        /*
         * The setup
         */

        // Create the reporters
        Reporters reporters = new Reporters(configuration.getReporters());

        // First thing to do is to validate the configuration
        configuration.validate(reporters);

        // Create and start a stop watch to keep track on the execution time
        Stopwatch stopwatch = new Stopwatch()
            ..start();

        // Tell the reporters Planemo is started
        reporters.start(VERSION);

        // Create the special error reporter
        ErrorReporter errorReporter = new ErrorReporter();

        // Create the data event hub
        DataEventService dataEventService = new DataEventService(reporters, errorReporter);

        /*
         * Register internal data collectors
         */

        dataEventService.registerOnDirectoryFound(new DirectoryFoundDataCollector(reporters, dataEventService));
        dataEventService.registerOnFileFound(new FileFoundDataCollector(configuration, reporters, dataEventService));

        /*
         * Register the user given plugins
         */

        configuration.getPlugins().forEach((plugin) {
            plugin.registerErrorReporter(reporters, errorReporter);
            plugin.init(dataEventService);
        });

        /*
         * Initialize the first source directory
         */

        Directory sourceRootDirectory = new Directory(configuration.sourceRoot);
        List<Directory> directoriesToIgnore = _createDirectoriesToIgnore(configuration.getDirectoriesToIgnore());

        /*
         * Go!
         */

        dataEventService.directoryFound(sourceRootDirectory, directoriesToIgnore);

        /*
         * The aftermath
         */

        // Stop the stop watch and then fetched the elapsed time
        stopwatch.stop();
        int duration = stopwatch.elapsedMilliseconds;

        // Report that Planemo is done
        reporters.done(errorReporter, duration);

        // Exit it
        int exitCode = errorReporter
            .getErrors()
            .isEmpty ? 0 : 1;
        exit(exitCode);
    }

}

/*
 * Help functions
 */

List<Directory> _createDirectoriesToIgnore(List<String> directories) {
    List<Directory> directoriesToIgnore = new List<Directory>();

    for (String directory in directories) {
        directoriesToIgnore.add(new Directory(directory));
    }

    return directoriesToIgnore;
}

