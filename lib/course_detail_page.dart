import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'theme.dart';
import 'models/study_models.dart';

class CourseDetailPage extends StatefulWidget {
  final int courseIndex;

  const CourseDetailPage({super.key, required this.courseIndex});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late Box<CourseUnit> courseBox;

  @override
  void initState() {
    super.initState();
    courseBox = Hive.box<CourseUnit>('courses');
  }

  String getMotivation(double progress) {
    if (progress == 0) return "The journey begins with a single step.";
    if (progress < 0.4) return "Building a strong foundation...";
    if (progress < 0.8) return "You are gaining momentum. Stay focused.";
    if (progress < 1.0) return "ALMOST DONE, PUSH HARDER!";
    return "MASTERY ACHIEVED.";
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: courseBox.listenable(),
      builder: (context, Box<CourseUnit> box, _) {
        final course = box.getAt(widget.courseIndex)!;
        final progress = course.progress;

        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppTheme.navyPurple, AppTheme.navyBlue],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Top Header with Back Button
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(course.name.toUpperCase(), 
                          style: const TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

                  // Progress Wheel Section
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 180,
                        height: 180,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 12,
                          backgroundColor: Colors.white10,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.neonPurple),
                        ),
                      ),
                      Column(
                        children: [
                          Text("${(progress * 100).toInt()}%", 
                            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                          const Text("MASTERY", style: TextStyle(fontSize: 12, letterSpacing: 1)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(getMotivation(progress), 
                    style: const TextStyle(fontStyle: FontStyle.italic, color: AppTheme.marbleWhite)),
                  
                  const SizedBox(height: 40),

                  // Add Topic Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () => _showAddTopicDialog(course),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: AppTheme.elevatedDecoration,
                        child: const Center(child: Text("+ ADD NEW TOPIC", style: TextStyle(fontWeight: FontWeight.bold))),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Topics List
                  Expanded(
                    child: ListView.builder(
                      itemCount: course.topics.length,
                      itemBuilder: (context, index) {
                        final topic = course.topics[index];
                        return _buildTopicItem(topic, course, index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopicItem(Topic topic, CourseUnit course, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: AppTheme.elevatedDecoration,
        child: ListTile(
          title: Text(topic.title, 
            style: TextStyle(
              decoration: topic.isRead ? TextDecoration.lineThrough : null,
              color: topic.isRead ? Colors.grey : Colors.white,
            )),
          subtitle: Text("Reminder: Every ${topic.intervalHours} hours"),
          trailing: Checkbox(
            activeColor: AppTheme.neonPurple,
            value: topic.isRead,
            onChanged: (val) {
              setState(() {
                topic.isRead = val!;
                topic.lastRevised = DateTime.now();
                
                // Logic: Move to bottom if read
                if (topic.isRead) {
                  course.topics.removeAt(index);
                  course.topics.add(topic);
                }
                course.save();
              });
            },
          ),
        ),
      ),
    );
  }

  void _showAddTopicDialog(CourseUnit course) {
    final titleController = TextEditingController();
    final intervalController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.navyBlue,
        title: const Text("Add Study Topic"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(hintText: "Topic (e.g. Gram Staining)")),
            TextField(
              controller: intervalController, 
              decoration: const InputDecoration(hintText: "Interval (Hours)"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final newTopic = Topic(
                  title: titleController.text, 
                  intervalHours: int.tryParse(intervalController.text) ?? 5
                );
                setState(() {
                  course.topics.add(newTopic);
                  course.save();
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}