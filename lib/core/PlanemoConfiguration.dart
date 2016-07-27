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
 * File: src/core/PlanemoConfiguration.dart
 */

import "../plugins/AbstractPlugin.dart";
import "../reporting/Reporter.dart";
import "../reporting/DefaultReporter.dart";

/**
 * Class: PlanemoConfiguration
 * This is the configuration settings for running Planemo.
 */

class PlanemoConfiguration {

    String sourceRoot;
    List<String> _directoriesToIgnore;
    List<AbstractPlugin> _plugins;
    List<Reporter> _reporters;

    PlanemoConfiguration(List<Reporter> this._reporters) {
        _directoriesToIgnore = new List<String>();
        _plugins = new List<AbstractPlugin>();
    }

    void addDirectoryToIgnore(String directory) {
        _directoriesToIgnore.add(directory);
    }

    List<String> getDirectoriesToIgnore() {
        return _directoriesToIgnore;
    }

    void addPlugin(AbstractPlugin plugin) {
        _plugins.add(plugin);
    }

    /**
     * Method: getPlugins
     *
     *		Returns a list of <AbstractPlugin>s.
     *
     * Returns:
     *
     *		A list of <AbstractPlugin>s.
     */

    List<AbstractPlugin> getPlugins() {
        return _plugins;
    }

    /**
     * Method: getReporters
     *
     *		Returns a list of <Reporter>s.
     *
     * Returns:
     *
     *		A list of <Reporter>s.
     */

    List<Reporter> getReporters() {
        return _reporters;
    }

    /**
     * Method: validate
     * Performs basic validation of the configuration settings.
     */

    void validate() {
        if (_reporters.isEmpty) {
            throw new Exception("List of reporters is empty.");
        }



    }

}