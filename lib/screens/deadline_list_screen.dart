import 'package:flutter/material.dart';

import '../models/campus_deadline.dart';

class DeadlineListScreen extends StatelessWidget {
  final List<CampusDeadline> deadlines;
  final int? selectedId;
  final ValueChanged<CampusDeadline> onSelected;
  final bool isWide;
  final bool showCompleted;

  const DeadlineListScreen({
    super.key,
    required this.deadlines,
    required this.selectedId,
    required this.onSelected,
    required this.isWide,
    required this.showCompleted,
  });

  @override
  Widget build(BuildContext context) {
    if (deadlines.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                showCompleted ? Icons.task_alt : Icons.event_available,
                size: 52,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                showCompleted
                    ? 'Rien de terminé pour le moment'
                    : 'Tout est à jour !',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                showCompleted
                    ? 'Les échéances terminées apparaîtront ici.'
                    : 'Ajoutez une échéance avec le bouton +.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: deadlines.length,
      itemBuilder: (context, index) {
        final deadline = deadlines[index];
        final selected = deadline.id == selectedId;
        final daysRemaining = _daysBetween(DateTime.now(), deadline.dueDate);
        final color = deadline.isCompleted
            ? Theme.of(context).colorScheme.primary
            : daysRemaining <= 2
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.primary;

        return Card(
          clipBehavior: Clip.antiAlias,
          color: selected && isWide
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surface,
          child: ListTile(
            selected: selected && isWide,
            leading: CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.12),
              foregroundColor: color,
              child: Icon(
                deadline.isCompleted ? Icons.check : Icons.assignment_outlined,
              ),
            ),
            title: Text(
              deadline.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                decoration: deadline.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                '${deadline.course} · ${_formatDate(deadline.dueDate)}',
              ),
            ),
            trailing: Icon(
              isWide ? Icons.chevron_right : Icons.arrow_forward_ios,
              size: 18,
            ),
            onTap: () => onSelected(deadline),
          ),
        );
      },
    );
  }

  static int _daysBetween(DateTime start, DateTime end) {
    final today = DateTime(start.year, start.month, start.day);
    final due = DateTime(end.year, end.month, end.day);
    return due.difference(today).inDays;
  }

  static String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}
