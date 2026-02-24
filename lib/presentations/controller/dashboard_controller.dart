import 'package:get/get.dart';
import 'package:pos/data/model/chart_data.dart';

class DashboardController extends GetxController {
  List<ChartData> productCategory = [
    ChartData('Grocery Staples', 5.9),
    ChartData('Fresh Products', 3.9),
    ChartData('Dairy & Eggs', 2.9),
    ChartData('Bevarages', 3.9),
    ChartData('Stack & Confectionary', 3.9),
    ChartData('Personal Care', 3.9),
    ChartData('Household Cleaning', 3.9),
    ChartData('Baby Care', 5.4),
    ChartData('Beauty & Cosmetics', 3.6),
    ChartData('Health & Wellness', 4),
    ChartData('Home & Kitchen', 3.6),
    ChartData('Electronics & Gadgets', 2),
    ChartData('Stationary & Books', 3),
    ChartData('Bekary & Breads', 6),
    ChartData('Frozen Foods', 4),
    ChartData('Meat & Seafoods', 4),
    ChartData('Pet Care', 2),
    ChartData('Automative Essentials', 2),
    ChartData('Gardening & Outdoor', 3),
  ];
  List<ChartData> supplierContribute = [
    ChartData('Elite Electronics Hub', 9.4),
    ChartData('Fresh Farm Foods', 13.4),
    ChartData('Milkway Dairy', 11.1),
    ChartData('Crunchy Bite Snacks', 7.5),
    ChartData('Sparkle Household Supplies', 8.4),
    ChartData('PlayJoy Toys', 11.1),
    ChartData('Hervest Delight Products', 9.4),
    ChartData('Urban kitchenware', 10.5),
    ChartData('Bluewave Bevarages', 7.7),
  ];
}
