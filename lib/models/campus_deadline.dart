class CampusDeadline {
  final int id;
  final String title;
  final String course;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;

  const CampusDeadline({
    required this.id,
    required this.title,
    required this.course,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
  });

  CampusDeadline copyWith({
    int? id,
    String? title,
    String? course,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return CampusDeadline(
      id: id ?? this.id,
      title: title ?? this.title,
      course: course ?? this.course,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
