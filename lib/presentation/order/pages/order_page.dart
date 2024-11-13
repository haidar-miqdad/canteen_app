import 'package:canteen_app/presentation/home/models/order_item.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../widgets/order_card.dart';
import '../widgets/widgets.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  int calculateTotalPrice(List<OrderItem> orders) {
    return orders.fold(
           0,
          (previousValue, element) =>
      previousValue + element.product.price * element.quantity,
    );
  }

  List<OrderItem> orders = [
    OrderItem(product: Product(name: "Product 1", price: 10000), quantity: 2, ),
    OrderItem(product: Product(name: "Product 2", price: 15000), quantity: 1),
  ];

  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    totalPrice = calculateTotalPrice(
        orders); // Calculate the total price on initialization
  }

  final indexValue = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 10 ),
            child: AppTitle(text: 'Order List',),
          ),
          orders.isEmpty
              ? const Center(
            child: Text('No Data'),
          )
              : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            itemCount: orders.length,
            separatorBuilder: (context, index) => const SpaceHeight(20.0),
            itemBuilder: (context, index) => OrderCard(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              data: orders[index],
              onDeleteTap: () {},
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only( left: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ValueListenableBuilder(
                  valueListenable: indexValue,
                  builder: (context, value, _) => Row(
                    children: [
                      MenuButton(
                        iconPath: Assets.icons.cash.svg(colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn)),
                        label: 'CASH',
                        isActive: value == 1,
                        onPressed: () {
                          indexValue.value = 1;
                        },
                      ),
                      const SpaceWidth(16.0),
                      MenuButton(
                        iconPath: Assets.icons.qrCode.svg(colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn)),
                        label: 'QR',
                        isActive: value == 2,
                        onPressed: () {
                          indexValue.value = 2;
                        },
                      ),
                      const SpaceWidth(16.0),
                      MenuButton(
                        iconPath: Assets.icons.debit.svg(colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn)),
                        label: 'TRANSFER',
                        isActive: value == 3,
                        onPressed: () {
                          indexValue.value = 3;
                        },
                      ),
                    ],
                  ),
                ),
                const SpaceHeight(20.0),
                ProcessButton(
                  price: totalPrice,
                  onPressed: () {
                    if (indexValue.value == 0) {
                      // Show message to select a payment method
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select a payment method.'),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(bottom: 190.0, left: 16.0, right: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      );
                    } else if (indexValue.value == 1) {
                      showDialog(
                        context: context,
                        builder: (context) => PaymentCashDialog(
                          price: totalPrice,
                        ),
                      );
                    } else if (indexValue.value == 2) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => PaymentQrisDialog(
                          price: totalPrice,
                        ),
                      );
                    }
                  },
                  total: 'Rp.25.000',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
