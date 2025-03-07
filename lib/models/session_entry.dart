class SessionEntry {
  final int id;
  final int sessionId;
  final int userId;
  final Enum state;

  SessionEntry({required this.id, 
  required this.sessionId,
  required this.userId,
  required this.state});

  factory SessionEntry.fromJson(Map<String, dynamic> json) {
    return SessionEntry(
      id: json['id'],
      sessionId: json['sessionId'],
      userId: json['userId'],
      state: json['state']
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id,
    'sessionId': sessionId,
    'userId': userId,
    'type': state};
  }
}