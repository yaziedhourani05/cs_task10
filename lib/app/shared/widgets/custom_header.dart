import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader(
      {Key? key, required this.title, this.action, required this.enableLeading})
      : super(key: key);
  final String title;
  final Widget? action;
  final bool enableLeading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              enableLeading
                  ? IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    )
                  : Container(),
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
      ),
    );
  }
}
