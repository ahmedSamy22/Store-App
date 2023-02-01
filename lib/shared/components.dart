import 'package:flutter/material.dart';

Widget defaultButton({
  required Function() function,
  Color background = Colors.blue,
  required double width,
  required String text,
}) {
  return (Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: background,
    ),
    width: width,
    height: 40.0,
    child: MaterialButton(
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      onPressed: function,
    ),
  ));
}


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyboardTybe,
  bool isPassword = false,
  required IconData prefixIcon,
  required String label,
   String? Function(dynamic value)? validator,
  Function()? onTap,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? suffixPressed,
  IconData? suffix,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardTybe,
    obscureText: isPassword,
    validator: validator,
    onTap: onTap,
    onChanged: onChange,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon),
      labelText: label,
      border: OutlineInputBorder(),
      suffixIcon: suffix != null
          ? IconButton(
        icon: Icon(suffix),
        onPressed: suffixPressed,
      )
          : null,
    ),
  );
}

