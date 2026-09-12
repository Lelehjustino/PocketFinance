import 'package:flutter/material.dart';

class BottomItem extends StatelessWidget {
  final IconData icon;
  final String texto;
  final bool selecionado;
  final VoidCallback? onTap;
  const BottomItem({
    super.key,
    required this.icon,
    required this.texto,
    required this.selecionado,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: selecionado
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 2),
              Text(
                texto,
                style: TextStyle(
                  fontSize: 9,
                  color: selecionado
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
