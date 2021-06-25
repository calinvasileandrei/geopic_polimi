import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

///This class contains all the information of a position: The location name 'location' and the geolocation values 'position'
class PositionLocation extends Equatable {
  Position position;
  String location;

  PositionLocation({this.position, this.location});

  ///This method allows to retrieve a PositionLocation Instance given a json string
  factory PositionLocation.fromJson(Map<String, dynamic> json) {
    return PositionLocation(
      position: json['position'],
      location: json['location'],
    );
  }

  @override
  List<Object> get props => [position.latitude,position.longitude,location];
}
