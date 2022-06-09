import 'package:flutter/material.dart';
import 'package:hsp_gate/helpers/constant.dart';

class TextFormFieldWdiget extends StatefulWidget {
  final TextInputType textInputType;
  final String hintText;
  final Widget prefixIcon;
  final FocusNode focusNode;
  final bool obscureText;
  final TextEditingController controller;
  final Function functionValidate;
  final String parametersValidate;
  final TextInputAction actionKeyboard;
  final Function onSubmitField;
  final Function onFieldTab;

  const TextFormFieldWdiget(
      {Key? key,
      required this.hintText,
      required this.focusNode,
      required this.textInputType,
      this.obscureText = false,
      required this.controller,
      required this.functionValidate,
      required this.parametersValidate,
      this.actionKeyboard = TextInputAction.next,
      required this.onSubmitField,
      required this.onFieldTab,
      required this.prefixIcon})
      : super(key: key);

  @override
  State<TextFormFieldWdiget> createState() => _TextFormFieldWdigetState();
}

class _TextFormFieldWdigetState extends State<TextFormFieldWdiget> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(primaryColor: Warna.hitam),
        child: TextFormField(
          cursorColor: Warna.hitam,
          obscureText: widget.obscureText,
          keyboardType: widget.textInputType,
          textInputAction: widget.actionKeyboard,
          focusNode: widget.focusNode,
          style: TextStyle(
              color: Warna.hitam,
              fontSize: 16,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2),
          decoration: InputDecoration(
              prefixIcon: Align(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: widget.prefixIcon,
              ),
              hintText: widget.hintText,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Warna.hitam)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Warna.hitam)),
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
                letterSpacing: 1.2,
              ),
              contentPadding: EdgeInsets.only(
                  top: 12, bottom: bottomPaddingToError, left: 8.0, right: 8.0),
              isDense: true,
              errorStyle: TextStyle(
                color: Warna.kuning,
                fontSize: 12,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
                letterSpacing: 1.2,
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Warna.kuning),
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Warna.kuning))),
          controller: widget.controller,
          validator: (value) {
            // String resultValidate =
            //     widget.functionValidate(value, widget.parametersValidate);

            // return resultValidate;

            if (value == null || value.isEmpty) {
              return widget.functionValidate(value, widget.parametersValidate);
            }

            return null;
          },
          onFieldSubmitted: (value) {
            widget.onSubmitField();
          },
          onTap: () {
            widget.onFieldTab();
          },
        ));
  }
}

String? commonValidation(String value, String messageError) {
  var required = requiredValidator(value, messageError);

  if (required != null) {
    return required;
  }

  return null;
}

String? requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }

  return null;
}

void changeFocus(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();

  FocusScope.of(context).requestFocus(nextFocus);
}
