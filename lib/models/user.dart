class User {
  String name;
  String email;
  String password;
  String id;

  User({this.email, this.password, this.name, this.id});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password
    };
  }

  factory User.fromMap(Map<String, dynamic> doc){
    return User(
      name: doc['name'],
      email: doc['email'],
      password: doc['password'],
      id: doc['id']
    );
  }
}