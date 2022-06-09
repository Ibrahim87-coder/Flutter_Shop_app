import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache.helper.dart';

void signOut(context)
{
  CacheHelper.removeData(key:'token').then((value)
  {
    if(value)
      {
        navigateAndFinish(context, ShopLoginScreen());
      }
  });
}

void printFullText(String text)
{
  final pattern = RegExp('1.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)) );
}

String token='';