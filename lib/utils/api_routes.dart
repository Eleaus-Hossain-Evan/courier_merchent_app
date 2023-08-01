// ignore_for_file: constant_identifier_names

class APIRoute {
  static const String DUMMY_PERSON = 'https://i.pravatar.cc/300';
  static const String WEB_URL = "";

  static const String BASE_URL = "https://api.courier.b2gsoft.xyz/";
  // static const String BASE_URL = "https://api.senaiyah.com/";
  // static const String BASE_URL_LOCAL = "http://192.168.68.118:3697/";
  static const String API_V1 = "api/v1/";

  static const String SIGN_UP = "${API_V1}merchant/registration";
  static const String LOGIN = "${API_V1}merchant/login";
  static const String PROFILE_VIEW =
      "${API_V1}merchant/single-fetch-by-himself";

  static const String DEVICE_TOKEN = "${API_V1}customer/device-token/set-up";

  //<<---------------- Courier Merchant ------------------>>

  static const String HOME = "${API_V1}home-page/view";

  //'<<----------------Profile------------------>>
  static const String ALL_DISTRICT = "${API_V1}location/all-districts";
  static const String ALL_AREA_BY_DISTRICT =
      "${API_V1}location/district-areas/";
  static const String IMAGE_UPLOAD =
      "${API_V1}merchant/image-update-by-himself";
  static const String PROFILE_UPDATE = "${API_V1}merchant/update-by-himself";

  static const ORDER_CREATE = "";

  static const SUBMIT_REVIEW = "";
}
