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