import "../plugins/AbstractPlugin.dart";
import "../reporting/Reporter.dart";
import "../reporting/DefaultReporter.dart";

class PlanemoConfiguration {

    String _sourceRoot;

    List<String> _directoriesToIgnore;

    List<AbstractPlugin> _plugins;

    List<Reporter> _reporters;

    PlanemoConfiguration(List<Reporter> this._reporters) {
        _directoriesToIgnore = new List<String>();
        _plugins = new List<AbstractPlugin>();
    }

    void setSourceRoot(String root) {
        _sourceRoot = root;
    }

    String getSourceRoot() {
        return _sourceRoot;
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

    List<PluginInterface> getPlugins() {
        return _plugins;
    }

    List<Reporter> getReporters() {
        return _reporters;
    }

    void validate() {

        if (_reporters.isEmpty) {
            throw new Exception("List of reporters is empty.");
        }

    }

}