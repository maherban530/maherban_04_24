import 'dart:convert';

import 'package:maherban_04_22/Models/task_model.dart';
import 'package:http/http.dart' as http;

class TaskService {
  Future<TaskModel?> fetchData({required int size}) async {
    try {
      http.Response response = await http.get(Uri.tryParse(
          'http://staging-server.in/android-task/api.php?size=$size')!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        return TaskModel.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {}
    return null;
  }
}
