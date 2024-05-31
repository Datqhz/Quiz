import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/screens/ui/profile/profile.dart';

import 'home/home.dart';
import 'library/library.dart';

class NavigationApp extends StatefulWidget {
  const NavigationApp({super.key});

  @override
  State<NavigationApp> createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {

  ValueNotifier<int> _bottomIdx = ValueNotifier(0);

  @override
  Widget _bottomNavBar(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      height: 60,
      color: Color.fromRGBO(10, 8, 45, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              _bottomIdx.value = 0;
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
            onTap: (){
              _bottomIdx.value = 1;
            },
            child: Icon(
              CupertinoIcons.add_circled,
              size: 30,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          GestureDetector(
            onTap: (){
              _bottomIdx.value = 2;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.search,
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(46, 55, 86, 1),
      body: ValueListenableBuilder(
        valueListenable: _bottomIdx,
        builder: (context, value, child){
          if(value == 0){
            return HomeScreen();
          }else if(value == 1){
            return LibraryScreen();
          }else {
            return ProfileScreen();
          }
        },
      ),
      bottomNavigationBar: _bottomNavBar(),
    );
  }
}
