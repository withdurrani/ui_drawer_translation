class Category {
  final String title;
  final String icon;

  Category({
    required this.title,
    required this.icon,
  });

  Category.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        icon = json['icon'];
}
