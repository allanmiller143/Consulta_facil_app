
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/no_internet_page.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController extends GetxController {
  final Connectivity connectivity = Connectivity();
  late MyGlobalController myGlobalController;

  @override
  void onInit(){
    super.onInit();
    connectivity.onConnectivityChanged.listen(atualizaStatusConexao);
    myGlobalController = Get.find();
    
  }

  void atualizaStatusConexao(ConnectivityResult connectivityResult) {
  if (connectivityResult == ConnectivityResult.none) {
    myGlobalController.internet.value = false;
    Get.to(NoInternetPage());
  } else {
    myGlobalController.internet.value = true;
    Get.back();
  }
}



 
}

