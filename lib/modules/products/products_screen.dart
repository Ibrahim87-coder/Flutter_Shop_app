import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../models/home_model.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder: (context,state)
        {
          return ConditionalBuilder(
              condition:ShopCubit.get(context).homeModel != null ,
              builder:(context)=>productsBuilder(ShopCubit.get(context).homeModel),
              fallback: (context)=>Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context,state) {}
    );
  }

  Widget productsBuilder(HomeModel? model)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
    children: [
      CarouselSlider(
        items:model?.data?.banners.map((e)=> Image(
          image:NetworkImage('${e.image}'),
          width: double.infinity,
          fit: BoxFit.cover,
        ) ).toList(),
        options:CarouselOptions(
            height: 250.0,
        initialPage: 0,
        enableInfiniteScroll: true,
        viewportFraction:1.0,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
    autoPlayAnimationDuration: Duration(seconds: 1),
    autoPlayCurve: Curves.fastOutSlowIn,
    scrollDirection: Axis.horizontal
      )),
      SizedBox(height: 10.0,),
      Container(
        child: GridView.count(
          shrinkWrap: true,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
        childAspectRatio: 1/1.53,
        children: List.generate(
          model?.data?.products.length as int,
            (index)=>buildGridProduct(model!.data!.products[index] as ProductModel)
        ),),
      )
    ],
    ),
  );
  Widget buildGridProduct(ProductModel model)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image:NetworkImage(model.image as String),
            width: double.infinity,
            height: 200.0,
          ),
          if(model.discount !=0)  Container(
            color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              'DISCOUNT',
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.white
            ),),
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name as String,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
                height: 1.3,
              )
            ),
            Row(
              children: [
                Text(
                    '${model.price.round()}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: defaultColor
                    )
                ),
                SizedBox(height: 5.0,),
                if(model.discount!=0) Text(
                    '${model.oldPrice.round()}',
                    style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    )
                ),
                Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                    onPressed: (){},
                    icon: Icon(Icons.favorite_border,
                    size: 20.0,)),

              ],
            ),
          ],
        ),
      ),

    ],
    ),
  );

}
