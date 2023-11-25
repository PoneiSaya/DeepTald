
class Admin{
  late String _id;
  late String _email;
  late String _password;

  Admin(this._email, this._password);

  get getId => _id;
  get getEmail => _email;
  get getPassword => _password;

  toJson(String? id) {
    return {
      'uid': id,
      "Email": getEmail,
      "Password": getPassword
    };
  }
}