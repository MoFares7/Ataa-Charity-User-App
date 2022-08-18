import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sizer/sizer.dart';

import '../../configs/size.dart';
import '../../configs/theme.dart';

class PhoneFormEditing extends StatelessWidget {
  const PhoneFormEditing(
      {Key? key,
      required this.hintText,
      required this.validator,
      required this.controller,
      required this.inputType})
      : super(key: key);

  final TextEditingController controller;

  final String hintText;
  final FieldValidator validator;
  final TextInputType inputType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return tr('The field is required');
          }
          if (!RegExp(
                  '^[\\+]?[(]?[0-9]{3}[)]?[-\\s\\.]?[0-9]{3}[-\\s\\.]?[0-9]{4,6}\$')
              .hasMatch(value)) {
            return tr('Enter the correct value');
          } else {
            return null;
          }
        },
        keyboardType: inputType,
        autofillHints: const [AutofillHints.email],
        decoration: InputDecoration(
          //  filled: true,
          //fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey, // <-- Change this
            fontSize: 8.sp,
            fontWeight: FontWeight.w400,
            // fontStyle: FontStyle.normal,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            //  borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColors.primary1),
          ),
        ),
      ),
    );
  }
}
