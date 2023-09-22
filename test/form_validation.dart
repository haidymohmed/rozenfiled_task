import 'package:flutter_test/flutter_test.dart';
import 'package:rozenfiled_task/core/functions/validator.dart';


void main() {
  group("Form And Domain Validation", () {
    test('empty userName returns error string', (){
      var result = "".isUserNameValid();
      expect(result, 'Please enter your username');
    });
    test('empty Password returns error string', (){
      var result = "".isPassword();
      expect(result, 'Please enter your password');
    });
    test('Domain success null', (){
      var result = "https://icodesuite.com/icodecrnapi".isDomainValid();
      expect(result, null);
    });
    test('Domain success null', (){
      var result = "192.168.123.132".isDomainValid();
      expect(result, null);
    });
    test('Domain failed empty string', (){
      var result = "domain :dbjdjbdsc".isDomainValid();
      expect(result, '');
    });
    test('Domain failed empty string', (){
      var result = "".isDomainValid();
      expect(result, '');
    });
  });
}