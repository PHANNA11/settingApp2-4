import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controller/local_lang_controller.dart';
import 'controller/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  runApp(const MyApp());
}

ThemeModeController themeModeController = Get.put(ThemeModeController());
TraslateLanguege traslateLanguege = Get.put(TraslateLanguege());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleBuilder(builder: (context) {
      return GetMaterialApp(
        title: 'Flutter Demo',
        theme: themeModeController.theme,
        initialRoute: traslateLanguege.initlanguege().toString(),
        translations: LocalModel(),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        locale: traslateLanguege.english.value
            ? const Locale('en', 'US')
            : const Locale('KH', 'KH'),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'light_mode'.tr,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                CupertinoSwitch(
                  value: themeModeController.isDark,
                  onChanged: themeModeController.changeTheme,
                ),
                Text(
                  'dark_mode'.tr,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'English',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                GetBuilder<TraslateLanguege>(
                    init: traslateLanguege,
                    builder: (context) {
                      return CupertinoSwitch(
                        value: traslateLanguege.english.value,
                        onChanged: (value) async {
                          var localeEng = const Locale('en', 'US');
                          var localeKh = const Locale('KH', 'KH');
                          traslateLanguege.switchLanguege(value.obs);
                          Get.updateLocale(
                              value == false ? localeEng : localeKh);
                        },
                      );
                    }),
                Text(
                  'ខ្មែរ',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
