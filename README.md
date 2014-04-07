![Planemo logotype](https://raw.githubusercontent.com/corgrath/planemo.dart/master/resources/planemo_github_version.png)




Planemo
=======================================================================================================================
Planemo is a [plugin-friendly][01] [open source][02] [software quality platform][03] written in the [Dart][04].

[01]: http://en.wikipedia.org/wiki/Plug-in_%28computing%29
[02]: http://en.wikipedia.org/wiki/Open-source_software
[03]: http://en.wikipedia.org/wiki/Software_quality
[04]: https://www.dartlang.org/




No seriously, what is it?
-----------------------------------------------------------------------------------------------------------------------
Planemo is basically a [static code analysis tool][11] written in [Dart programming language][12]. Its main goal is to read everything in given directory (and recursively downwards) and
checks any found file (no matter if its its .js, .css, .html or whatever) and its contents against a set of rules, configurable by the user.

The whole idea is that Planemo should help your project to maintain [coding conventions][13], [best practices][14] and other fun rules your software project might have, for any source code file or language.

Currently it has a lot of available built in plugins to choose from, but it also super easy to write your own plugin and even contribute it back to the project.

Fun fact #184: The word *Planemo* comes from *[planetary-mass object][15]*!

[11]: http://en.wikipedia.org/wiki/Static_code_analysis
[12]: https://www.dartlang.org/
[13]: http://en.wikipedia.org/wiki/Coding_conventions
[14]: http://en.wikipedia.org/wiki/Best_practice
[15]: http://en.wikipedia.org/wiki/Planemo#Planetary-mass_objects




Downloading and running Planemo
-----------------------------------------------------------------------------------------------------------------------
### Installing Dart
Planemo runs on the [Dart VM][21], so make sure you have that [downloaded and installed][22] first.

### Getting Planemo
Next thing you have to do is download Planemo from the [Github repository][23]. Github offers different ways to download a project
(such as downloading it as a ZIP file directly), but if you are even planing to contribute, fetching it via [Git][24] is probably the best idea.

### Downloading third party libraries
Planemo requires certain third party libraries in order to work. Once you have Dart installed you can simply use the [pub tool][25] by type `pub install`, standing in the project folder.
This should download any third party libraries and put them in the */packages/* folder in the project folder.

### Creating a launcher script
Launching Planemo requires that you have very basic understanding of the [Dart language][26], or at least [Object-oriented programming][27].

In order to start Planemo you actually need to create a Dart source code file, in the newly downloaded project folder, where we need to invoke an instance
of the `Planemo` class with a set of configurations (an instance of the `PlanemoConfiguration` class). It is on the `PlanemoConfiguration` instance you then setup
all the various configurations (such as the root folder, what reporters to use, etc) and plugins you want to enable. The best way to understand how exactly
this can be done is by looking at a real example and follow the code comments. This is the launcher script (checkplanemo.dart) that checks the Planemo project itself:

	import "Planemo.dart";
	import "src/core/PlanemoConfiguration.dart";
	import "src/reporting/DefaultReporter.dart";
	import "src/reporting/DefaultJUnitTestReporter.dart";
	import "src/plugins/CheckDirectoryNamePlugin.dart";
	import "src/plugins/CheckJavaScriptFileNamePlugin.dart";
	import "src/plugins/CheckHTMLFileNamePlugin.dart";
	import "src/plugins/CheckLESSFileNamePlugin.dart";
	import "src/plugins/CheckForEmptyDirectoriesPlugin.dart";
	import "src/plugins/CheckForEmptyFilesPlugin.dart";
	import "src/plugins/CheckForDuplicatedFilesPlugin.dart";

	void main(List<String> arguments) {

		bool useColors = true;
		bool verbose = false;

		/*
		 * Planemo configuration
		 */

		// Fetch the default reporter to use
		DefaultReporter defaultReporter = new DefaultReporter(useColors, verbose);
		List<Reporter> reporters = [defaultReporter];

		// Create the configuration object
		PlanemoConfiguration configuration = new PlanemoConfiguration(reporters);
		configuration.setSourceRoot(".");

		// Directories to ignore
		configuration.addDirectoryToIgnore(".\\.git");
		configuration.addDirectoryToIgnore(".\\.idea");
		configuration.addDirectoryToIgnore(".\\packages");
		configuration.addDirectoryToIgnore(".\\resources");

		// Plugins to invoke
		configuration.addPlugin(new CheckDirectoryNamePlugin("^[\\.a-z|-]+\$", userMessage: "This is a custom message."));
		configuration.addPlugin(new CheckJavaScriptFileNamePlugin("^[a-z][a-z0-9|-]*\\.(?:spec\\.js|js)\$"));
		configuration.addPlugin(new CheckHTMLFileNamePlugin("^[a-z][a-z0-9|-]*\\.(?:icons\\.html|ng\\.html|html)\$"));
		configuration.addPlugin(new CheckLESSFileNamePlugin("^[a-z][a-z0-9|-]*\\.less\$"));
		configuration.addPlugin(new CheckForEmptyDirectoriesPlugin());
		configuration.addPlugin(new CheckForEmptyFilesPlugin());
		configuration.addPlugin(new CheckForDuplicatedFilesPlugin());

		// Start Planemo
		new Planemo(configuration);

	}

