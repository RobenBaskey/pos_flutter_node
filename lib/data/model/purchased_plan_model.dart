import 'package:pos/data/model/feature_plan_model.dart';
import 'package:pos/data/model/user_model.dart';

class PurchasedPlanModel {
    final String? id;
    final int? days;
    final int? price;
    final Payment? payment;
    final DateTime? purchaseDate;
    final DateTime? expiryDate;
    final String? status;
    final UserModel? user;
    final FeaturePlanModel? plan;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    PurchasedPlanModel({
        this.id,
        this.days,
        this.price,
        this.payment,
        this.purchaseDate,
        this.expiryDate,
        this.status,
        this.user,
        this.plan,
        this.createdAt,
        this.updatedAt,
    });

    PurchasedPlanModel copyWith({
        String? id,
        int? days,
        int? price,
        Payment? payment,
        DateTime? purchaseDate,
        DateTime? expiryDate,
        String? status,
        UserModel? user,
        FeaturePlanModel? plan,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        PurchasedPlanModel(
            id: id ?? this.id,
            days: days ?? this.days,
            price: price ?? this.price,
            payment: payment ?? this.payment,
            purchaseDate: purchaseDate ?? this.purchaseDate,
            expiryDate: expiryDate ?? this.expiryDate,
            status: status ?? this.status,
            user: user ?? this.user,
            plan: plan ?? this.plan,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory PurchasedPlanModel.fromJson(Map<String, dynamic> json) => PurchasedPlanModel(
        id: json["_id"],
        days: json["days"],
        price: json["price"],
        payment: json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        purchaseDate: json["purchase_date"] == null ? null : DateTime.parse(json["purchase_date"]),
        expiryDate: json["expiry_date"] == null ? null : DateTime.parse(json["expiry_date"]),
        status: json["status"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        plan: json["plan"] == null ? null : FeaturePlanModel.fromJson(json["plan"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );


}


class Payment {
    final String? transactionId;
    final String? paymentMethod;
    final int? amount;
    final String? currency;
    final String? status;

    Payment({
        this.transactionId,
        this.paymentMethod,
        this.amount,
        this.currency,
        this.status,
    });

    Payment copyWith({
        String? transactionId,
        String? paymentMethod,
        int? amount,
        String? currency,
        String? status,
    }) => 
        Payment(
            transactionId: transactionId ?? this.transactionId,
            paymentMethod: paymentMethod ?? this.paymentMethod,
            amount: amount ?? this.amount,
            currency: currency ?? this.currency,
            status: status ?? this.status,
        );

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        transactionId: json["transaction_id"],
        paymentMethod: json["payment_method"],
        amount: json["amount"],
        currency: json["currency"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
        "payment_method": paymentMethod,
        "amount": amount,
        "currency": currency,
        "status": status,
    };
}