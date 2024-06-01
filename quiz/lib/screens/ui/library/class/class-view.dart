import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz/models/user.dart';
import 'package:quiz/providers/notify_change_provider.dart';
import 'package:quiz/services/class_service.dart';
import 'package:quiz/utilities/shared_preference_utils.dart';
import 'package:quiz/widgets/class-widget.dart';

class ClassView extends StatelessWidget {
  ClassView({super.key, required this.classStream});

  ValueNotifier classes = ValueNotifier([]);
  NotifyChangeStream classStream;

  Future<void> fetchData() async {
    UserInfo? user = await getUserInfo();
    classes.value = await ClassService().getAllClassUserIdJoined(user!.userId);
  }

  List<Widget> _loadClasses() {
    List<Widget> rs = [];
    if (classes.value != null) {
      for (var e_class in classes.value!) {
        rs.add(ClassWidget(
          e_class: e_class,
          classStream: classStream,
        ));
        rs.add(const SizedBox(
          height: 8,
        ));
      }
    }

    return rs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: const Color.fromRGBO(10, 8, 45, 1),
      child: StreamBuilder<void>(
          stream: classStream.stream,
          builder: (context, snapshot) {
            return FutureBuilder(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 120,
                          ),
                          ..._loadClasses(),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    );
                  }
                  return const SpinKitCircle(
                    size: 50,
                    color: Colors.blue,
                  );
                });
          }),
    );
  }
}