### Launching Planemo

Given that Dart is globally installed on your system, you can simply type `dart [your-launcher-script].dart` to launch Planemo with your own launcher file.

If you want to try out Planemo's own launcher file, you can type `dart checkplanemo.dart`.

[21]: https://www.dartlang.org/docs/dart-up-and-running/contents/ch04-tools-dart-vm.html
[22]: https://www.dartlang.org/tools/download.html
[23]: https://github.com/corgrath/planemo.dart
[24]: https://help.github.com/articles/set-up-git/
[25]: https://www.dartlang.org/tools/pub/
[26]: https://www.dartlang.org/
[27]: http://en.wikipedia.org/wiki/Object-oriented_programming




Available plugins
-----------------------------------------------------------------------------------------------------------------------



Creating your own reporter
-----------------------------------------------------------------------------------------------------------------------
Creating your own reporter is quite simple. Simply create your own class that implements `Reporter`, for example:

	class MyOwnReporter implements Reporter {

By implementing `Reporter` you need to implement the following methods as specified abstract class:

	abstract class Reporter {

		void start(String version);

		void verbose(String message);

		void error(StaticCodeAnalysisError error);

		void done(ErrorReporter errorReporter, int executionDuration);

	}

For a real example, you may look at the source code of the [DefaultReporter][41] class.

[41]: DefaultReporter



Creating your own plugin
-----------------------------------------------------------------------------------------------------------------------
Writing new plugins to Planemo is fairly easy. A plugin is a stand alone file that is located in the [/src/plugins/][51] folder.

A plugins is simply a class that extends the `AbstractPlugin` class and then a numerous interfaces, depending on what kind of data the plugin is interested in.

To get a better understanding of how a simple plugin looks like, lets look at an existing one. The `CheckDirectoryNamePlugin` plugin that has the responsibility
to validate directory names, given a [regular expression][52] pattern.


	class CheckDirectoryNamePlugin extends AbstractPlugin implements OnDirectoryFoundObserverInterface {

		String pattern;

		CheckDirectoryNamePlugin(String this.pattern, {String userMessage:""}): super(userMessage);

		void init(DataEventService dataEventService) {
			dataEventService.registerOnDirectoryFound(this);
		}

		void onDirectoryFound(Reporters reporters, Directory directory, List<Directory> directoriesToIgnore) {

			String fileName = path.basename(directory.path);
			String fullPath = directory.path;

			RegExp expression = new RegExp(pattern);

			Iterable<Match> matches = expression.allMatches(fileName);

			if (matches.isEmpty) {

				StaticCodeAnalysisError error = new StaticCodeAnalysisError("The directory name \"$fileName\" is not valid as it does not comply with the pattern \"$pattern\".", userMessage);
				error.addMetaData("filename", fileName);
				error.addMetaData("fullpath", fullPath);
				error.addMetaData("pattern", pattern);

				reportError(error);

			}

		}

	}


[51]: https://github.com/corgrath/planemo.dart/tree/master/src/plugins
[52]: http://en.wikipedia.org/wiki/Regular_expression



Found a bug or have a questions?
-----------------------------------------------------------------------------------------------------------------------
If you have found a bug and want to report it, or have any other feedback or questions, you can simply [create an issue][61].
However, creating [pull requests][62] with fixes would be more appreciable as it would decrease the time the fix got into the project.

[61]: https://github.com/corgrath/planemo.dart/issues
[62]: https://help.github.com/articles/using-pull-requests




Writing tests
-----------------------------------------------------------------------------------------------------------------------




Contributors
-----------------------------------------------------------------------------------------------------------------------
The list of [contributors][81] can be found here.

[81]: https://github.com/corgrath/planemo.dart/graphs/contributors




License
-----------------------------------------------------------------------------------------------------------------------
 * Planemo licensed under the Apache License, Version 2.0. See the NOTICE file distributed with this work for additional information regarding copyright ownership.
 * Planemo logotype images Copyright (c) Christoffer Pettersson, christoffer[at]christoffer[dot]me. All Rights Reserved! Please contact Christoffer regarding the possible use of these images.
