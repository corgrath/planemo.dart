import "../../reporting/Reporters.dart";

abstract class ObserverInterface {

}

abstract class OnDirectoryFoundObserverInterface implements ObserverInterface {

    onDirectoryFound(Reporters reporters, Directory directory, List<Directory> directoriesToIgnore);

}

abstract class OnFileFoundObserverInterface implements ObserverInterface {

    onFileFound(Reporters reporters, File file, String fileName);

}

abstract class OnJavaScriptFileFoundObserverInterface implements ObserverInterface {

    onJavaScriptFileFound(Reporters reporters, File file);

}

abstract class OnHTMLFileFoundObserverInterface implements ObserverInterface {

    onHTMLFileFound(Reporters reporters, File file);

}

abstract class OnLESSFileFoundObserverInterface implements ObserverInterface {

    onLESSFileFound(Reporters reporters, File file);

}