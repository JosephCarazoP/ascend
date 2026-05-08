import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isPositive = status == 'reviewed' || status == 'assigned';

    return Chip(
      avatar: Icon(
        _iconForStatus(),
        size: 16,
        color: isPositive ? colorScheme.secondary : colorScheme.onSurface,
      ),
      label: Text(_labelForStatus()),
    );
  }

  IconData _iconForStatus() {
    switch (status) {
      case 'reviewed':
        return Icons.visibility_outlined;
      case 'assigned':
        return Icons.check_circle_outline;
      case 'rejected':
        return Icons.cancel_outlined;
      default:
        return Icons.schedule_outlined;
    }
  }

  String _labelForStatus() {
    switch (status) {
      case 'reviewed':
        return 'Revisada';
      case 'assigned':
        return 'Asignada';
      case 'rejected':
        return 'Rechazada';
      default:
        return 'Pendiente';
    }
  }
}
