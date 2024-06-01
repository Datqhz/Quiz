import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz/providers/navigation_provider.dart';
import 'package:quiz/screens/ui/profile/profile.dart';

import 'home/home.dart';
import 'library/library-screen.dart';

class NavigationApp extends StatefulWidget {
  const NavigationApp({super.key});

  @override
  State<NavigationApp> createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {
  late NavigationStream navStream;

  Widget _bottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      height: 60,
      color: const Color.fromRGBO(10, 8, 45, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              navStream.notifyDataChanged(0);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.search,
                  color: Colors.white.withOpacity(0.6),
                ),
                Text(
                  "Trang chủ",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              navStream.notifyDataChanged(1);
            },
            child: Icon(
              CupertinoIcons.add_circled,
              size: 30,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          GestureDetector(
            onTap: () {
              navStream.notifyDataChanged(2);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.person,
                  color: Colors.white.withOpacity(0.6),
                ),
                Text(
                  "Hồ sơ",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 13,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    navStream = NavigationStream(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(46, 55, 86, 1),
      body: StreamBuilder(
        stream: navStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data == 0) {
            return HomeScreen(
              navStream: navStream,
            );
          } else if (snapshot.data == 1) {
            return const LibraryScreen();
          } else {
            return ProfileScreen();
          }
        },
      ),
      bottomNavigationBar: _bottomNavBar(),
    );
  }
}
