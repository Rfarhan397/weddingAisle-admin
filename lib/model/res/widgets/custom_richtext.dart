import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class CustomRichText extends StatelessWidget {
  final String firstText,secondText;
  final FontWeight? fontWeight,secondFontWeight;
  final VoidCallback press;
  double firstSize,secondSize;
  CustomRichText({super.key,
    required this.firstText,
    required this.secondText ,
    required this.press,
    this.firstSize = 12.0,
    this.secondSize = 12.0,
    this.fontWeight = FontWeight.normal,
    this.secondFontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
          text: firstText,
          style:  TextStyle(fontWeight: fontWeight,color:  Colors.black,fontSize: firstSize,),
          children: <InlineSpan>[
            const WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: SizedBox(width: 5.0)),
            TextSpan(
              text: secondText,
              style:  TextStyle(fontWeight: secondFontWeight,color: Colors.black,fontSize: secondSize),
              recognizer: TapGestureRecognizer()
                ..onTap = press,
            ),
          ],
        )
    );
  }
}
