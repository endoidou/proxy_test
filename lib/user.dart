class User {
  User(this.avatarUrl, this.name);

  final String avatarUrl;
  final String name;

  User.fromJson(Map<String, dynamic> json)
      : avatarUrl = json['avatar_url'],
        name = json['name'];
}
