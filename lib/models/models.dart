class User {
  int? id;
  String? name;
  String? username;
  String? email;
  Address? address;
  String? phone;
  String? website;
  Company? company;

  User(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.address,
      this.phone,
      this.website,
      this.company});

  User.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    phone = json['phone'];
    website = json['website'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
  }

  Map toJson() {
    final Map data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['phone'] = phone;
    data['website'] = website;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    return data;
  }
}

class Address {
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  Geo? geo;

  Address({this.street, this.suite, this.city, this.zipcode, this.geo});

  Address.fromJson(Map json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null ? Geo.fromJson(json['geo']) : null;
  }

  Map toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['suite'] = suite;
    data['city'] = city;
    data['zipcode'] = zipcode;
    if (geo != null) {
      data['geo'] = geo!.toJson();
    }
    return data;
  }
}

class Geo {
  String? lat;
  String? lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(Map json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Company {
  String? name;
  String? catchPhrase;
  String? bs;

  Company({this.name, this.catchPhrase, this.bs});

  Company.fromJson(Map json) {
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }

  Map toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['catchPhrase'] = catchPhrase;
    data['bs'] = bs;
    return data;
  }
}

// Comment //
class Comment {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  Comment({this.postId, this.id, this.name, this.email, this.body});

  Comment.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['body'] = body;
    return data;
  }
}

// Todo //
class Todo {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  Todo({this.userId, this.id, this.title, this.completed});

  Todo.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['completed'] = completed;
    return data;
  }
}

class Album {
  int? userId;
  int? id;
  String? title;

  Album({this.userId, this.id, this.title});

  Album.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class Photos {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Photos({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  Photos.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['albumId'] = albumId;
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['thumbnailUrl'] = thumbnailUrl;
    return data;
  }
}

class Posts {
  int? userId;
  int? id;
  String? title;
  String? body;

  Posts({this.userId, this.id, this.title, this.body});

  Posts.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}

