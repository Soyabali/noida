import 'package:flutter/cupertino.dart';



class CompleteListProvider with ChangeNotifier {

  bool isLoaded = false;
  List? completeDataPro;
  bool isTapped = false;
  // Getter and Setter

  ///isLoaded
  bool getIsLoaded() {
    return isLoaded;
  }

  void setIsLoaded(bool value) {
    isLoaded = value;
    notifyListeners();
  }
  ///isTapped
  bool getIsTapped() {
    return isTapped;
  }
  void setIsTapped(bool value) {
    isTapped = value;
    notifyListeners();
  }
  // Repo into the provider
  Future<void> loadRepoInProvider() async {
    /// TODO NEXG TIME YOU SHOULD REMOVE COMMENTS
    //completeDataPro = await UserList().getCompleApi();
     print("dataListProvider 33---: ${completeDataPro}");
    if (completeDataPro != null) {
      setIsLoaded(true);
    }
    notifyListeners();
  }
}