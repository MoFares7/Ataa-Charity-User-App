import 'package:charity_management_system/configs/size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sizer/sizer.dart';

import '../../configs/theme.dart';

class TextFormEditing extends StatelessWidget {
  const TextFormEditing(
      {Key? key,
      required this.hintText,
      required this.validator,
      required this.controller})
      : super(key: key);

  final TextEditingController controller;

  final String hintText;
  final FieldValidator validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return  tr('The field is required');
          }
          if (!RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(value)) {
            return tr('Enter the correct value');
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).primaryColor,
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

class NameFormEditing extends StatelessWidget {
  const NameFormEditing(
      {Key? key,
      required this.hintText,
      required this.validator,
      required this.controller})
      : super(key: key);

  final TextEditingController controller;

  final String hintText;
  final FieldValidator validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return tr('The field is required');
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.name,
        autofillHints: const [AutofillHints.email],
        decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).primaryColor,
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
            ),),
      ),
    );
  }
}
