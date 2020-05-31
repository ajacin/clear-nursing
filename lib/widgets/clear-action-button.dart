import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClearActionButton extends StatefulWidget {

  final void Function() parentAction;
  final String label;

  const ClearActionButton({Key key, this.label, this.parentAction}) : super(key: key);

  @override
  _ClearActionButtonState createState() => _ClearActionButtonState();
}

class _ClearActionButtonState extends State<ClearActionButton>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.parentAction();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Transform.scale(
        scale: _scale,
        child: _ClearActionButtonUI,
      ),
    );
  }

  Widget get _ClearActionButtonUI => Container(
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 30.0,
              offset: Offset(0.0, 30.0),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              // Color(0xFFA7BFE8),
              // Color(0xFF6190E8),
              Theme.of(context).accentColor,
              Theme.of(context).highlightColor
            ],
          ),
        ),
        child: Center(
          child: Text(
          widget.label,
          style: GoogleFonts.poiretOne(
            textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: .5),
          ),
        ),
        ),
      );
}
