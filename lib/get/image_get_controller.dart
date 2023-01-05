import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:rev/api/controller/image_api_controller.dart';
import 'package:rev/model/api_response.dart';

import '../model/student_image.dart';

typedef ImageCallBack = void Function(ApiResponse apiResponse);

class ImageGetxController extends GetxController {
  @override
  void onInit(){
    // TODO: implement onInit
     reaImage();
    super.onInit();
  }

  static ImageGetxController get to => Get.find();
  final ImageApiController _imageApiController = ImageApiController();
  RxList<StudentImage> imagesList = <StudentImage>[].obs;

  RxBool loading = false.obs;

  void reaImage() async {
    loading.value = true;
    ApiResponse<StudentImage> apiResponse =
        await _imageApiController.indexImage();
    print('we are here');
    loading.value = false;
    if (apiResponse.status) imagesList.value = apiResponse.data ?? [];
  }

  Future<void> uploadImage(
      {required File file, required ImageCallBack imageCallBack}) async {
    print('we are here');
    StreamedResponse streamedResponse =
        await _imageApiController.uploadImage(file: file);
    streamedResponse.stream.transform(utf8.decoder).listen((String body) {
      print('we are  ** ');
      if (streamedResponse.statusCode == 201) {
        var jsonResponse = jsonDecode(body);
        StudentImage studentImage =
            StudentImage.fromJson(jsonResponse['object']);
        imagesList.add(studentImage);
        imageCallBack(ApiResponse(
            message: jsonResponse['message'], status: jsonResponse['status']));
      } else {
        print(streamedResponse.statusCode);
        imageCallBack(ApiResponse(message: 'Server Error', status: false));
      }
    });
  }


  Future<ApiResponse> deleteImage({required int index}) async {
    ApiResponse apiResponse = await _imageApiController.deleteImage(id: imagesList[index].id);
    if(apiResponse.status) {
      imagesList.removeAt(index);
    }
    return apiResponse;
  }
}
