import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;
  const DashboardItem({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: onTap != null
            ? Theme.of(context).colorScheme.primary
            : Colors.grey[400],
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
