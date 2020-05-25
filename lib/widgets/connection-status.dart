import 'package:flutter/material.dart';
import 'package:connection_status_bar/connection_status_bar.dart';

class ConnectionStatus extends StatelessWidget {
  const ConnectionStatus({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConnectionStatusBar(
        height: 20, // double: default height
        width: double.maxFinite, // double: default width
        color: Theme.of(context)
            .highlightColor, // Color: default background color
        lookUpAddress:
            'google.com', // String: default site to look up for checking internet connection
        endOffset: const Offset(
            0.0, 0.0), // Offset: default animation finish point offset
        beginOffset: const Offset(
            0.0, -1.0), // Offset: default animation start point offset
        animationDuration: const Duration(
            milliseconds: 500), // Duration: default animation duration
        // Text: default text
        title: const Text(
          'Please check your network connection.',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}