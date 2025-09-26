import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:repaso/domain/entities/entities_people.dart';
import 'package:repaso/global/enveironment.dart';
import 'dart:convert';

class ServicePeople {
  final url = Uri.parse(Enveironment.apiUrl);

  Future<People> getData() async {
    final response = await http.get(url);

    if(response.statusCode == 200){
      final Map<String, dynamic> decode = json.decode(response.body);
      return People.fromJson(decode);

    }else {
      throw Exception("ERROR AL CARGAR LOS DATOS");
    }

  }
}