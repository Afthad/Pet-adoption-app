import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pet_adopt_app/routes.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
    var appDocDir = await getApplicationDocumentsDirectory();
  Hive.init('${appDocDir.path}/db');
  await Hive.openBox('prefs');
  runApp(const MyApp());
 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      darkTheme:_darkTheme ,
      theme: _lightTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/homeScreen',
   getPages: AppRouter.routes,
 // specify the fallback locale in case an invalid locale is selected.
);
  }
}


ThemeData _darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,

    appBarTheme: AppBarTheme(backgroundColor: Colors.black)
);

ThemeData _lightTheme = ThemeData(
   scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    primaryColor: Colors.white,
     appBarTheme: AppBarTheme(backgroundColor: Colors.white)
   );