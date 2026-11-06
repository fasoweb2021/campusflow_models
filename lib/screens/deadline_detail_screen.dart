import 'package:flutter/material.dart';

import '../models/campus_deadline.dart';

class DeadlineDetailScreen extends StatefulWidget {
  final CampusDeadline deadline;
  final ValueChanged<CampusDeadline> onChanged;

  const DeadlineDetailScreen({
    super.key,
    required this.deadline,
    required this.onChanged,
  });

  @override
  State<DeadlineDetailScreen> createState() => _DeadlineDetailScreenState();
}

class _DeadlineDetailScreenState extends State<DeadlineDetailScreen> {
  late CampusDeadline _deadline;

  @override
  void initState() {
    super.initState();
    _deadline = widget.deadline;
  }

  @override
  void didUpdateWidget(covariant DeadlineDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.deadline != widget.deadline) {
      _deadline = widget.deadline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Détail de l’échéance',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _deadline.course,
                          style: TextStyle(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _deadline.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: _deadline.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                      ),
                      const SizedBox(height: 20),
                      _DetailRow(
                        icon: Icons.calendar_month_outlined,
                        label: 'Date limite',
                        value: _formatDate(_deadline.dueDate),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _deadline.description.isEmpty
                            ? 'Aucune description ajoutée.'
                            : _deadline.description,
                        style: Theme.of(context).textTheme.bodyLarge
                            ?.copyWith(height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _deadline.isCompleted ? null : _markAsComplete,
                  icon: Icon(
                    _deadline.isCompleted ? Icons.check_circle : Icons.check,
                  ),
                  label: Text(
                    _deadline.isCompleted
                        ? 'Échéance terminée'
                        : 'Marquer comme fait',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _markAsComplete() {
    final updated = _deadline.copyWith(isCompleted: true);
    setState(() => _deadline = updated);
    widget.onChanged(updated);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Échéance marquée comme terminée.')),
    );
  }

  static String _formatDate(DateTime date) {
    const months = [
      'janvier',
      'février',
      'mars',
      'avril',
      'mai',
      'juin',
      'juillet',
      'août',
      'septembre',
      'octobre',
      'novembre',
      'décembre',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 4),
              Text(value, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}
