import 'package:logging/logging.dart';

final Logger logger = Logger('PostControllerLogger');

void setupLogging() {
  Logger.root.level = Level.ALL; // set logging level
  Logger.root.onRecord.listen((record) {
    // Customize output format
    print(
      '${record.time} [${record.level.name}] ${record.loggerName}: ${record.message}',
    );
  });
}
