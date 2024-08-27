import 'package:flutter/material.dart';
import 'package:zeko_hotel_crm/main.dart';

class AnimatedButton extends StatefulWidget {
  final Function? onPressed;
  final ButtonState? state;
  final Widget child;

  AnimatedButton(
      {Key? key,
      this.onPressed,
      this.state = ButtonState.idle,
      required this.child})
      : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

enum ButtonState { idle, loading, success, error }

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.state == ButtonState.loading
          ? 50
          : 200, // Adjust width for loading state
      height: 50, // Keep height consistent
      child: ElevatedButton(
        onPressed: widget.state == ButtonState.loading
            ? null
            : () => widget.onPressed?.call(),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (widget.state == ButtonState.success) return Colors.green;
            if (widget.state == ButtonState.error) return Colors.red;
            return ThemeQuery.primary;
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  widget.state == ButtonState.loading
                      ? 25.0
                      : 30.0), // Circular shape in loading state
            ),
          ),
        ),
        child: _buildChild(),
      ),
    );
  }

  Widget _buildChild() {
    if (widget.state == ButtonState.loading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      );
    } else if (widget.state == ButtonState.success) {
      return const Icon(Icons.check, color: Colors.white);
    } else if (widget.state == ButtonState.error) {
      return const Icon(Icons.error, color: Colors.white);
    } else {
      return widget.child;
    }
  }
}
