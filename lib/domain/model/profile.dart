import 'package:logging/logging.dart';

class Profile {
  String uuid;
  String fullName;
  String avatarUrl;
  Level level;

  Profile(this.uuid, this.fullName, this.avatarUrl, this.level);
}

class Level {
  int levelId;
  String levelName;

  Level(this.levelId, this.levelName);
}
