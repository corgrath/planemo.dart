import "dart:io";
import "package:crypto/crypto.dart";
import "package:path/path.dart" as path;

import "AbstractPlugin.dart";
import "AbstractCheckFileNamePlugin.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../data_collectors/interfaces/data-event-observer-interfaces.dart";
import "../reporting/Reporters.dart";
import "../reporting/ErrorReporter.dart";
import "../error/StaticCodeAnalysisError.dart";
import "../services/DataEventService.dart";

class CheckForDuplicatedFilesPlugin extends AbstractPlugin implements OnFileFoundObserverInterface {

    List<FileData> checksums;

    CheckForDuplicatedFilesPlugin({String userMessage}): super(userMessage) {
        checksums = new List<FileData>();
    }

    void init(DataEventService dataEventService) {
        dataEventService.registerOnFileFound(this);
    }

    void onFileFound(Reporters reporters, File file, String fileName) {

        String checksum = CryptoUtils.bytesToHex((new MD5()..add(file.readAsBytesSync())).close());

        for (int i = 0; i < checksums.length ;i++) {

            FileData data = checksums[i];

            if (data.fileName == fileName && data.checksum == checksum) {

                StaticCodeAnalysisError error = new StaticCodeAnalysisError("Found duplicated file \"$fileName\".", userMessage);
                error.addMetaData("filename", fileName);
                error.addMetaData("fullpath", file.path);
                error.addMetaData("checksum", checksum);

                reportError(error);

            }

        }

        /*
         * Add the file data
         */

        FileData data = new FileData(fileName, checksum);
        checksums.add(data);

    }

}

class FileData {

    String fileName;

    String checksum;

    FileData(String this.fileName, String this.checksum);

}