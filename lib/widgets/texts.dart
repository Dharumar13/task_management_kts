import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_utility/color_resource.dart';
import '../app_utility/fonts.dart';

class Texts {
  static TextStyle primary2a() {
    return const TextStyle(
      color: ColorResource.color232323,
      fontSize: 16,
    );
  }

  static TextStyle style(size, color, weight) {
    return TextStyle(color: color, fontSize: size, fontWeight: weight);
  }

  static InputDecoration border() {
    return const InputDecoration(
      hintStyle: TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration textDecoration2(label, hint, icon, Color? color,
      bool isFalse, bool isDecoration, bool isPreFix) {
    return InputDecoration(
        hintText: hint,
        isDense: true,
        suffixIcon:  GestureDetector(
            //onTap: isPreFix,
            child: Icon(
              isPreFix==false? Icons.visibility_off:Icons.visibility,
              color: Colors.grey.withOpacity(0.5),
            )),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical:15.0),
        hintStyle: GoogleFonts.inter(fontWeight: FontWeight.w500,fontSize:FontSize1.thirteen,color: ColorResource.color232323),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width:2.0, color: ColorResource.colorE0E3E7), //<-- SEE HERE
        ),
        border:const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width:2.0, color: ColorResource.colorE0E3E7), //<-- SEE HERE
        ) ,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width:2.0, color: ColorResource.colorE0E3E7), //<-- SEE HERE
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width:2.0, color: ColorResource.colorE65454), //<-- SEE HERE
        ),



        errorStyle: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize:FontSize1.thirteen,color: ColorResource.colorE65454));
  }

  static BoxDecoration decoration(color) {
    return BoxDecoration(color: color, borderRadius: BorderRadius.circular(15));
  }
}
