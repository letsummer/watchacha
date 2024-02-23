import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function() func;
  final String name;
  final bool isChecked;
  final IconData defaultIcon, checkedIcon;

  const Button({
    super.key,
    required this.func,
    required this.name,
    required this.isChecked,
    required this.defaultIcon,
    required this.checkedIcon,
  });

  @override
  Widget build(BuildContext context) {
    // print("anyChecked: $anyChecked");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          IconButton(
            onPressed: func,
            icon: isChecked ? Icon(checkedIcon) : Icon(defaultIcon),
            color: isChecked
                ? Colors.pink
                : Theme.of(context).textTheme.displayLarge!.color,
          ),
          Text(
            name,
            style: TextStyle(
              color: Theme.of(context).textTheme.displayLarge!.color,
            ),
          ),
        ],
      ),
    );
  }
}
