class User{
  String uid;
  String name;
  String email;
  String imageURL;

  User({this.name, this.email, this.imageURL, this.uid});

  User.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    email = json['Email'];
    imageURL = json['ImageURL'];
    uid = json['Uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['ImageURL'] = this.imageURL;
    data['Uid'] = this.uid;
    return data;
  }
}