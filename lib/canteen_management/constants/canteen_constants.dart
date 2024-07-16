String categoryList = 'api/Fooditeamfacade/loaddata/';
String foodList = 'api/Foodtransactionfacade/FoodItem/';
String imageList = 'api/Fooditeamfacade/Getimagedata';
String generatePin = 'api/Fooditeamfacade/Createpin';
String forgotPin = 'api/Fooditeamfacade/Forgotpin';
// String deductAmount = 'api/Foodtransactionfacade/savedata';
String transactionHistory = 'api/Foodtransactionfacade/paymenthistory';
String cardReader = 'api/Foodtransactionfacade/getstudent/';

List menuItems = [
  {
    "image": "assets/canteen_images/butter_milk.jpg",
    "name": "Butter Milk",
    "amount": 20.0,
    "status": "veg",
    "count": 0,
    "isSelect": false,
  },
  {
    "image": "assets/canteen_images/curd.jpg",
    "name": "Curd",
    "amount": 20.0,
    "status": "veg",
    "count": 0,
    "isSelect": false,
  },
  {
    "image": "assets/canteen_images/dal_curry.jpg",
    "name": "Dal",
    "amount": 30.0,
    "status": "veg",
    "count": 0,
    "isSelect": false,
  },
  {
    "image": "assets/canteen_images/green_salad.jpg",
    "name": "Green Salad",
    "amount": 25.0,
    "status": "veg",
    "count": 0,
    "isSelect": false,
  },
  {
    "image": "assets/canteen_images/non_veg_thali.jpg",
    "name": "Non-veg Thali",
    "amount": 180.0,
    "status": "Non-veg",
    "count": 0,
    "isSelect": false,
  },
  {
    "image": "assets/canteen_images/paneer_curry.jpg",
    "name": "Paneer Butter Masala",
    "amount": 80.0,
    "status": "veg",
    "count": 0,
    "isSelect": false,
  },
  {
    "image": "assets/canteen_images/veg_north_thali.jpg",
    "name": "North Thali",
    "amount": 130.0,
    "status": "veg",
    "count": 0,
    "isSelect": false,
  },
  {
    "image": "assets/canteen_images/veg_thali.jpg",
    "name": "Veg Meal",
    "amount": 120.0,
    "status": "veg",
    "count": 0,
    "isSelect": false,
  },
];
List paymentMode = [
  {
    "id": "1",
    "name": "PDA",
    "image": 'assets/images/assets/images/wallet_pda.png'
  },
  {
    "id": "2",
    "name": "Google Pay",
    "image": 'assets/images/assets/images/Google__G__logo.svg.png'
  },
  {
    "id": "3",
    "name": "Phone Pay",
    "image": 'assets/images/assets/images/phone_pay.jpg'
  }
];

List newPaymentMode = [
  {
    "id": "1",
    "name": "PDA",
  },
  {
    "id": "2",
    "name": "Wallet",
  },
];
List newPaymentMode2 = [
  {
    "id": "1",
    "name": "PDA",
  },
  {
    "id": "2",
    "name": "Cash",
  },
  {
    "id": "3",
    "name": "Scan To Pay",
  },
];
List dashboardData = [
  {"name": "Total Orders", "amount": "100"},
  {"name": "Total Amount", "amount": "1000"},
  {"name": "Today Orders", "amount": "200"},
  {
    "name": "Today Amount Collected",
    "amount": "2000",
  },
];
List currentDayData = [
  {"name": "Rice Sambar", "qty": "5", "amount": "250"},
  {"name": "Biryani", "qty": "5", "amount": "600"},
  {"name": "Veg Fried Rice", "qty": "5", "amount": "500"},
];
List drawerList = [
  {"name": "Booking History", "image": "assets/images/Classwork.png"},
  {"name": "Wide Bill", "image": "assets/images/FeeReceipt.png"},
  {"name": "Report", "image": "assets/images/Attendance.png"},
  {"name": "Quick Search", "image": "assets/images/Attendance.png"},
  {"name":"Master Category","image":"assets/images/ClassTeacher.png"},
  {"name":"Food Item Master","image":"assets/images/canteen_image.png"},
  // {"name":"Master Counter","image":"assets/images/ClassTeacher.png"},
];
