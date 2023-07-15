import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/components/current_region_item.dart';
import 'package:weather_app/ui/components/favorite_list.dart';
import 'package:weather_app/ui/theme/app_colors.dart';
import 'package:weather_app/ui/theme/app_style.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.iconColor.withOpacity(0),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.iconColor,
          ),
        ),
        title: TextFormField(
          controller: model.searchController,
          cursorColor: AppColors.iconColor.withOpacity(0.5),
          decoration: InputDecoration(
            hintText: 'Введите город/регион',
            hintStyle: AppStyle.fontStyle.copyWith(
              fontSize: 14,
              color: AppColors.iconColor.withOpacity(0.5),
            ),
            fillColor: AppColors.greyColor.withOpacity(0.5),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: 35,
              color: AppColors.iconColor,
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 100, left: 16, right: 16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              model.setBg(),
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: const SearchPageItems(),
      ),
    );
  }
}

class SearchPageItems extends StatelessWidget {
  const SearchPageItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CurrentRegionItem(),
        const SizedBox(height: 24),
        Text(
          'Избранное',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.iconColor,
          ),
        ),
        const SizedBox(height: 16),
        const FavoriteList(),
      ],
    );
  }
}
