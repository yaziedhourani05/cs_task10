import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({Key? key, required this.title, this.action})
      : super(key: key);
  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ],
        ),
        action != null ? action! : Container(),
      ],
    );
  }
}
