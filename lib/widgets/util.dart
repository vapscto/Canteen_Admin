import 'package:shared_preferences/shared_preferences.dart';

class Util{
    addStringToSf(String name, String value)async{
        SharedPreferences sf = await SharedPreferences.getInstance();
        sf.setString(name, value);
    }
    getStringFromSf()async{
        SharedPreferences sf = await SharedPreferences.getInstance();
        var data = sf.getString("name");
        return data;
    }
    removeFromSf() async{
        SharedPreferences sf = await SharedPreferences.getInstance();
        sf.remove("name");
    }
}