class Weather {
  late String date;
  late String day;
  late String icon;
  late String description;
  late String status;
  late String degree;
  late String min;
  late String max;
  late String night;
  late String humidity; //nem

  String wrong='something went wrong';

  Weather(Map json){
    date=json['date']?? wrong;
    day=json['day']?? wrong;
    icon=json['icon']?? wrong;
    description = json['description'] ?? wrong;
    status = json['status'] ?? wrong;
    degree = json['degree'] ?? wrong;
    min = json['min'] ?? wrong;
    max = json['max'] ?? wrong;
    night = json['night'] ?? wrong;
    humidity = json['humidity'] ?? wrong;
  }

}