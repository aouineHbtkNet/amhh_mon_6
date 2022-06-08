import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simo_v_7_0_1/apis/logout_user_api.dart';
import 'package:simo_v_7_0_1/providers/shopping_cart_provider.dart';
import 'package:simo_v_7_0_1/screens/user-cataloge.dart';
import 'package:simo_v_7_0_1/screens/user_orders_screen.dart';
import 'package:simo_v_7_0_1/screens/user_profile_screen.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_users.dart';
import 'package:simo_v_7_0_1/widgets_utilities/user_app_bar.dart';


class UserCart extends StatefulWidget {
  const UserCart({Key? key}) : super(key: key);
  static const String id = '/ usercart';
  @override
  _UserCartState createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {

  bool startLogingOut =false;

  @override
  Widget build(BuildContext context) {

    var mapOfproducts = context.watch<ShoppingCartProvider>().collectionMap;



    return Scaffold(

      body: SafeArea(


        child: mapOfproducts.isEmpty?

        UsedWidgets().emptyCart( context)

            :Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () async {
                     Navigator.of(context).pop();
                  },
                    icon: Icon(Icons.arrow_back,),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all( color: Colors.blueGrey,width: 2)
                        ),
                        child: GestureDetector(
                          onTap: (){Navigator.of(context).pushNamed(UserCart.id);},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart_outlined,size: 28,color: Colors.green,),
                              SizedBox(width: 6,),
                              Text(
                                '${context.watch<ShoppingCartProvider>().inCartItemsCount}',
                                style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),

                            ],),
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            ),












            Expanded(
              child: ListView.builder(
                  itemCount: mapOfproducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return cartproductCard(



                      product: mapOfproducts.keys.toList()[index],
                      quantity: mapOfproducts.values.toList()[index],
                      index: index,
                    );
                  }),
            ),
                  UsedWidgets().placeOrderwidget(context),
                  CartTotals()



          ],
        ),
      ),
    );
  }
}
