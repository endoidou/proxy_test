class User {
  late String avatarUrl;
  late String name;

  User.fromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatar_url'];
    name = json['name'];
  }
}
