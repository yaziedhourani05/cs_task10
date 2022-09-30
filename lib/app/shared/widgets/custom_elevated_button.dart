import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key, required this.label, required this.onPressed})
      : super(key: key);
  final String label;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 30),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            //gives button style when hovered or pressed
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Colors.white;
                }
                return null;
              },
            ),
            //gives text in button style when clicked or pressed
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered) ||
                  states.contains(MaterialState.pressed)) {
                return Colors.orange;
              }
              return Colors.white;
            }),
            //gives button border
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.orange),
              ),
            ),
            //gives button color
            backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
          ),
          onPressed: onPressed,
          child: Text(label),
        ),
      ),
    );
  }
}
