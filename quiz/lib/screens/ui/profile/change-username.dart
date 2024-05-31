import 'package:flutter/material.dart';

class ChangeUsernameScreen extends StatefulWidget {
  const ChangeUsernameScreen({super.key});

  @override
  State<ChangeUsernameScreen> createState() => _ChangeUsernameScreenState();
}

class _ChangeUsernameScreenState extends State<ChangeUsernameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 8, 45, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(10, 8, 45, 1),
        title: Text(
          "Đổi tên người dùng",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Lưu",
              style: TextStyle(
                  color: Color.fromRGBO(92, 78, 122, 1.0),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            style: TextButton.styleFrom(backgroundColor: Colors.transparent),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Tên người dùng của bạn chỉ có thể thay đổi một lần",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(46, 55, 86, 1),
                  filled: true,
                  hintText: 'Tên người dùng mới',
                  hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  decoration: TextDecoration.none,
                  decorationThickness: 0,
                ),
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
