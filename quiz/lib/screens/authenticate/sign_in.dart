import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:quiz/providers/auth_provider.dart";
import "package:quiz/services/account_service.dart";
import "package:quiz/shared/colors.dart";

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  ValueNotifier _isObscure = ValueNotifier(true);
  ValueNotifier _passwordFocus = ValueNotifier(false);
  ValueNotifier _emailFocus = ValueNotifier(false);

  bool validateEmail(String email) {
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (regex.hasMatch(email)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/logo-icon.png",
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Đăng nhập",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: _emailFocus,
                          builder: (context, value, child) {
                            return TextFormField(
                              controller: _emailController,
                              focusNode: _emailFocusNode,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(29, 161, 242, 1)),
                                ),
                                labelText: value ? 'Email' : null,
                                labelStyle: const TextStyle(fontSize: 16),
                                hintText: !value ? "Email" : null,
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  decoration: TextDecoration.none),
                              validator: (email) {
                                if (email!.isEmpty) {
                                  return "Vui lòng nhập email của bạn!";
                                }
                                if (!validateEmail(email)) {
                                  return "Email của bạn không hợp lệ!";
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ValueListenableBuilder(
                            valueListenable: _isObscure,
                            builder: (context, obscure, child) {
                              return ValueListenableBuilder(
                                valueListenable: _passwordFocus,
                                builder: (context, value, child) {
                                  return TextFormField(
                                    controller: _passwordController,
                                    focusNode: _passwordFocusNode,
                                    decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  29, 161, 242, 1)),
                                        ),
                                        labelText: value ? 'Password' : null,
                                        labelStyle:
                                            const TextStyle(fontSize: 16),
                                        hintText: !value ? "Password" : null,
                                        hintStyle: const TextStyle(
                                            color: Colors.white),
                                        border: InputBorder.none,
                                        errorBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            _isObscure.value = !obscure;
                                          },
                                          icon: obscure
                                              ? const Icon(
                                                  Icons.remove_red_eye_outlined)
                                              : const Icon(
                                                  Icons.remove_red_eye),
                                        ),
                                        suffixStyle: const TextStyle(
                                            color: Colors.white)),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        decoration: TextDecoration.none),
                                    obscureText: obscure,
                                    validator: (password) {
                                      if (password!.isEmpty) {
                                        return "Vui lòng nhập mật khẩu!";
                                      }
                                      if (password.length < 6) {
                                        return "Mật khẩu có ít nhất 6 kí tự!";
                                      }
                                      return null;
                                    },
                                  );
                                },
                              );
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(right: 20, bottom: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.white,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          bool result =
                              await AccountService().signIn(email, password);
                          if (result) {
                            Navigator.pop(context);
                            Provider.of<AuthProvider>(context, listen: false)
                                .login();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                // backgroundColor: Colors.transparent,
                                width:
                                    2.6 * MediaQuery.of(context).size.width / 4,
                                behavior: SnackBarBehavior.floating,
                                content: const Text(
                                    'Tài khoản hoặc mật khẩu sai.'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.backgroundScreenColor,
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          )),
                      child: const Text("Đăng nhập"),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 15,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  CupertinoIcons.xmark,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
