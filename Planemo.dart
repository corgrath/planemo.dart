import "dart:io";

import "src/core/PlanemoConfiguration.dart";
import "src/services/DataEventService.dart";
import "src/reporting/Reporters.dart";
import "src/reporting/ErrorReporter.dart";
import "src/data_collectors/DirectoryFoundDataCollector.dart";
import "src/data_collectors/FileFoundDataCollector.dart";
import "src/data_collectors/interfaces/data-event-observer-interfaces.dart";
import "src/plugins/AbstractPlugin.dart";
import "src/core/ObserverList.dart";

final String VERSION = "0.1-alpha";

class Planemo {

    Planemo(PlanemoConfiguration configuration) {

        /*
         * The setup
         */

        // First thing to do is to validate the configuration
        configuration.validate();

        // Create and start a stop watch to keep track on the execution time
        Stopwatch stopwatch = new Stopwatch()..start();

        // Create the reporters
        Reporters reporters = new Reporters(configuration.getReporters());

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
        dataEventService.registerOnFileFound(new FileFoundDataCollector(reporters, dataEventService));

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

        Directory sourceRootDirectory = new Directory(configuration.getSourceRoot());
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
        int exitCode = errorReporter.getErrors().isEmpty ? 0 : 1;
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
