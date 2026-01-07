import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_utility/fonts.dart';


class CustomText extends StatefulWidget {
  final String text;
  final double fontSize;
  final Font font;
  final Color? color;
  final double lineHeight;
  final TextAlign textAlign;
  final GestureTapCallback? onTap;
  final bool isUnderLine;
  final bool isSingleLine;
  final int? maxLines;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextStyle? style;

  const CustomText(
    String text, {super.key, 
    this.fontWeight = FontWeight.w400,
    this.fontStyle,
    this.fontSize = 14,
    this.font = Font.sourceSansProRegular,
    this.color,
    this.lineHeight = 1.5, // Line Height - 24
    this.textAlign = TextAlign.left,
    this.onTap,
    this.isUnderLine = false,
    this.isSingleLine = false,
    this.style,
    this.maxLines,
    //  this.TextOverflow
  })
  // ignore: prefer_initializing_formals
  : text = text;

  @override
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_this
    final Text textWidget = Text(
      widget.text,
      // ignore: unnecessary_this
      textAlign: this.widget.textAlign,

      overflow: widget.isSingleLine ? TextOverflow.ellipsis : null,
      maxLines: widget.maxLines,
      style: widget.style ??

          GoogleFonts.inter(
            decoration: widget.isUnderLine
                ? TextDecoration.underline
                : TextDecoration.none,
              color: widget.color,
              fontSize: widget.fontSize,
            height: widget.lineHeight,
            fontStyle: widget.fontStyle,
            fontWeight: widget.fontWeight,

              ),


      softWrap: true,
    );

    if (widget.onTap != null) {
      return GestureDetector(
        onTap: widget.onTap,
        child: textWidget,
      );
    } else {
      return textWidget;
    }
  }
}

class TextFiledForPhoneVerify extends StatelessWidget {
  const TextFiledForPhoneVerify({
    Key? key,
    this.controller,
    this.onTap,
    this.maxLines,
    this.validator,
    required this.backgroundColor,
    required this.hint,
    required this.filledColor,
  }) : super(key: key);

  final String hint;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool filledColor;
  final Color backgroundColor;
  final int? maxLines;
  final Function? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        height: 55.0,
        width: 55.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white
      ),
        child: Center(
          child: TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[ 0-9]")),
            ],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: maxLines,
            textAlign: TextAlign.center,
            controller: controller,
            maxLength: 1,
            keyboardType:
               TextInputType.number ,
            validator: (input) => validator!(input),
            onTap: onTap,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                counterText: '',
                hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
        ),

    );
  }

}

