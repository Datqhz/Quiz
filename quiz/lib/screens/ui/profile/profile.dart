import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/screens/ui/profile/setting.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: const Color.fromRGBO(10, 8, 45, 1),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 100,),
            Container(
              height: 50,
              width: 50,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25)
              ),
              child: CircleAvatar(
                child: Image.asset("assets/images/img1.jpg"),
              ),
            ),
            const SizedBox(height: 20,),
            const Text(
              "hoqucojs1",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ),
            ),
            const SizedBox(height: 30,),
            _option("assets/images/book-shelf-64.png", "Thêm khóa học"),
            const SizedBox(height: 20,),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
                },
                child: _option("assets/images/user-setting-64.png", "Cài đặt của bạn")
            ),
            const SizedBox(height: 30,),
            _achievement()
          ],
        ),
      ),
    );
  }
  Widget _option(String iconPath, String optionName){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: const Color.fromRGBO(46, 55, 86, 1), width: 2),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          Image.asset(iconPath, width: 40, height: 40,),
          const SizedBox(width: 12,),
          Text(
            optionName,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white
            ),
          ),
          const Expanded(child: SizedBox(height: 1,)),
          const Icon(
            CupertinoIcons.chevron_right,
            size: 20,
            color: Colors.white,
          )
        ],
      ),
    );
  }
  Widget _achievement(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Thành tựu",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white
            ),
          ),
          const SizedBox(height: 8,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color:const Color.fromRGBO(46, 55, 86, 1),
                borderRadius: BorderRadius.circular(8)
            ),
            child: const Column(
              children: [
                Text(
                  "Hiện chưa có chuỗi nào",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  ),
                ),
                SizedBox(height: 6,),
                Icon(
                  CupertinoIcons.flame,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(height: 6,),
                Text(
                  "Hãy học để bắt đầu chuỗi mới của bạn!",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.white
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


