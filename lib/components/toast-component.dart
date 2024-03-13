import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';

enum ToastTypeEnum { error, success, warning, info }

class ToastComponent {
  BuildContext? _context;

  ToastComponent(BuildContext context) {
    _context = context;
  }

  static ToastComponent of(BuildContext context) {
    return ToastComponent(context);
  }

  void showError(String mensagem, {int duration = 2000}) {
    show(mensagem, ToastTypeEnum.error, duration);
  }

  void showSuccess(String mensagem, {int duration = 2000}) {
    show(mensagem, ToastTypeEnum.success, duration);
  }

  void showInfo(String mensagem, {int duration = 2000}) {
    show(mensagem, ToastTypeEnum.info, duration);
  }

  void showWarning(String mensagem, {int duration = 2000}) {
    show(mensagem, ToastTypeEnum.warning, duration);
  }

  void show(String mensagem, ToastTypeEnum type, int duration) {
    switch (type) {
      case ToastTypeEnum.error:
        _context!.showErrorBar(content: Text(mensagem), duration: Duration(milliseconds: duration));
        break;
      case ToastTypeEnum.success:
        _context!.showSuccessBar(content: Text(mensagem), duration: Duration(milliseconds: duration));
        break;
      case ToastTypeEnum.info:
        _context!.showInfoBar(content: Text(mensagem), duration: Duration(milliseconds: duration));
        break;
      case ToastTypeEnum.warning:
        _context!.showToast(Text(mensagem), duration: Duration(milliseconds: duration));
        break;
    }
  }

  void showTeste() {
    final snackBar = SnackBar(
      content: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                leading: Icon(Icons.check),
                title: Text('Salvo com sucesso!'),
                subtitle: Text('Seu cadastro foi salvo com sucesso, vamos direcioná-lo a tela de clientes.'),
              ),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 1.5, color: Colors.grey.shade400),
                ),
              ),
              child: const Text('OK', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(_context!).showSnackBar(snackBar);
  }
}
