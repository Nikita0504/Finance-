import 'dart:convert';

class TransactionModel {
  final double sum;
  final String description;
  final bool type;

  TransactionModel(
      {this.type = false, required this.sum, this.description = 'not'});

  TransactionModel.fromJson(Map<String, dynamic> json)
      : sum = json['sum'],
        description = json['description'],
        type = json['type'];

  static Map<String, dynamic> toJson(TransactionModel transactionModel) => {
        'sum': transactionModel.sum,
        'description': transactionModel.description,
        'type': transactionModel.type,
      };

  static String encode(List<TransactionModel> data) => json.encode(
        data
            .map<Map<String, dynamic>>(
                (history) => TransactionModel.toJson(history))
            .toList(),
      );

  static List<TransactionModel> decode(String data) => (json.decode(data)
          as List<dynamic>)
      .map<TransactionModel>((history) => TransactionModel.fromJson(history))
      .toList();
}
