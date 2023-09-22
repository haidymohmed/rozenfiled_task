
class Resource {
  int? id;
  String? username;
  String? password;
  String? name;
  int? userRole;
  String? imageURL;
  String? pacsUsername;
  String? risUserID;
  int? institutionID;
  bool? isActive;
  var createCriticalResult;
  String? created;
  var modified;
  int? createdBy;
  var modifiedBy;
  String? deviceToken;
  String? token;
  List<Contacts>? contacts;

  Resource(
      {id,
        this.username,
        this.password,
        this.name,
        this.userRole,
        this.imageURL,
        this.pacsUsername,
        this.risUserID,
        this.institutionID,
        this.isActive,
        this.createCriticalResult,
        this.created,
        this.modified,
        this.createdBy,
        this.modifiedBy,
        this.deviceToken,
        this.token,
        this.contacts});

  Resource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    name = json['name'];
    userRole = json['userRole'];
    imageURL = json['imageURL'];
    pacsUsername = json['pacsUsername'];
    risUserID = json['risUserID'];
    institutionID = json['institutionID'];
    isActive = json['isActive'];
    createCriticalResult = json['createCriticalResult'];
    created = json['created'];
    modified = json['modified'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    deviceToken = json['deviceToken'];
    token = json['token'];
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(Contacts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['password'] = password;
    data['name'] = name;
    data['userRole'] = userRole;
    data['imageURL'] = imageURL;
    data['pacsUsername'] = pacsUsername;
    data['risUserID'] = risUserID;
    data['institutionID'] = institutionID;
    data['isActive'] = isActive;
    data['createCriticalResult'] = createCriticalResult;
    data['created'] = created;
    data['modified'] = modified;
    data['createdBy'] = createdBy;
    data['modifiedBy'] = modifiedBy;
    data['deviceToken'] = deviceToken;
    data['token'] = token;
    if (contacts != null) {
      data['contacts'] = contacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contacts {
  int? id;
  int? userID;
  int? type;
  String? value;
  bool? isDefault;
  bool? isNew;
  var userName;

  Contacts(
      {id,
        this.userID,
        this.type,
        this.value,
        this.isDefault,
        this.isNew,
        this.userName});

  Contacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    type = json['type'];
    value = json['value'];
    isDefault = json['isDefault'];
    isNew = json['isNew'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userID'] = userID;
    data['type'] = type;
    data['value'] = value;
    data['isDefault'] = isDefault;
    data['isNew'] = isNew;
    data['userName'] = userName;
    return data;
  }
}