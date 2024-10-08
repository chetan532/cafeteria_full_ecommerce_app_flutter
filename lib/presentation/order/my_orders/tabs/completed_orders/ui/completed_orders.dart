import 'package:coffeeshopapp/core/configs/size_config.dart';
import 'package:coffeeshopapp/core/configs/theme/app_colors.dart';
import 'package:coffeeshopapp/core/configs/theme/strings.dart';
import 'package:coffeeshopapp/presentation/order/models/orders_model.dart';
import 'package:coffeeshopapp/presentation/order/my_orders/tabs/completed_orders/bloc/completed_orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedOrders extends StatefulWidget {
  const CompletedOrders({super.key});

  @override
  State<CompletedOrders> createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {

  CompletedOrdersBloc completedOrdersBloc = CompletedOrdersBloc();

  @override
  void initState() {
    completedOrdersBloc.add(CompletedOrdersInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompletedOrdersBloc, CompletedOrdersState>(
      bloc: completedOrdersBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case CompletedOrdersLoadingState:
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case CompletedOrdersErrorState:
            return Center(
              child: Text(
                "Error While Loading Data",
                style: TextStyle(color: AppColors.primary),
              ),
            );

          case CompletedOrdersLoadedSuccessState:
            final successState = state as CompletedOrdersLoadedSuccessState;
            return Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  // padding around the grid
                  itemCount: successState.orderData.length,
                  // total number of items
                  itemBuilder: (context, index) {
                    return orderItem(successState.orderData[index]);
                  },
                ));
          default:
            return SizedBox();
        }
      },
    );
  }

  Widget orderItem(OrderData orderData) {
    return Container(
      margin: EdgeInsets.only(
          left: getProportionateScreenWidth(15),
          right: getProportionateScreenWidth(15),
          top: getProportionateScreenWidth(10)),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.clrWhite,
          borderRadius: BorderRadius.all(
              Radius.circular(getProportionateScreenWidth(10))),
          boxShadow: [
            BoxShadow(
                color: AppColors.clrTextFieldColor,
                blurRadius: 2,
                spreadRadius: 2)
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: getProportionateScreenWidth(120),
                height: getProportionateScreenWidth(120),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            orderData.items!.first.image.toString())),
                    borderRadius: BorderRadius.circular(15)),
              ),
              SizedBox(
                width: getProportionateScreenWidth(10),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(10),
                            right: getProportionateScreenWidth(10)),
                        decoration: BoxDecoration(
                            color: AppColors.clrTextFieldColor,
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          orderData.type == 0 ? "Pick Up" : "Delivery",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      Text(
                        orderData.items!.map((e) => e.name).toList().join(","),
                        maxLines: 1,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: getProportionateScreenWidth(16),
                            color: AppColors.clrBlack,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      Text(
                        orderData.name.toString(),
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            color: AppColors.clrGrey,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.clrYellow,
                        size: getProportionateScreenWidth(15),
                      ),
                      Text(
                        orderData.ratings.toString(),
                        style: TextStyle(
                            color: AppColors.clrBlack,
                            fontSize: getProportionateScreenWidth(13),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: getProportionateScreenWidth(10),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    // addDeliveryReviewBloc.add(
                    //     AddDeliveryReviewCancelNavigationEvent());
                  },
                  child: Container(
                    width: SizeConfig.screenWidth * 0.42,
                    padding: EdgeInsets.only(
                        top: getProportionateScreenHeight(10),
                        bottom: getProportionateScreenHeight(10)),
                    decoration: BoxDecoration(
                        color: AppColors.clrTextFieldColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      Strings.reOrder,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: getProportionateScreenWidth(15)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // addDeliveryReviewBloc.add(
                    //     AddDeliveryReviewSubmitNavigationEvent());
                  },
                  child: Container(
                    width: SizeConfig.screenWidth * 0.42,
                    padding: EdgeInsets.only(
                        top: getProportionateScreenHeight(10),
                        bottom: getProportionateScreenHeight(10)),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      Strings.eReceipt,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.clrWhite,
                          fontWeight: FontWeight.w500,
                          fontSize: getProportionateScreenWidth(15)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
        ],
      ),
    );
  }

}
