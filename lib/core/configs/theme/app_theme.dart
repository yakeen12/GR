import 'package:flutter/material.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';

class AppTheme{

  static final DarkTheme=ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.BlakMode,
    brightness: Brightness.dark,
    fontFamily: 'ClashGrotesk',
  
  elevatedButtonTheme:ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor:AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      )
      ),
    
  )
  );

  
  static final LightTheme=ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: const Color.fromARGB(255, 223, 215, 214),
    brightness: Brightness.light,
    fontFamily: 'ClashGrotesk',
  
  elevatedButtonTheme:ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor:AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      )
      ),
    
  )
  );
}