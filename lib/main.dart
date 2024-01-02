import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:note/controller/note_controler.dart';
import 'package:note/util/service/hive_store.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:note/view/home_view.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

// import 'package:bot_toast/bot_toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp( MyApp());
  // await loadSystemFont();
}



class MyApp extends StatelessWidget {
 final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
 MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home:HomeView(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      // navigatorObservers: [BotToastNavigatorObserver()],
      navigatorKey: navigatorKey,
    );
  }
}

// Future<void> loadSystemFont() async {
//   await FontLoader("SystemFont").load();
// }

