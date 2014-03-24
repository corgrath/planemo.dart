import "dart:io";

import "../reporting/Reporters.dart";
import "../services/DataEventService.dart";

abstract class AbstractDataCollector {

    Reporters reporters;

    DataEventService dataEventService;

    AbstractDataCollector(Reporters this.reporters, DataEventService this.dataEventService);

}