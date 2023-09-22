// ignore_for_file: constant_identifier_names

 import 'dart:developer';

String IP_REGEXP= "[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}" ;
extension ValidatorExtention on String?{
  String? isValid(){
    if(toString().isEmpty){
      return "";
    }else{
      return null;
    }
  }
  String? isUserNameValid(){
    if(toString().isEmpty){
      return "Please enter your username";
    }else{
      return null ;
    }
  }
  String? isDomainValid(){
    if(toString().isNotEmpty && toString().trim().contains(" ") == false){
      return null;
    }else{
      return "";
    }
  }
  String? isPassword(){
    if(toString().isEmpty){
      return "Please enter your password";
    }else{
      return null ;
    }
  }

  bool isDate(){
    try {
      DateTime.parse(notNull());
      return true;
    } catch (e) {
      return false;
    }
  }

  DateTime toDate(){
    if(isDate() == true){
      return DateTime.parse(notNull());
    }else{
      return DateTime.now();
    }
  }

  notNull(){
    return this ?? "" ;
  }
}
extension NullBoolExtention on bool?{
  notNull(){
    return this ?? false ;
  }
}

extension NullIntExtention on int?{
  notNull(){
    return this ?? 0 ;
  }
}

extension NullListExtention on List?{
  notNull(){
    return this ?? [] ;
  }
}

extension NullListOfObjectExtention on List<Object>?{
  notNull(){
    return this ?? [] ;
  }
}
