class User {
  final int? id;
  final String? email;
  final String? password;
  final String? name;

  User({this.id, this.email, this.password, this.name});

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'email' : email,
      'password' : password,
      'name' : name,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      name: map['name'],
    );
  }
}