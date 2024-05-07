class UserData {
  final int id;
  final String firstname;
  final String avatar;
  UserData({
    required this.id,
    required this.firstname,
    required this.avatar,
  });
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      firstname: json['first_name'] ?? 'Imie',
      avatar: json['avatar'],
    );
  }
}
