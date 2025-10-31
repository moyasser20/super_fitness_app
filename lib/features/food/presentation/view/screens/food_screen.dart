import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/utils/styles.dart';
import '../../../../../core/contants/app_images.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> categories = [
    "Breakfast",
    "Lunch",
    "Dinner",
    "Snacks",
  ];

  final Map<String, List<Map<String, String>>> foodsByCategory = {
    "Breakfast": [
      {"name": "Oatmeal Bowl", "image": "assets/images/test_food.png"},
      {"name": "Avocado Toast", "image": "assets/images/test_food.png"},
    ],
    "Lunch": [
      {"name": "Grilled Chicken Salad", "image": "assets/images/test_food.png"},
      {"name": "Tuna Pasta", "image": "assets/images/test_food.png"},
    ],
    "Dinner": [
      {"name": "Salmon with Veggies", "image": "assets/images/test_food.png"},
      {"name": "Beef Steak", "image": "assets/images/test_food.png"},
    ],
    "Snacks": [
      {"name": "Protein Bar", "image": "assets/images/test_food.png"},
      {"name": "Fruit Smoothie", "image": "assets/images/test_food.png"},
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Image.asset(
              "assets/icons/back_fitness_icon.png",
              width: 28,
              height: 28,
              color: Colors.white,
            ),
          ),
          title: Text(
            'Food Recommendation',
            style: balooThambi2BoldExtraLarge.copyWith(fontSize: 24),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: SizedBox(
                height: 45,
                child: TabBar(
                  controller: _tabController,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  tabAlignment: TabAlignment.start,
                  physics: const BouncingScrollPhysics(),
                  indicatorSize: TabBarIndicatorSize.tab,
                  isScrollable: true,
                  indicator: BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.circular(25.0),
                    shape: BoxShape.rectangle,
                  ),
                  dividerColor: Colors.transparent,
                  labelColor: AppColors.white,
                  unselectedLabelColor: AppColors.white.withOpacity(0.7),
                  labelStyle: balooThambi2Bold,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  tabs: categories.map((category) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6.0),
                      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Tab(text: category),
                    );
                  }).toList(),
                ),

              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.homeBc),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            TabBarView(
              controller: _tabController,
              physics: const BouncingScrollPhysics(),
              children: categories.map((category) {
                final foods = foodsByCategory[category] ?? [];
                return _buildFoodGrid(foods);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodGrid(List<Map<String, String>> foods) {
    if (foods.isEmpty) {
      return Center(
        child: Text(
          'No foods available in this category.',
          style: balooThambi2MediumLarge,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0,
        ),
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.4),
                      BlendMode.colorBurn,
                    ),
                    image: AssetImage(food["image"] ?? "assets/images/test_food.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    food["name"] ?? "Unnamed Food",
                    textAlign: TextAlign.center,
                    style: balooThambi2BoldExtraLarge,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
