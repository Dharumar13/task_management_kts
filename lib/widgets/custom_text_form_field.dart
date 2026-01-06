import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'texts.dart';
import '../app_utility/color_resource.dart';


class TextDropDownField extends StatelessWidget {
  const TextDropDownField(
      {Key? key,
      required this.dropDownList,
      required this.onChanged,
      required this.selectedValue,
      required this.label})
      : super(key: key);

  final List<String> dropDownList;
  final String? selectedValue;
  final String label;
  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
          child: Text(label, style: Texts.primary2a()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            shadowColor: Colors.grey,
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: DropdownButton<String>(
                underline: const SizedBox(),
                isExpanded: true,
                value: selectedValue,
                onChanged: onChanged,
                items: dropDownList
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DialogTextField extends StatelessWidget {
  DialogTextField({
    Key? key,
    this.controller,
    required this.label,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.isNumber = false,
    this.showIcon = false,
    this.preFicIcon = false,
    this.maxLines,
    this.validator,
    this.icons,
    required this.backgroundColor,
    required this.hint,
    required this.isDecoration,
    required this.filledColor,
    this.onSaved,
    this.inputFormatters
  }) : super(key: key);

  final String label;
  final String hint;
  final bool readOnly;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final Function(String value)? onChanged;
  final bool isNumber;
  final bool showIcon;
  final bool filledColor;
  final bool preFicIcon;
  final bool isDecoration;
  final Color backgroundColor;
  final Icon? icons;
  final int? maxLines;
  final Function? validator;
  List<TextInputFormatter>? inputFormatters;


  //final Function(String value)? onSaved;
  final FormFieldSetter<String>? onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: TextFormField(
        maxLines: 1,
        enableSuggestions: false,
        autocorrect: false,
       // autovalidateMode: AutovalidateMode.onUserInteraction,
       autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: ColorResource.colorWhite,
        ),
        inputFormatters: inputFormatters,
        decoration: Texts.textDecoration2(label, hint, showIcon ? icons : null,
            backgroundColor, filledColor, isDecoration, preFicIcon)
          ..copyWith(
            hintText: "",
          ),
        controller: controller,
        keyboardType:
            isNumber ? TextInputType.number : TextInputType.emailAddress,
        readOnly: readOnly,
        validator: (input) => validator!(input),
        onTap: onTap,
        onChanged: onChanged,
        onSaved: onSaved,
      ),
    );
  }
}

class AppTextFormField extends StatelessWidget {
  final TextEditingController? ctrl;
  final String? hintText;
  final String? suffixText;
  bool? isReadOnly = false;
  bool obscureText=false;
  final TextInputType? keyboardType;
  final  TextInputAction? inputAction;
  final Function? validator;
  List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final Function? onFieldSubmitted;
  final Function? onTap;
  final VoidCallback? onTapSuffix;

  AppTextFormField(
      {Key? key,
      this.ctrl,
        this.inputAction,
      this.hintText,
      this.suffixText,
      this.keyboardType,
      this.onFieldSubmitted,
      this.focusNode,
      this.isReadOnly,
      this.onTapSuffix,
      this.onTap, required this.obscureText,
      this.inputFormatters,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style:  const TextStyle(
            color: ColorResource.color232323,
            fontFamily: "Segoe UI",
            fontSize: 16,
            fontWeight: FontWeight.normal),
        controller: ctrl,
        onTap: () => onTap,
        readOnly: isReadOnly == true ? true : false,
        keyboardType: keyboardType,
        obscureText:obscureText ,
        inputFormatters: inputFormatters,
        textInputAction:inputAction ,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // focusNode: focusNode,
       // onFieldSubmitted: (value) => onFieldSubmitted!(value),
        validator: (input) => validator!(input),
        decoration: InputDecoration(
            enabledBorder:  const UnderlineInputBorder(
              borderSide: BorderSide(
                width:0.5, //<-- SEE HERE
                color:Colors.grey,
              ),
            ),
            focusedBorder:  const UnderlineInputBorder(
              borderSide: BorderSide(
                width:0.5, //<-- SEE HERE
                color:Colors.grey,
              ),
            ),
            suffixIcon: suffixText == "cal"
                ? GestureDetector(
                    onTap: onTapSuffix,
                    child: Icon(
                      Icons.calendar_month,
                      color: Colors.grey.withOpacity(0.5),
                    ))
                : suffixText == "pass"?
            GestureDetector(
                onTap: onTapSuffix,
                child: Icon(
                  obscureText==false? Icons.visibility_off:Icons.visibility,
                  color: Colors.grey.withOpacity(0.5),
                )):


            suffixText == null
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 13),
                        child: GestureDetector(
                            onTap: onTapSuffix,
                            child: Text(
                              "$suffixText",
                              style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.5),
                                  fontFamily: "Segoe UI",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200),
                            )),
                      ),
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: "Segoe UI",
                fontSize: 16,
                fontWeight: FontWeight.w200)));
  }
}
