import 'package:courier_merchent_app/domain/payment/pending_payment_response.dart';
import 'package:courier_merchent_app/utils/utils.dart';

import '../domain/payment/history_payment_list_response.dart';
import '../domain/payment/single_history_payment_response.dart';

class PaymentRepo {
  final api = NetworkHandler.instance;

  Future<Either<CleanFailure, PendingPaymentResponse>> getPendingPaymentList(
      {int page = 1, int limit = 10}) async {
    final data = await api.get(
      fromData: (json) => PendingPaymentResponse.fromMap(json),
      endPoint: "${APIRoute.PENDING_PAYMENT_LIST}page=$page&limit=$limit",
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, HistoryPaymentListResponse>>
      getHistoryPaymentList({int page = 1, int limit = 10}) async {
    final data = await api.get(
      fromData: (json) => HistoryPaymentListResponse.fromMap(json),
      endPoint: "${APIRoute.HISTORY_PAYMENT_LIST}page=$page&limit=$limit",
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, SingleHistoryPaymentResponse>>
      getSingleHistoryPayment(String id) async {
    final data = await api.get(
      fromData: (json) => SingleHistoryPaymentResponse.fromMap(json),
      endPoint: APIRoute.SINGLE_HISTORY_PAYMENT + id,
      withToken: true,
    );

    return data;
  }
}
