import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/models/card.dart';

class FlashCardWidget extends StatefulWidget {
  FlashCardWidget({super.key, required this.card});

  MyCard card;
  @override
  State<FlashCardWidget> createState() => _FlashCardWidgetState();
}

class _FlashCardWidgetState extends State<FlashCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(46, 55, 86, 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.card.term,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                ) ,
              ),
              const Expanded(child: SizedBox(height: 1,)),
              const Icon(CupertinoIcons.star, color: Colors.white,size: 18)
            ],
          ),
          const SizedBox(height: 16,),
          Text(
            widget.card.definition,
            style: const TextStyle(
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
