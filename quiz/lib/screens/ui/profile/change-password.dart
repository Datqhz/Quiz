import 'package:flutter/material.dart';
import 'package:quiz/services/account_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();

  final ValueNotifier _isEnabled = ValueNotifier(false);

  bool checkValid() {
    var oldPassword = _oldPasswordController.text;
    var newPassword = _newPasswordController.text;
    var retype = _retypePasswordController.text;
    if (oldPassword.trim().isEmpty ||
        newPassword.trim().isEmpty ||
        retype.trim().isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(10, 8, 45, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(10, 8, 45, 1),
        title: const Text(
          "Đổi mật khẩu",
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
                          if (_formKey.currentState!.validate()) {
                            var oldPassword =
                                _oldPasswordController.text.trim();
                            var newPassword =
                                _newPasswordController.text.trim();
                            bool result = await AccountService()
                                .updateAccount(newPassword, oldPassword);
                            if (!result) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  // backgroundColor: Colors.transparent,
                                  width: 2.6 *
                                      MediaQuery.of(context).size.width /
                                      4,
                                  behavior: SnackBarBehavior.floating,
                                  content: const Text(
                                    'Mật khẩu cũ không chính xác.',
                                    textAlign: TextAlign.center,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  // backgroundColor: Colors.transparent,
                                  width: 2.6 *
                                      MediaQuery.of(context).size.width /
                                      4,
                                  behavior: SnackBarBehavior.floating,
                                  content: const Text(
                                    'Đổi mật khẩu thành công.',
                                    textAlign: TextAlign.center,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                              Navigator.pop(context);
                            }
                          }
                        }
                      : null,
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.transparent),
                  child: Text(
                    "Lưu",
                    style: TextStyle(
                        color: value
                            ? const Color.fromARGB(255, 244, 237, 255)
                            : const Color.fromARGB(255, 93, 80, 120),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                );
              })
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _oldPasswordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(46, 55, 86, 1),
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
                  onChanged: (value) {
                    if (checkValid()) {
                      _isEnabled.value = true;
                    } else {
                      _isEnabled.value = false;
                    }
                  },
                  validator: (value) {
                    if (value!.length < 6) {
                      return "Mật khẩu phải có tối thiểu 6 kí tự";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(46, 55, 86, 1),
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
                  onChanged: (value) {
                    if (checkValid()) {
                      _isEnabled.value = true;
                    } else {
                      _isEnabled.value = false;
                    }
                  },
                  validator: (value) {
                    if (value!.length < 6) {
                      return "Mật khẩu phải có tối thiểu 6 kí tự.";
                    } else if (value == _oldPasswordController.text) {
                      return "Mật khẩu mới phải khác với mật khẩu hiện tại.";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _retypePasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(46, 55, 86, 1),
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
                  onChanged: (value) {
                    if (checkValid()) {
                      _isEnabled.value = true;
                    } else {
                      _isEnabled.value = false;
                    }
                  },
                  validator: (value) {
                    if (value!.length < 6) {
                      return "Mật khẩu phải có tối thiểu 6 kí tự.";
                    } else if (value != _newPasswordController.text) {
                      return "Vui lòng nhập lại mật khẩu trùng với mật khẩu mới.";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
