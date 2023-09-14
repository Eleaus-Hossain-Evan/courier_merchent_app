import 'package:courier_merchent_app/domain/payment/pending_payment_response.dart';
import 'package:courier_merchent_app/utils/utils.dart';

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
}
