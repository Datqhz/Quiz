import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/models/class.dart';
import 'package:quiz/providers/notify_change_provider.dart';
import 'package:quiz/services/class_service.dart';

class CreateClassScreen extends StatefulWidget {
  CreateClassScreen({super.key, required this.classStream});

  NotifyChangeStream classStream;
  @override
  State<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final FocusNode _focusClassNameNode = FocusNode();
  final FocusNode _focusClassDesNode = FocusNode();

  final ValueNotifier<bool> _classNameFocus = ValueNotifier(false);
  final ValueNotifier<bool> _classDesFocus = ValueNotifier(false);

  final ValueNotifier<bool> _switch = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _focusClassNameNode.addListener(() {
      _classNameFocus.value = true;
      _classDesFocus.value = false;
    });
    _focusClassDesNode.addListener(() {
      _classNameFocus.value = false;
      _classDesFocus.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(46, 55, 86, 1),
      body: SafeArea(
        child: Container(
          color: const Color.fromRGBO(10, 8, 45, 1),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                    child: Row(children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        CupertinoIcons.arrow_left,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'Lớp mới',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  const Expanded(
                      child: SizedBox(
                    height: 1,
                  )),
                  IconButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          ClassRequest classRequest = ClassRequest(
                              classId: 0,
                              className: _nameController.text.trim(),
                              description: _desController.text.trim());
                          print(_nameController.text.trim());
                          bool rs =
                              await ClassService().createClass(classRequest);
                          if (rs) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                width:
                                    2.6 * MediaQuery.of(context).size.width / 4,
                                behavior: SnackBarBehavior.floating,
                                content: const Text(
                                  'Tạo lớp thành công.',
                                  textAlign: TextAlign.center,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                            widget.classStream.notifyDataChanged();
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                width:
                                    2.6 * MediaQuery.of(context).size.width / 4,
                                behavior: SnackBarBehavior.floating,
                                content: const Text(
                                  'Xảy ra lỗi trong quá trình tạo.',
                                  textAlign: TextAlign.center,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(
                        CupertinoIcons.checkmark_alt,
                        color: Colors.white,
                      )),
                ])),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ValueListenableBuilder(
                    valueListenable: _classNameFocus,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: _nameController,
                        focusNode: _focusClassNameNode,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(46, 55, 86,
                                    1)), // Màu viền khi không được chọn
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(53, 59, 79, 1.0),
                                width: 2), // Màu viền khi được chọn
                          ),
                          labelText: value ? 'Tên lớp' : null,
                          labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.8)),
                          hintText: !value ? "Tên lớp" : null,
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.8)),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            decoration: TextDecoration.none),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Vui lòng nhập tên lớp";
                          }
                          return null;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ValueListenableBuilder(
                    valueListenable: _classDesFocus,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: _desController,
                        focusNode: _focusClassDesNode,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(46, 55, 86,
                                    1)), // Màu viền khi không được chọn
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(53, 59, 79, 1.0),
                                width: 2), // Màu viền khi được chọn
                          ),
                          labelText: value ? 'Mô tả' : null,
                          labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.8)),
                          hintText: !value ? "Mô tả" : null,
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.8)),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            decoration: TextDecoration.none),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Vui lòng nhập mô tả";
                          }
                          return null;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'Cho phép thành viên lớp thêm học phần và thành viên mới',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      ValueListenableBuilder(
                          valueListenable: _switch,
                          builder: (context, value, chid) {
                            return Switch(
                                value: value,
                                activeColor: Colors.red,
                                onChanged: (bool value) {
                                  _switch.value = value;
                                });
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _desController.dispose();
    _focusClassDesNode.dispose();
    _focusClassNameNode.dispose();
    super.dispose();
  }
}
