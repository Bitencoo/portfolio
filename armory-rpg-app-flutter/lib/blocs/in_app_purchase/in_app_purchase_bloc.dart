import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
part 'in_app_purchase_event.dart';
part 'in_app_purchase_state.dart';

const apiKey = 'goog_YPRbWdDzBBUxuBJHTgnBBeDnBmN';

class InAppPurchaseBloc extends Bloc<InAppPurchaseEvent, InAppPurchaseState> {
  InAppPurchaseBloc() : super(InAppPurchaseInitial()) {
    on<InAppPurchaseLoadEvent>((event, emit) async {
      print("AOBA");
      final products = await Purchases.getProducts(['remove_ads_test'],
          type: PurchaseType.inapp);

      print("Vamo ver:" + products.toString());
      await Purchases.purchaseProduct('remove_ads_test',
          type: PurchaseType.inapp);
    });
  }
}
