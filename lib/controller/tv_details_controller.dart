import 'dart:developer';

import 'package:get/get.dart';
import 'package:movie_app/models/tv_details_model.dart';

import '../models/response_data.dart';
import '../utility/network_caller.dart';
import '../utility/urls.dart';

class TvDetailsController extends GetxController {
  bool _loading = false;
  bool get loading => _loading;
  TvDetailsModel _tvDetailsModel = TvDetailsModel();
  TvDetailsModel get tvDetailsModel => _tvDetailsModel;
  Future<void> getTvDetails(int tvId) async {
    _loading = true;
    update();
    final ResponseData response = await NetworkCaller().getRequest(Urls.tvDetails(tvId));
    if (response.isSuccess) {
      _tvDetailsModel = TvDetailsModel.fromJson(response.responseData);
      _loading = false;
      update();
    } else {
      log(response.errorMessage);
      _loading = false;
      update();
    }
  }
}
