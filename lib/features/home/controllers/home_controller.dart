import 'dart:convert';
import 'dart:isolate';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());
  final RxList<dynamic> dataList = <dynamic>[].obs;

  static const String _dataUrl =
      'https://microsoftedge.github.io/Demos/json-dummy-data/5MB.json';

  Future<void> fetchDataWithIsolation() async {
    status.value = RxStatus.loading();
    dataList.clear();

    try {
      final http.Response response = await http.get(Uri.parse(_dataUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = await Isolate.run(
          () => jsonDecode(response.body) as List<dynamic>,
        );
        dataList.value = data;

        status.value = RxStatus.success();
      } else {
        status.value = RxStatus.error(
          'Failed to load data: ${response.statusCode}',
        );
      }
    } catch (e) {
      status.value = RxStatus.error(e.toString());
    }
  }

  Future<void> fetchDataWithoutIsolation() async {
    status.value = RxStatus.loading();
    dataList.clear();
    try {
      final http.Response response = await http.get(Uri.parse(_dataUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        dataList.value = data;

        status.value = RxStatus.success();
      } else {
        status.value = RxStatus.error(
          'Failed to load data: ${response.statusCode}',
        );
      }
    } catch (e) {
      status.value = RxStatus.error(e.toString());
    }
  }
}
