class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String? caregiverId; // Nullable caregiver ID

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.caregiverId,
  });

  // Convert Firestore data to UserModel
  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? 'user',
      caregiverId: data['caregiverId'],
    );
  }

  // Convert UserModel to Firestore format
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'caregiverId': caregiverId,
    };
  }
}
