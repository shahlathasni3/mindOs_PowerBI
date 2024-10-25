class ChatUser {
  ChatUser({
    required this.isOnline,
    required this.id,
    required this.createdAt,
    required this.name,
    required this.image,
    required this.email,
    required this.pushToken,
    required this.about,
    required this.lastActive,
    required this.loginTime,
    required this.logoutTime,
  }) {
    totalDuration = _calculateDuration();
  }

  late final bool isOnline;
  late final String id;
  late final String createdAt;
  late final String name;
  late final String image;
  late final String email;
  late final String pushToken;
  late final String about;
  late final String lastActive;
  late final String loginTime;
  late final String logoutTime;
  late final String totalDuration;

  ChatUser.fromJson(Map<String, dynamic> json) {
    isOnline = json['is_online'] ?? false;
    id = json['id'] ?? '';
    createdAt = json['created_at'] ?? '';
    name = json['name'] ?? '';
    image = json['image'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
    about = json['about'] ?? '';
    lastActive = json['last_active'] ?? '';
    loginTime = json['login_time'] ?? '';
    logoutTime = json['logout_time'] ?? '';
    totalDuration = _calculateDuration();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['is_online'] = isOnline;
    data['id'] = id;
    data['created_at'] = createdAt;
    data['name'] = name;
    data['image'] = image;
    data['email'] = email;
    data['push_token'] = pushToken;
    data['about'] = about;
    data['last_active'] = lastActive;
    data['login_time'] = loginTime;
    data['logout_time'] = logoutTime;
    data['total_duration'] = totalDuration;
    return data;
  }

  // Helper function to calculate total duration
  String _calculateDuration() {
    if (loginTime.isEmpty || logoutTime.isEmpty) return '0';

    // Parsing the login and logout times
    DateTime login = DateTime.parse(loginTime);
    DateTime logout = DateTime.parse(logoutTime);

    // Calculate the difference
    Duration duration = logout.difference(login);

    // Format the duration (hours, minutes, seconds)
    return duration.toString();
  }
}
