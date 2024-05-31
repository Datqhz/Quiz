import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateClassScreen extends StatefulWidget {
  const CreateClassScreen({super.key});

  @override
  State<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {


  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusClassNameNode = FocusNode();
  final FocusNode _focusClassDesNode = FocusNode();

  final ValueNotifier<bool> _classNameFocus = ValueNotifier(false);
  final ValueNotifier<bool> _classDesFocus = ValueNotifier(false);


  final ValueNotifier<bool> _switch = ValueNotifier(true);
  ValueNotifier<String> _className = ValueNotifier("");
  ValueNotifier<String> _classDes = ValueNotifier('');

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
      backgroundColor: Color.fromRGBO(46, 55, 86, 1),
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(10, 8, 45, 1),
          child: Column(
            children: [
              Container(
                child:
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(CupertinoIcons.arrow_left, color: Colors.white,)
                      ),
                      SizedBox(width: 8,),
                      Text(
                        'Lớp mới',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ) ,
                      ),
                      Expanded(child: SizedBox(height: 1,)),
                      IconButton(
                          onPressed: (){},
                          icon: Icon(CupertinoIcons.checkmark_alt, color: Colors.white,)
                      ),
                    ]
                  )
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ValueListenableBuilder(
                  valueListenable: _classNameFocus,
                  builder: (context, value, child){
                    return TextFormField(
                      focusNode: _focusClassNameNode,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(46, 55, 86, 1)
                            ), // Màu viền khi không được chọn
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(
                                53, 59, 79, 1.0), width: 2), // Màu viền khi được chọn
                          ),
                          labelText: value? 'Tên lớp':null,
                          labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.8)
                          ) ,
                          hintText:!value?"Tên lớp":null,
                          hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.8)
                          ),
                          border: InputBorder.none,
                      ),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.none
                      ),
                      onChanged: (value) {
                        _className.value = value;
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ValueListenableBuilder(
                  valueListenable: _classDesFocus,
                  builder: (context, value, child){
                    return TextFormField(
                      focusNode: _focusClassDesNode,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(46, 55, 86, 1)
                          ), // Màu viền khi không được chọn
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(
                              53, 59, 79, 1.0), width: 2), // Màu viền khi được chọn
                        ),
                        labelText: value? 'Mô tả':null,
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.8)
                        ) ,
                        hintText:!value?"Mô tả":null,
                        hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.8)
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.none
                      ),
                      onChanged: (value) {
                        _classDes.value = value;

                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Cho phép thành viên lớp thêm học phần và thành viên mới',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                        ) ,
                      ),
                    ),
                    SizedBox(width: 12,),
                    ValueListenableBuilder(
                        valueListenable: _switch,
                        builder:(context, value, chid){
                          return Switch(
                              value: value,
                              activeColor: Colors.red,
                              onChanged: (bool value){
                                _switch.value = value;
                              }
                          );
                        }
                    )

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusClassDesNode.dispose();
    _focusClassNameNode.dispose();
    super.dispose();
  }
}
