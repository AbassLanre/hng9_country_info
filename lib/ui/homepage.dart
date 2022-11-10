import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng9_country_info/config.dart';
import 'package:hng9_country_info/constants/consts.dart';
import 'package:hng9_country_info/model/country_model.dart';
import 'package:hng9_country_info/network/network_enum.dart';
import 'package:hng9_country_info/network/network_helper.dart';
import 'package:hng9_country_info/network/network_service.dart';
import 'package:hng9_country_info/network/query_param.dart';
import 'package:hng9_country_info/widgets/searchbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
bool darkMode = true;

class _HomePageState extends State<HomePage> {
  final Country? country = Country();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 24.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Explore',style: TextStyle(fontSize: 24.sp),),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            darkMode = !darkMode;
                            currentTheme.switchTheme();
                          });
                        },
                        child: !darkMode?const Icon(Icons.light_mode_outlined):
                        const Icon(Icons.dark_mode_outlined))

                  ],
                ),
                SizedBox(height: 16.h,),
                const SearchBar(),
                SizedBox(height: 16.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Language
                    Container(
                    height: 40.h,
                    width: 73.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: const Color(0xffA9B8D4) )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 5.w ,),
                        Icon(Icons.language_rounded,size: 18.r,),
                        Text('EN',style: TextStyle(fontSize: 12.sp),),
                        SizedBox(width: 5.w ,),
                      ],
                    ),
                  ),
                    /// filter
                    Container(
                      height: 40.h,
                      width: 86.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: const Color(0xffA9B8D4) )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 5.w ,),
                          Icon(Icons.filter_alt_outlined,size: 19.r,),
                          Text('Filter',style: TextStyle(fontSize: 12.sp),),
                          SizedBox(width: 5.w ,),
                        ],
                      ),
                    ),
                ],),
                SizedBox(height: 16.h,),
                FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                      // final json = snapshot.data;

                      final List<Country> country = snapshot.data as List<Country>;

                      print('here '+ country[245].name!.common.toString());
                      // return ListView.builder(
                      //   itemBuilder: (context, index){
                      //     return Semantics(
                      //         label: 'Article widget Title ${articles[index].title}',
                      //         child: ArticleWidget(article: articles[index]));
                      //   },
                      //   itemCount: articles.length,
                      // );
                    }else if(snapshot.hasError){
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 25,
                            ),
                            SizedBox(height: 10,),
                            Text('Something Went Wrong')
                          ],
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator(),);
                  },
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<List<Country>?> getData() async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.get,
        url: StaticValues.apiUrl,
        queryParam: null
    );

    debugPrint('Response ${response?.statusCode}');

    return await NetworkHelper.filterResponse(
        callBack: _listOfArticlesFromJson,
        response: response,
        parameterName: CallBackParameterName.all,
        onFailureCallBackWithMessage: (errorType, msg){
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        }
    );
  }
  List<Country> _listOfArticlesFromJson(json) => (json as List)
      .map((e) => Country.fromJson(e as Map<String, dynamic>))
      .toList();

}
