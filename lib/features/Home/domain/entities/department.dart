class Department {
  final String name;
  final int count;
  final String? id;
  final double percentage;

  const Department({
    required this.name,
    required this.count,
    this.id,
    this.percentage = 0.0,
  });
}