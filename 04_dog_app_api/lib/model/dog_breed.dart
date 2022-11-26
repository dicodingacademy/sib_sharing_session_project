class DogBreed {
  final List<String> message;
  final String status;
  DogBreed({
    required this.message,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
    };
  }

  factory DogBreed.fromJson(Map<String, dynamic> map) {
    return DogBreed(
      message: List<String>.from(map['message']),
      status: map['status'] ?? '',
    );
  }

  @override
  String toString() => 'DogBreed(message: $message, status: $status)';
}
