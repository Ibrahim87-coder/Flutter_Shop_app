import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache.helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'layout/cubit/cubit.dart';

void main() async {

  // Ensure that all is done
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark') as bool?;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding') as bool?;

  Widget widget;
  token = CacheHelper.getData(key: 'token') as String;

  if(onBoarding != null)
    {
      if(token != null) {
        widget=const ShopLayout();
      } else {
        widget=ShopLoginScreen();
      }
    } else
      {
        widget = OnBoardingScreen();
      }


  BlocOverrides.runZoned(
    () => runApp(MyApp(isDark: isDark,startWidget: widget,)),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  const MyApp({Key? key, required this.isDark, this.startWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode(fromShared: isDark),),
        BlocProvider(create:(BuildContext context) => ShopCubit()..getHomeData())
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: startWidget,
        ),
      ),
    );
  }
}
