import 'package:flutter/material.dart';
import '../../../constant.dart';
import 'app_text.dart.dart';

class AddNewButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  const AddNewButton({super .key,  this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap ?? (){

      },
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: primaryColor,
            ),
            child: Center(
              child: Icon(Icons.add,color: Colors.white,),
            ),
          ),
          SizedBox(width: 5,),
          AppTextWidget(text: text,fontSize: 14,color: Colors.black,)
        ],
      ),
    );
  }
}
