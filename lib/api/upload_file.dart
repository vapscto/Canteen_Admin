import 'dart:io';

import 'package:canteen_management/constants/api_url.dart';
import 'package:canteen_management/model/upload_image_model.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../controller/global_utility.dart';
import '../main.dart';

Future<UploadHwCwModel> uploadAtt(
    {required int miId, required File file}) async {
  final  ins = Dio();
  final String uploadFile =
      "https://bdcampus.azurewebsites.net/${URLS.uploadHomeWorkEnd}";

  String? mime = lookupMimeType(file.path);
  if (mime == null) {
    logger.d("mime null");
  }
  try {
    final Response response = await ins.post(uploadFile,
        options: Options(headers: getSession()),
        data: FormData.fromMap(
          {
            "MI_Id": miId,
            "File": await MultipartFile.fromFile(
              file.path,
              contentType:
              MediaType(mime!.split("/").first, mime.split("/").last),
            )
          },
        ));

    return Future.value(UploadHwCwModel.fromMap(response.data.first));
  } catch (e) {
    return Future.error({"error Occured"});
  }
}