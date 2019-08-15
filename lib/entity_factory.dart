import 'package:flutter_eyepetizer/entity/issue_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "IssueEntity") {
      return IssueEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}