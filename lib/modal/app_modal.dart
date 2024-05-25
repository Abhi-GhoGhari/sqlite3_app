class Student {
  int id;
  String name;
  String email;

  Student(this.name, this.email, this.id);

  factory Student.fromMap(Map data) => Student(
        data['name'],
        data['email'],
        data['id'],
      );

  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name,
        'email': email,
      };
}
