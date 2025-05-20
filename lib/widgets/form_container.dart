import 'package:flutter/material.dart';

import '../utils/colors_manager.dart';

class FormContainerWidget extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final bool ? obscureText;
  final IconData icon;



  const FormContainerWidget(
      {
      Key? key, 
      this.controller,
      this.isPasswordField,
      this.fieldKey,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.inputType, this.obscureText, required this.icon, this.onChanged}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FormContainerWidgetState createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
          prefixIcon: widget.isPasswordField == true
              ? const Icon(
                  Icons.lock,
                  color: Colors.black87,
                )
              :
                Icon( widget.icon,
                  color: Colors.black54,

                ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: widget.isPasswordField == true
                ? Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: _obscureText == false
                        ? ColorManager.primary
                        : ColorManager.secondary,
                  )
                : const Text(""),
          ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
        style: Theme.of(context).inputDecorationTheme.hintStyle,
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        onChanged: widget.onChanged,
    );
  }
}