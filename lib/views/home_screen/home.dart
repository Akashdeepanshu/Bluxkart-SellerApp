import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controllers/Home_controller.dart';
import '../../constants/consts.dart';
import '../Products_Screen/Products_screen.dart';
import '../common/bg_widget.dart';
import '../order_screen/order_screen.dart';
import '../setting_screen/setting_screen.dart';
import 'HomeScreen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());

    var navScreens = [
      Homescreen(),
      ProductsScreen(),
      orderScreen(),
      SettingScreen()
    ];


    
    var bottomNavbar = [
      BottomNavigationBarItem(icon: Icon(Icons.dashboard),label: dashboard),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: products),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_bag),label: order),
      BottomNavigationBarItem(icon: Icon(Icons.settings),label: settings),
    ];
    
    
    return bgWidget(
      child: Scaffold(
        bottomNavigationBar: Obx( ()=> BottomNavigationBar(
            onTap: (index){
              controller.navIndex.value = index;
            },
            currentIndex: controller.navIndex.value,
              selectedItemColor: Colors.purple,
              unselectedItemColor: Colors.black ,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              items: bottomNavbar),
        ),
        backgroundColor: Colors.transparent,
        body: Obx(
            ()=> Column(
            children: [
              Expanded(child: navScreens.elementAt((controller.navIndex.value)))
            ],
          ),
        ),
      )

    );
  }
}
