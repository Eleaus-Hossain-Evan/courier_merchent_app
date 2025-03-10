// ignore_for_file: constant_identifier_names

class APIRoute {
  static const String DUMMY_PERSON = 'https://i.pravatar.cc/300';
  static const String WEB_URL = "";

  // static const String BASE_URL = "https://api.courier.b2gsoft.xyz/";
  static const String BASE_URL = "https://server.greenmaxcourier.com/";
  // static const String BASE_URL_LOCAL = "http://192.168.68.118:3697/";
  static const String API_V1 = "api/v1/";

  //#<<---------------- AUTH ------------------>>
  static const String SIGN_UP = "${API_V1}merchant/signup";
  static const String VERIFY_SIGN_UP = "${API_V1}merchant/verify-signup";
  static const String LOGIN = "${API_V1}merchant/login";
  static const String PROFILE_VIEW =
      "${API_V1}merchant/single-fetch-by-himself";
  static const String PASSWORD_UPDATE =
      "${API_V1}merchant/password-update-by-himself";

  //#<<---------------- Courier Merchant ------------------>>

  static const String HOME = "${API_V1}setting/home";
  static const String DASHBOARD = "${API_V1}merchant/dashboard";

  //#<<---------------- SHOP ------------------>>
  static const String ADD_SHOP = "${API_V1}merchant/add-shop-by-himself";
  static const String FETCH_ALL_SHOP =
      "${API_V1}merchant/fetch-all-shop-by-himself";
  static const String UPDATE_SHOP = "${API_V1}merchant/update-shop-by-himself/";
  static const String DELETE_SHOP = "${API_V1}merchant/delete-shop-by-himself/";

  //#<<----------------Profile------------------>>
  static const String ALL_DISTRICT = "${API_V1}location/all-districts";
  static const String ALL_AREA_BY_DISTRICT =
      "${API_V1}location/district-areas/";
  static const String IMAGE_UPLOAD =
      "${API_V1}merchant/image-update-by-himself";
  static const String PROFILE_UPDATE = "${API_V1}merchant/profile/update";
  static const String PAYMENT_UPDATE = "${API_V1}merchant/payment/update";
  static const String BANK_ALL = "${API_V1}bank/fetch-all";
  static const String CHECK_OTP = "${API_V1}merchant/confirm-payment-otp";
  static const String FORGOT_PASSWORD_GET_OTP =
      "${API_V1}merchant/forget-password";
  static const String FORGOT_PASSWORD_VERIFY_OTP =
      "${API_V1}merchant/verify-reset-otp";
  static const String RESET_PASSWORD = "${API_V1}merchant/reset-password";

  //#<<----------------Parcel------------------>>
  static const WEIGHT_CHARGE = "${API_V1}weight-charge/fetch-all";
  static const PARCEL_CATEGORY = "${API_V1}category/fetch-all";
  static const PARCEL_CREATE = "${API_V1}parcel/create-by-merchant";
  static const PARCEL_UPDATE = "${API_V1}parcel/update-by-merchant/";
  static const FETCH_ALL_PARCEL =
      "${API_V1}parcel/fetch-all-parcel-by-merchant?";
  static const SINGLE_PARCEL = "${API_V1}parcel/fetch-single/";
  static const CREATE_BULK_PARCEL = "${API_V1}parcel/merchant/bulk";

  //#<<----------------Payment------------------>>
  static const PENDING_PAYMENT_LIST =
      "${API_V1}account/merchant/pending-payment?";
  static const HISTORY_PAYMENT_LIST =
      "${API_V1}account/merchant/sending-merchant-payment-history?";
  static const SINGLE_HISTORY_PAYMENT =
      "${API_V1}account/merchant/view/sending-merchant-payment-history/";

  static const ORDER_CREATE = "";

  static const SUBMIT_REVIEW = "";
}
