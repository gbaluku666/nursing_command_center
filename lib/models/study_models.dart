import 'package:hive/hive.dart';

part 'study_models.g.dart';

@HiveType(typeId: 0)
class Topic extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isRead;

  @HiveField(2)
  int intervalHours;

  @HiveField(3)
  DateTime? lastRevised;

  Topic({
    required this.title,
    this.isRead = false,
    required this.intervalHours,
    this.lastRevised,
  });
}

@HiveType(typeId: 1)
class CourseUnit extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<Topic> topics;

  CourseUnit({required this.name, required this.topics});

  double get progress {
    if (topics.isEmpty) return 0.0;
    int readCount = topics.where((t) => t.isRead).length;
    return readCount / topics.length;
  }
}