import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/providers/auth_provider.dart';
import 'package:quiz/screens/ui/profile/change-password.dart';
import 'package:quiz/screens/ui/profile/change-username.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  List<String> _type = ["Student, Teacher"];

  Widget optionType2Text(String title, String content) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                content,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const Icon(
            CupertinoIcons.chevron_right,
            size: 20,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Widget optionType1Text(String title) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Icon(
            CupertinoIcons.chevron_right,
            size: 20,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(10, 8, 45, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(10, 8, 45, 1),
        title: const Text(
          "Cài đặt",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 26,
              ),
              const Text(
                "Thông tin cá nhân",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                        width: 2, color: const Color.fromRGBO(46, 55, 86, 1))),
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  elevation: 0,
                                  backgroundColor:
                                      const Color.fromRGBO(46, 55, 86, 1),
                                  child: Container(
                                    height: 300,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 26, vertical: 12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          "Đổi tên người dùng",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text(
                                          "Để xác nhận đây thực sự là bạn, bui lòng xác minh mật khẩu Quiz của bạn",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        TextFormField(
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            fillColor: const Color.fromRGBO(
                                                10, 8, 45, 1),
                                            filled: true,
                                            hintText: 'Mật khẩu',
                                            hintStyle: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.6),
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
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ChangeUsernameScreen()));
                                          },
                                          style: TextButton.styleFrom(
                                            minimumSize:
                                                const Size(double.infinity, 30),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 10),
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(
                                                    153, 162, 232, 1)),
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    67, 85, 255, 1),
                                          ),
                                          child: const Text(
                                            "Gửi",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 2,
                                                    color: Color.fromRGBO(
                                                        91, 95, 124, 1.0)),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            minimumSize:
                                                const Size(double.infinity, 30),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 10),
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(
                                                    153, 162, 232, 1)),
                                            backgroundColor: Colors.transparent,
                                          ),
                                          child: const Text(
                                            "Hủy",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: optionType2Text("Tên người dùng", "vaicmnr123")),
                    Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(46, 55, 86, 1)),
                                top: BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(46, 55, 86, 1)))),
                        child: optionType2Text("Email", "vaicmnr@gmail.com")),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangePasswordScreen()));
                        },
                        child: optionType1Text("Đổi mật khẩu")),
                    Container(
                        height: 64,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Color.fromRGBO(46, 55, 86, 1),
                                    width: 2))),
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<AuthProvider>(context).logout();
                          },
                          child: Container(
                            height: 64,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Đăng xuất',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  CupertinoIcons.chevron_right,
                                  size: 20,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
