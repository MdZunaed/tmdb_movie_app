import 'dart:developer';

import 'package:get/get.dart';
import 'package:movie_app/models/response_data.dart';
import 'package:movie_app/models/tv_list_model.dart';
import 'package:movie_app/utility/network_caller.dart';
import 'package:movie_app/utility/urls.dart';

class TvListController extends GetxController {
  bool _loading = false;
  bool get loading => _loading;
  TvListModel _tvListModel = TvListModel();
  List<TV>? get tvList => _tvListModel.tvs;
  Future<void> getTvList() async {
    _loading = true;
    update();
    final ResponseData response = await NetworkCaller().getRequest(Urls.tvList);
    if (response.isSuccess) {
      _tvListModel = TvListModel.fromJson(response.responseData);
      _loading = false;
      update();
    } else {
      log(response.errorMessage);
      _loading = false;
      update();
    }
  }
}
