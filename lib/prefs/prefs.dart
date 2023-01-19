
import 'package:hive/hive.dart';

class PrefsBoxKeys {
  static const adoptedPets = 'mostOrdered';
  static const theme='theme';
 
}

class PrefsDb {
  static var prefsBox = Hive.box('prefs');
  static bool  get getTheme=>prefsBox.get(PrefsBoxKeys.theme,defaultValue: false);
  static List<dynamic>  get adoptedOnes =>
      prefsBox.get(PrefsBoxKeys.adoptedPets, defaultValue: <dynamic>[]);

  static Box get box => prefsBox;
  static void saveTheme(bool isDarkMode) => prefsBox.put(
        PrefsBoxKeys.theme,
        isDarkMode,
      );
  static void saveOrders(List<dynamic> adoptedPets) => prefsBox.put(
        PrefsBoxKeys.adoptedPets,
        adoptedPets,
      );

}