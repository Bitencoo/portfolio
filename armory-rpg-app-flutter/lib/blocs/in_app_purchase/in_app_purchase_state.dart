part of 'in_app_purchase_bloc.dart';

abstract class InAppPurchaseState extends Equatable {
  const InAppPurchaseState();
  
  @override
  List<Object> get props => [];
}

class InAppPurchaseInitial extends InAppPurchaseState {}
