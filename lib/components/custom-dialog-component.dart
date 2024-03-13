import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDialogComponent {
  static void show(BuildContext context, String title, Widget? content, List<Widget>? actions) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          title: Container(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87)),
                ),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      FontAwesomeIcons.xmark,
                      color: Colors.black45,
                    ))
              ],
            ),
          ),
          content: SizedBox(width: MediaQuery.of(context).size.width, child: content),
          actions: actions,
        );
      },
    );
  }
}

extension CustomDialogComponentExtension on BuildContext {
  void showDialogComponent(String title, {Widget? content, List<Widget>? actions}) {
    CustomDialogComponent.show(this, title, content, actions);
  }
}
