import 'package:open_loyalty/Firebase/respository.dart';
import 'package:open_loyalty/models/coupons_model.dart';
import 'package:rxdart/rxdart.dart';

class CouponBloc {
  final _repository = Repository();
  final _customerCouponFetcher = PublishSubject<ListCouponModel>();

  Stream<ListCouponModel> get customerCoupon => _customerCouponFetcher.stream;

  buyCoupon(String couponId, String costInPoints) async {
    print("fetch status");
    _repository.buyCoupon(couponId,costInPoints);
  }

  Future<bool> checkCoupon(String couponID) async {
    return _repository.checkVoucher(couponID);
  }

  fetchCustomerCoupon() async {
    if (!_customerCouponFetcher.isClosed) {
      print("fetch cus coupon bought");
      ListCouponModel? couponModel = await _repository.fetchCustomerCoupon();
      print(couponModel?.total);
      _customerCouponFetcher.sink.add(couponModel!);
    }
  }

  dispose() {
    _customerCouponFetcher.close();
  }
}
