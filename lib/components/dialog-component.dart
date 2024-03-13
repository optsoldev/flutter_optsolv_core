import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DialogComponent {
  static Future<void> show(BuildContext context, String title, String description, List<DialogButtonComponent> buttons,
      {VoidCallback? closeFunction, String textoFechar = ''}) async {
    await Alert(
      context: context,
      title: title,
      desc: description,
      closeFunction: () {
        Navigator.of(context, rootNavigator: true).pop();
        if (closeFunction != null) {
          closeFunction.call();
        }
      },
      buttons: buttons.isNotEmpty
          ? buttons.map((e) => e.getButton(context)).toList()
          : (textoFechar.isNotEmpty
              ? [
                  DialogButtonComponent(label: textoFechar, onPressed: () => Navigator.of(context, rootNavigator: true).pop(), type: DialogButtonComponentType.confirm)
                      .getButton(context)
                ]
              : []),
    ).show();
  }
}

class DialogButtonComponent {
  final String label;
  final VoidCallback onPressed;
  final DialogButtonComponentType type;

  const DialogButtonComponent({required this.label, required this.onPressed, required this.type});

  DialogButton getButton(BuildContext context) {
    if (type == DialogButtonComponentType.confirm) {
      return DialogButton(
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      );
    } else {
      return DialogButton(
        onPressed: onPressed,
        color: Colors.red[500],
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      );
    }
  }
}

enum DialogButtonComponentType { confirm, cancel }
