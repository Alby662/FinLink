class User {
  final String id;
  final String email;
  final String name;
  final String role; // 'client' or 'accountant'
  final String? phone;
  final String? address;
  final String? gstin;
  final String? profileImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.phone,
    this.address,
    this.gstin,
    this.profileImageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a User from JSON data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
      phone: json['phone'],
      address: json['address'],
      gstin: json['gstin'],
      profileImageUrl: json['profile_image_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'phone': phone,
      'address': address,
      'gstin': gstin,
      'profile_image_url': profileImageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Create a copy of User with some fields updated
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? role,
    String? phone,
    String? address,
    String? gstin,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      gstin: gstin ?? this.gstin,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class Connection {
  final String id;
  final String clientId;
  final String accountantId;
  final String status; // 'pending', 'connected', 'rejected'
  final User? client;
  final User? accountant;
  final DateTime createdAt;
  final DateTime updatedAt;

  Connection({
    required this.id,
    required this.clientId,
    required this.accountantId,
    required this.status,
    this.client,
    this.accountant,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a Connection from JSON data
  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      id: json['id'],
      clientId: json['client_id'],
      accountantId: json['accountant_id'],
      status: json['status'],
      client: json['client'] != null ? User.fromJson(json['client']) : null,
      accountant: json['accountant'] != null ? User.fromJson(json['accountant']) : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Convert Connection to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'accountant_id': accountantId,
      'status': status,
      'client': client?.toJson(),
      'accountant': accountant?.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
