import 'package:flutter/material.dart';
import 'package:quiz/providers/notify_change_provider.dart';
import 'package:quiz/services/user_service.dart';
import 'package:quiz/utilities/shared_preference_utils.dart';

class ChangeUsernameScreen extends StatefulWidget {
  ChangeUsernameScreen({super.key, required this.userStream});
  NotifyChangeStream userStream;
  @override
  State<ChangeUsernameScreen> createState() => _ChangeUsernameScreenState();
}

class _ChangeUsernameScreenState extends State<ChangeUsernameScreen> {
  final ValueNotifier _isEnabled = ValueNotifier(false);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(10, 8, 45, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(10, 8, 45, 1),
        title: const Text(
          "Đổi tên người dùng",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: [
          ValueListenableBuilder(
            valueListenable: _isEnabled,
            builder: (context, value, child) {
              return TextButton(
                onPressed: value
                    ? () async {
                        var username = controller.text.trim();
                        bool result = await UserService().updateUser(username);
                        if (result) {
                          var user = await getUserInfo();
                          user!.username = username;
                          await storeUserInfo(user);
                          widget.userStream.notifyDataChanged();
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              // backgroundColor: Colors.transparent,
                              width:
                                  2.6 * MediaQuery.of(context).size.width / 4,
                              behavior: SnackBarBehavior.floating,
                              content: const Text(
                                'Đổi tên hiển thị thành công.',
                                textAlign: TextAlign.center,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              // backgroundColor: Colors.transparent,
                              width:
                                  2.6 * MediaQuery.of(context).size.width / 4,
                              behavior: SnackBarBehavior.floating,
                              content: const Text(
                                'Xảy ra lỗi trong quá trình xử lý.',
                                textAlign: TextAlign.center,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                    : null,
                style:
                    TextButton.styleFrom(backgroundColor: Colors.transparent),
                child: Text(
                  "Lưu",
                  style: TextStyle(
                      color: value
                          ? Colors.white
                          : Color.fromRGBO(92, 78, 122, 1.0),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Tên người dùng của bạn chỉ có thể thay đổi một lần",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  fillColor: const Color.fromRGBO(46, 55, 86, 1),
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
                onChanged: (value) {
                  if (value.trim().isNotEmpty) {
                    _isEnabled.value = true;
                  } else {
                    _isEnabled.value = false;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
