import "package:unittest/unittest.dart";

import "../../src/core/PlanemoConfiguration.dart";

main() {

    List<Reporter> reporters = [ ];

    PlanemoConfiguration configuration = new PlanemoConfiguration(reporters);

    test('Range Error', () {
        expect(() {
            configuration.validate();
        }, throwsA(predicate((e) => e is Exception && e.message == "List of reporters is empty.")));
    });

}