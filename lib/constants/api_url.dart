class URLS{
  static String miId = "mi_id";
  static String userId = "user_Id";
  static String asmayId = "asmaY_Id";
  static String ivrmrtId = "ivrmrt_Id";
  static String amstId = "amst_id";
  static String ivrmrtRole = "ivrmrt_role";
  static String hrmeId = "hrme_Id";
  static String base = "http://43.205.143.174/";
  static String institutionCodeBaseUrl = "https://bdcampus.azurewebsites.net/";
  static String getApiUrl = "api/LoginFacade/getinstitutionapiNew/";
  static String login = "api/LoginFacade";
  static String categoryList = 'api/Fooditeamfacade/loaddata/';
  static String foodList = 'api/Foodtransactionfacade/FoodItem/';
  static String imageList = 'api/Fooditeamfacade/Getimagedata';
  static String generatePin = 'api/Fooditeamfacade/Createpin';
  static String forgotPin = 'api/Fooditeamfacade/Forgotpin';
  static String deductAmountAPI = 'api/Foodtransactionfacade/savedata';
  static String transactionPaymentHistory =
      'api/Foodtransactionfacade/paymenthistory';
  static String transationHistory = 'api/Foodtransactionfacade/loaddata';
  static String cardReader = 'api/Foodtransactionfacade/getstudent/';
  static String cancelTransaction = 'api/Foodtransactionfacade/trns_cancel/';
  static String adminDashboard = 'api/Foodtransactionfacade/orderdeatils/';
  static String dayWiseGraph = 'api/Foodtransactionfacade/Month_Daywise_graph';
  static String monthWiseGraph ='api/Foodtransactionfacade/YearWise_graph';
  static String report='api/Foodtransactionfacade/foodreport';
  static String quickSearch ='api/Foodtransactionfacade/paymenthistory_print';
  static String printOnce = 'api/Foodtransactionfacade/paymenthistory_print_onetime';
  static String refundAmount = 'api/Foodtransactionfacade/VoidAmount/';
  //
  static String addCategory = 'api/FoodMasterCategoryFacade/savedata/';
  static String addedCategoryList = 'api/FoodMasterCategoryFacade/loaddata/';
  static String deActiveAPII = 'api/FoodMasterCategoryFacade/deactivate/';
  static String addCanteen = 'api/FoodMasterCategoryFacade/savedatacounter/';
  static String activateCounter ='api/FoodMasterCategoryFacade/deactivateCounter/';
  static String addFood = 'api/Fooditeamfacade/savedata/';
  static String loadFoodList = 'api/Fooditeamfacade/loaddata';
  static String activeFood ='api/Fooditeamfacade/deactivate/';
  static String counterWiseFoodList ='api/Fooditeamfacade/chnageofcounter/';
  // Change password
  static String verifyUser = "api/LoginFacade/VerifyUserName";
  static String sendOtp = "api/LoginFacade/Mobileappotp";
  static String changePassword = "api/LoginFacade/forgotpassword";
  static String resetPassword = "api/changepwdFacade";
  static String expiredPwd = "api/changepwdFacade/";
  static String emailOtp = "api/LoginFacade/getOTPForEmail";
  //
  static String uploadHomeWorkEnd = "api/LoginFacade/HomeworkUpload";
}