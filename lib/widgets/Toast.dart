import 'package:fluttertoast/fluttertoast.dart';

import '../utils/colors_manager.dart';


void showToast(String label, {bool isError = false}) {
  Fluttertoast.showToast(
      msg: label,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? ColorManager.error : ColorManager.grey2,
      textColor: isError ? ColorManager.white : ColorManager.water,
      fontSize: 16.0);
}