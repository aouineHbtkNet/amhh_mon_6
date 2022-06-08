import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simo_v_7_0_1/apis/user_get_orders.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_users.dart';
import 'order_details_screen.dart';

class UserOrdersScreen extends StatefulWidget {
  static const String id = '/UserOrderScreen';
  @override
  State<UserOrdersScreen> createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {

  Widget detailedPayedOnLine(List<String > list){
    return Column(
      children: [
        Container(width:double.infinity, child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Manera de pago :' ,style: TextStyle(fontSize: 20),),
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // color: Colors.amberAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [

                  Text(list[0].toString() ,style: TextStyle(fontSize: 20),),
                  Text(list[1].toString() ,style: TextStyle(fontSize: 20),),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text('N.de operacion :' ,style: TextStyle(fontSize: 20),),
                        Text(' ${list[2]}' ,style: TextStyle(fontSize: 28,color: Colors.blue),),
                      ],
                    ),
                  ),

                ],),
            ),
          ),
        )


      ],
    );

  }




  List ordersList = [];
bool isLoading=false;
  getOrderList() async{
   setState(() {isLoading=true;});
    ordersList= await  GetOrdersUser().getOrdersUser();
   setState(() {isLoading=false;});
  }
  @override
  void initState() {
    getOrderList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(


        body: SafeArea(

              child: Column(

                children: [
                   PopUpMenuWidgetUsers(putArrow: true,showcart: false,
                    callbackArrow: (){Navigator.of(context).pop();},
                      voidCallbackCart: (){}),
                       ordersList.isEmpty && isLoading==true
                      ?SpinKitWave(color: Colors.green, size: 50.0,)
                      :ordersList.isEmpty && isLoading==false? Text('No hay pedidos',style: TextStyle(fontSize: 20,color: Colors.blueGrey),)
                      : Expanded(// A la linea
                         child: ListView.builder(
                          itemCount: ordersList.length,
                          itemBuilder: (BuildContext context, int index) {
                            String paymentMethodAsString= ordersList[index]['manera_pago'].toString();
                            List<String> paymentMethodasList =paymentMethodAsString.split(',');

                             DateTime orderTime = DateTime.parse(ordersList[index]['created_at']);
                            int year =  orderTime.year;
                            int month = orderTime.month;
                            int day =  orderTime.day;
                            int hour =  orderTime.hour;
                            int min =  orderTime.minute;
                            int sec =  orderTime.second;



                          return Padding(padding: const EdgeInsets.all(8.0), child: Card(child:
                          Column(
                            children: [

                             SizedBox(height: 10,),





                              Padding(padding: const EdgeInsets.all(8.0), child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Text('Fecha :' ,style: TextStyle(fontSize: 20),),
                                Text('${DateTime.parse(ordersList[index]['created_at'])}',



                                  // '${year}-${month}-${day} ${hour}: ${min}: ${sec} ',

                                  style: TextStyle(fontSize: 18,color: Colors.blueGrey),),],),),

                              Divider(thickness: 4,),










                              Padding(padding: const EdgeInsets.all(8.0),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      Text('Id :' ,style: TextStyle(fontSize: 20),),
                                        Text(ordersList[index]['id'].toString() ,style: TextStyle(fontSize: 20),),],),),
                                   Padding(padding: const EdgeInsets.all(8.0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Text('Serial :' ,style: TextStyle(fontSize: 20),),
                                        Text(ordersList[index]['trucking_number'].toString() ,style: TextStyle(fontSize: 20),),],)),
                                     Padding(padding: const EdgeInsets.all(8.0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Text('Manera de Entrega :' ,style: TextStyle(fontSize: 20),),



                                          ordersList[index]['manera_entrega']==null?Text(''): Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(ordersList[index]['manera_entrega'].toString() ,style: TextStyle(fontSize: 20),),
                                          ),],),),




                                  paymentMethodasList.length==3? detailedPayedOnLine(paymentMethodasList)
                                      :
                                  Padding(padding: const EdgeInsets.all(8.0),child:
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Text('Manera de pago:' ,style: TextStyle(fontSize: 20 ),),
                                    ordersList[index]['manera_pago']==null?Text(''): Text(ordersList[index]['manera_pago'] ,
                                      style: TextStyle(fontSize: 20,
                                          ),),],),),








                            Padding(padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [


                                      paymentMethodasList.length==3?
                                      Text('Total pagado :  ' ,style: TextStyle(fontSize: 20),):
                                      Text('Total a pagar : ' ,style: TextStyle(fontSize: 20),),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                             //color: Colors.amberAccent,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('${ordersList[index]['grand_total']} \$' ,style: TextStyle(fontSize: 28),),
                                                )),
                                          ),],),
                              ),),




                                  Padding(padding: const EdgeInsets.all(8.0),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

                                        Text('Status:' ,style: TextStyle(fontSize: 20 ),),
                                        ordersList[index]['status']==null?Text(''): Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(ordersList[index]['status'] ,
                                            style: TextStyle(fontSize: 20,
                                                fontFamily: 'OpenLight'),),
                                        ),],),),




                            Padding(padding: const EdgeInsets.all(8.0),
                              child: InkWell(onTap: (){
                                Navigator.push(context,
                                  MaterialPageRoute(builder:
                                      (context)=>UserOrdersDetailsScreen (
                                       selectedOrder:ordersList[index],
                                 ),
                                  ),
                                );
                              },

                                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                    Text('Ver Detailles',style: TextStyle(color:Colors.green,
                                        fontSize: 20,fontFamily: 'OpenDark'),), SizedBox(width: 10,),
                                        Icon(Icons.more_horiz_outlined,size: 20,color:Colors.green)],),),)

                          ],),),);}),),

                ],
              ),
            ));}
}
