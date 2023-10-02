
import 'package:flutter/material.dart';

class CountButton extends StatelessWidget {
  const CountButton({
    super.key,
    required this.tap,
    required this.icon,
  });

  final IconData icon;
  final Function() tap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: tap,
        borderRadius: BorderRadius.circular(5),
        splashColor: Theme.of(context).primaryColor.withOpacity(.2),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
