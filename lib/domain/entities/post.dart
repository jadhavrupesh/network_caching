class Post {
  final int id;
  final String title;
  final String body;
  final DateTime fetchedAt;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.fetchedAt,
  });

  bool isUpToDate({Duration maxAge = const Duration(minutes: 10)}) {
    return DateTime.now().difference(fetchedAt) < maxAge;
  }
}
