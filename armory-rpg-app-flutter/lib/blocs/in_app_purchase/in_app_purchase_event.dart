part of 'in_app_purchase_bloc.dart';

abstract class InAppPurchaseEvent extends Equatable {
  const InAppPurchaseEvent();

  @override
  List<Object> get props => [];
}

class InAppPurchaseLoadEvent extends InAppPurchaseEvent {}
