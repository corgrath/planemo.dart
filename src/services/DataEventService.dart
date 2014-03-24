import "dart:io";
import "../core/ObserverList.dart";
import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../datacollectors/interfaces/data-event-observer-interfaces.dart";

class DataEventService {

    Reporters _reporters;

    ObserverList<OnDirectoryFoundObserverInterface> onDirectoryFoundObservers;

    ObserverList<OnFileFoundObserverInterface> onFileFoundObservers;

    ObserverList<OnJavaScriptFileFoundObserverInterface> onJavaScriptFileFoundObservers;

    ObserverList<OnHTMLFileFoundObserverInterface> onHTMLFileFoundObservers;

    ObserverList<OnHTMLFileFoundObserverInterface> onLESSFileFoundObservers;

    ErrorReporter errorReporter;

    DataEventService(Reporters this._reporters, ErrorReporter this.errorReporter) {
        onFileFoundObservers = new ObserverList();
        onDirectoryFoundObservers = new ObserverList();
        onJavaScriptFileFoundObservers = new ObserverList();
        onHTMLFileFoundObservers = new ObserverList();
        onLESSFileFoundObservers = new ObserverList();
    }

    void registerOnDirectoryFound(OnDirectoryFoundObserverInterface observer) {
        onDirectoryFoundObservers.add(observer);
    }

    void directoryFound(Directory directory, List<Directory> directoriesToIgnore) {
        onDirectoryFoundObservers.getAll().forEach((observer) => observer.onDirectoryFound(_reporters, directory, directoriesToIgnore));
    }

    void registerOnFileFound(OnFileFoundObserverInterface observer) {
        onFileFoundObservers.add(observer);
    }

    void fileFound(File file, String fileName) {
        onFileFoundObservers.getAll().forEach((observer) => observer.onFileFound(_reporters, file, fileName));
    }

    void registerOnJavaScriptFileFound(OnJavaScriptFileFoundObserverInterface observer) {
        onJavaScriptFileFoundObservers.add(observer);
    }

    void javaScriptFileFound(File file) {
        onJavaScriptFileFoundObservers.getAll().forEach((observer) => observer.onJavaScriptFileFound(_reporters, file));
    }

    void registerOnHTMLFileFound(OnHTMLFileFoundObserverInterface observer) {
        onHTMLFileFoundObservers.add(observer);
    }

    void HTMLFileFound(File file) {
        onHTMLFileFoundObservers.getAll().forEach((observer) => observer.onHTMLFileFound(_reporters, file));
    }

    void registerOnLESSFileFound(OnLESSFileFoundObserverInterface observer) {
        onLESSFileFoundObservers.add(observer);
    }

    void LESSFileFound(File file) {
        onLESSFileFoundObservers.getAll().forEach((observer) => observer.onLESSFileFound(_reporters, file));
    }

}