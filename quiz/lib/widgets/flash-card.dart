import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlashCardWidget extends StatefulWidget {
  const FlashCardWidget({super.key});

  @override
  State<FlashCardWidget> createState() => _FlashCardWidgetState();
}

class _FlashCardWidgetState extends State<FlashCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(46, 55, 86, 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Term',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                ) ,
              ),
              Expanded(child: SizedBox(height: 1,)),
              Icon(CupertinoIcons.star, color: Colors.white,size: 18)
            ],
          ),
          SizedBox(height: 16,),
          Text(
            'Defination',
            style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w500
            ) ,
          ),
        ],
      ),
    );
  }
}
