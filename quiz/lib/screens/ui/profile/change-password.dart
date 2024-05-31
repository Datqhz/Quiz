import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 8, 45, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(10, 8, 45, 1),
        title: Text(
          "Đổi mật khẩu",
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
              TextFormField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(46, 55, 86, 1),
                  filled: true,
                  hintText: 'Mật khẩu hiện tại',
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
              SizedBox(height: 12,),
              TextFormField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(46, 55, 86, 1),
                  filled: true,
                  hintText: 'Mật khẩu mới',
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
              SizedBox(height: 12,),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(46, 55, 86, 1),
                  filled: true,
                  hintText: 'Xác nhận mật khẩu mới của bạn',
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
