import 'package:flutter/material.dart';

class ProgressIndicatorComponent {
  OverlayEntry? _progressOverlayEntry;

  void show(BuildContext context) {
    _progressOverlayEntry = _createdProgressEntry(context);
    Overlay.of(context).insert(_progressOverlayEntry!);
  }

  void showCustom(BuildContext context, Widget widget, double width, double height) {
    _progressOverlayEntry = _createdOverlayEntry(context, widget, width, height);
    Overlay.of(context).insert(_progressOverlayEntry!);
  }

  void hide() {
    if (_progressOverlayEntry != null) {
      _progressOverlayEntry!.remove();
      _progressOverlayEntry = null;
    }
  }

  OverlayEntry _createdOverlayEntry(BuildContext context, Widget widget, double width, double height) => OverlayEntry(
        builder: (BuildContext context) {
          return Stack(
            children: [
              Container(
                color: Colors.black54,
              ),
              Positioned(
                top: (screenHeight(context) - height) / 2,
                left: (screenWidth(context) - width) / 2,
                child: Center(
                  child: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.transparent),
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      color: Colors.white.withOpacity(0.8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: widget,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );

  OverlayEntry _createdProgressEntry(BuildContext context) => OverlayEntry(
        builder: (BuildContext context) {
          double _containerHeight = 90.0;
          double _containerWidth = 220.0;

          return Stack(
            children: <Widget>[
              Container(
                color: Colors.black54,
              ),
              Positioned(
                top: (screenHeight(context) - _containerHeight) / 2,
                left: (screenWidth(context) - _containerWidth) / 2,
                child: Center(
                  child: Container(
                    height: _containerHeight,
                    width: _containerWidth,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.transparent),
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      color: Colors.white.withOpacity(0.8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(children: [
                        const CircularProgressIndicator(),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Aguarde...", style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColor, decoration: TextDecoration.none))
                      ]),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );

  double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
}
