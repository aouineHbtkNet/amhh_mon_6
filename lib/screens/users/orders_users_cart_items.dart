import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simo_v_7_0_1/apis/admins/get_orders_list_of_products.dart';
import 'package:simo_v_7_0_1/modals/items_in_cart_for_admin.dart';
import 'package:simo_v_7_0_1/modals/orders_model_for_admin.dart';
import 'package:simo_v_7_0_1/screens/admins/cart_response_list.dart';



class OrderDetailsForUsers extends StatefulWidget {
  static const String id = '/OrderDetailsForUsers';
  OrderModel orderModel;
  OrderDetailsForUsers({required this.orderModel});

  @override
  State<OrderDetailsForUsers> createState() => _OrderDetailsForUsersState();}
class _OrderDetailsForUsersState extends State<OrderDetailsForUsers> {

  Widget showOrderAttrbutes({ String? title, String? data}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [Text(title ??'',style: TextStyle(fontSize: 20,color: Colors.blueGrey),),
          SizedBox(width: 4.0,),
          Text(' : ${data ??''}',style: TextStyle(fontSize: 20),),

        ],),
      ),
    );}

  bool isLoading =false;
  OrderModel orderModel = OrderModel();

  CartResponse cartResponse =CartResponse();

  @override
  void initState() {
    setState(() {isLoading=true;});
    orderModel = widget.orderModel;
    GetOrderListOfProducts().getOrderItemsUsers(widget.orderModel.id).then((value) {
      setState(() {cartResponse= value;isLoading=false;});
    });




    print('orderModel id   ===============>${orderModel.id}');
    super.initState();
  }

  //SpinKitWave(color: Colors.green, size: 50.0,):
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Row(children: [IconButton(onPressed: () async {Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back,color: Colors.green,),),],),
              Divider(thickness: 2,),

              Center(
                child: Card(
                  child:
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${DateTime.parse('${orderModel.created_at}').toLocal().year}-'
                            '${DateTime.parse('${orderModel.created_at}').toLocal().month}-'
                            '${DateTime.parse('${orderModel.created_at}').toLocal().day} '
                            '${DateTime.parse('${orderModel.created_at}').toLocal().hour}:'
                            '${DateTime.parse('${orderModel.created_at}').toLocal().minute}:'
                            '${DateTime.parse('${orderModel.created_at}').toLocal().second}',
                        style: TextStyle(fontSize: 20,backgroundColor: Colors.grey,color: Colors.white),),
                    ),
                    showOrderAttrbutes(title: 'No.', data:'${orderModel.id}',),
                    showOrderAttrbutes(title: 'Estado', data:'${orderModel.status}'),
                    showOrderAttrbutes(title: 'Manera de pago', data:'${orderModel.manera_pago}'),
                    showOrderAttrbutes(title: 'Manera de entrega', data:'${orderModel.manera_entrega}'),
                    showOrderAttrbutes(title: 'Total a pagar', data:'${orderModel.grand_total}'),
                    showOrderAttrbutes(title: 'Dirección', data:'${orderModel.getUser?.user?.address}'),
                    showOrderAttrbutes(title: ' Cliente', data:'${orderModel.getUser?.user?.name}'),
                    showOrderAttrbutes(title: 'Celular', data:'${orderModel.getUser?.user?.mobilePhone}'),
                    orderModel.getUser?.user?.fixedPhone==null?SizedBox(height: 0,):
                    showOrderAttrbutes(title: 'Teléfono', data:'${orderModel.getUser?.user?.fixedPhone}'),
                  ],
                  ),
                ),
              ),

              SizedBox(height: 20,),
              isLoading==true? SpinKitWave(color: Colors.blueGrey, size: 50.0,):
              //  isLoading==true? CircularProgressIndicator(color: Colors.blueGrey,):
              Expanded(

                child: ListView.builder(
                    itemCount:cartResponse.listOfCartItemsInfo.length ,
                    itemBuilder:(context,index){
                      int indexPlusOne =index+1;
                      return Center(
                        child: Card(
                          child: Column(
                            children: [
                              Padding(padding: const EdgeInsets.only(top: 4),
                                child: Text(' ${indexPlusOne} / ${cartResponse.listOfCartItemsInfo.length}', style: TextStyle(fontSize: 20),),),
                              showOrderAttrbutes(title: 'No del producto', data:'${cartResponse.listOfCartItemsInfo[index].product_id}'),

                              Padding(padding: const EdgeInsets.all(14.0),
                                child:  cartResponse.listOfCartItemsInfo[index].product?.foto_producto==null?Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        color: Colors.greenAccent), child: Padding(padding: const EdgeInsets.all(8.0),
                                  child: Text('No  hay foto',style: TextStyle(fontSize: 16),),)):
                                Container(height:200, decoration: BoxDecoration(image: DecorationImage(
                                  image: NetworkImage( 'https://hbtknet.com/storage/notes/${cartResponse.listOfCartItemsInfo[index].product?.foto_producto}'),
                                  fit: BoxFit.cover,),),),),


                              showOrderAttrbutes(title: 'Nombre', data:'${cartResponse.listOfCartItemsInfo[index].product?.nombre_producto}'),
                              showOrderAttrbutes(title: 'Marca', data:'${cartResponse.listOfCartItemsInfo[index].product?.marca}'),
                              showOrderAttrbutes(title: 'Contenido', data:'${cartResponse.listOfCartItemsInfo[index].product?.contenido}'),
                              showOrderAttrbutes(title: 'Precio', data:'${cartResponse.listOfCartItemsInfo[index].product?.precio_ahora}'),
                              cartResponse.listOfCartItemsInfo[index].product?.porciento_de_descuento==null?SizedBox(height: 0.0,):
                              showOrderAttrbutes(title: 'Decuento', data:'${cartResponse.listOfCartItemsInfo[index].product?.porciento_de_descuento} \%'),
                              showOrderAttrbutes(title: 'descripción', data:'${cartResponse.listOfCartItemsInfo[index].product?.descripcion}'),
                              Divider(thickness: 4,)

                            ],
                          ),
                        ),
                      );} ),

              )


            ],),
        ));
  }
}