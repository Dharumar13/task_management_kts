class Singleton {
  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  String token='';
  String greetings='';
  String userFirstName='';
  String userLastName='';
  String emailID='';
  String image='';

  int userType = 0;
  int percentage = 0;

  String?isDevice;
  String?site="";
  String?agency="";
  String?siteID="";
  String?layoutDate="";
  bool?isPortrait=false;
  bool? isConnection=false;
  Singleton._internal();



}