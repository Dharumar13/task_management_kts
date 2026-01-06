import 'package:task_management_kts/app_utility/app_util.dart';
import 'package:task_management_kts/router/router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_utility/app_constant.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/constant.dart';
import '../../../app_utility/fonts.dart';
import '../../../widgets/custom_text.dart';
import '../bloc/layout_list_bloc.dart';
import '../model/layout_list_model.dart';

class AddTaskScreen extends StatefulWidget {
  final String? date;
  final String? siteId;
  const AddTaskScreen(
      {super.key, required this.date, required this.siteId});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  List<String> indexList=["All","Seq Number","Day","Layout Name"];
  List<Datum> modelResult = [];
  @override
  void initState() {
    data();
    AppUtils.getDeviceType();
    super.initState();
  }

  data() async {
    context.read<LayoutListBloc>().add(GetLayoutList(widget.date!, widget.siteId!));
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return BlocConsumer<LayoutListBloc, LayoutListState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(70.0),
                child:AppBar(
                  toolbarHeight: 80,
                  scrolledUnderElevation:0.0,
                  leadingWidth: MediaQuery.of(context).size.width,
                  backgroundColor: ColorResource.colorWhite,
                  leading:Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: ColorResource.color5A5C60,
                          ),
                          iconSize:30,

                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            context.pop();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10.0,bottom: 4.0),
                          child: CustomText(
                            StringResource.addTask,
                            style: GoogleFonts.readexPro(
                                color: ColorResource.color232323,
                                fontSize: AppUtils.getDeviceType()=="tablet"? FontSize1.twentyEight: FontSize1.twentyFour,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),

                ),

              ),
              body:  Container(
              height: double.infinity,
              width: double.infinity,
              color: ColorResource.colorWhite,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0, right: 14.0),
                          child: Row(
                            children: [
                              CustomText(
                                StringResource.selectThe,
                                style: GoogleFonts.inter(
                                  color: ColorResource.color747474,
                                  fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen: FontSize1.thirteen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              CustomText(
                                " ${StringResource.taskName}",
                                style: GoogleFonts.inter(
                                  color: ColorResource.color003867,
                                  fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen: FontSize1.thirteen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                     SizedBox(height:isPortrait==false && AppUtils.getDeviceType()=="phone"?10:80.0),
                        SizedBox(
                          height:50,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:35,
                                  child: Padding(
                                    padding: const EdgeInsets.only( right: 14.0),
                                    child:ListView.builder(
                                      shrinkWrap: true,
                                        itemCount:indexList.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (BuildContext context,int selectedList){
                                      return  Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                        child: GestureDetector(
                                          onTap: (){
                                            //print(context.read<LayoutListBloc>().isDescending!);
                                            if(context.read<LayoutListBloc>().isDescending! == true){
                                              context.read<LayoutListBloc>().add(SelectedIndexEvent(selectedList,  false, "asc", widget.siteId!));
                                            }else{
                                              context.read<LayoutListBloc>().add(SelectedIndexEvent(selectedList,  true, "desc", widget.siteId!));
                                            }
                                          },
                                          child: Container(
                                            height:AppUtils.getDeviceType()=="tablet"?28.0:24.0,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8.0),
                                                color:context.read<LayoutListBloc>().selectedIndex==selectedList?ColorResource.color003867: ColorResource.colorWhite,
                                                border: Border.all(color:context.read<LayoutListBloc>().selectedIndex==selectedList?ColorResource.color003867: ColorResource.colorE0E3E7 , width:1.0)),
                                            child:  Align(
                                              alignment: Alignment.center,
                                              child:Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 11.0,right: 11.0,top: 6.0,bottom: 6.0),
                                                  child: Row(
                                                    children: [
                                                      CustomText(
                                                        indexList[selectedList],
                                                        style: GoogleFonts.inter(
                                                            color:context.read<LayoutListBloc>(). selectedIndex==selectedList?ColorResource.colorWhite: ColorResource.color5A5C60,
                                                            fontSize:AppUtils.getDeviceType()=="tablet"? FontSize1.fifteen:FontSize1.twelve,
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    0==selectedList? const SizedBox(): Row(
                                                      children: [
                                                        if(context.read<LayoutListBloc>().isDescending == true)
                                                        Row(
                                                          children: [
                                                            Icon(Icons.arrow_upward,size:20,color:context.read<LayoutListBloc>().selectedIndex==selectedList?ColorResource.color8AC7FF: ColorResource.color5A5C60,),
                                                            Icon(Icons.arrow_downward,size:20,color:context.read<LayoutListBloc>().selectedIndex==selectedList?ColorResource.colorWhite: ColorResource.colorE0E3E7),
                                                          ],
                                                        ),

                                                        if(context.read<LayoutListBloc>().isDescending == false)
                                                        Row(
                                                          children: [
                                                            Icon(Icons.arrow_upward,size:20,color:context.read<LayoutListBloc>().selectedIndex==selectedList?ColorResource.colorWhite: ColorResource.colorE0E3E7),
                                                            Icon(Icons.arrow_downward,size:20,color:context.read<LayoutListBloc>().selectedIndex==selectedList?ColorResource.color8AC7FF: ColorResource.color5A5C60,),

                                                          ],
                                                        ),

                                                      ],
                                                    )
                                                    ],
                                                  ),
                                                ),
                                              ),

                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                  ),
                                ),
                                Container(
                                  height:45,
                                  width:MediaQuery.of(context).size.width/4,
                                  decoration:  BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                    border: Border.all(width: 1.0,color: ColorResource.colorE0E3E7),

                                  ),
                                  child: TextFormField(
                                     maxLines: 1,
                                    controller: context.read<LayoutListBloc>().searchController,
                                    style: GoogleFonts.inter(
                                      color: ColorResource.color5A5C60,
                                      fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen: FontSize1.thirteen,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    //  autofocus: enable,
                                    //  focusNode: inputNode,
                                    //  controller: context.read<UserListBloc>().searchController,
                                    textInputAction: TextInputAction.done,
                                    onChanged: (searchText) {
                                      context.read<LayoutListBloc>().add(GetLayoutList(widget.date!, widget.siteId!));
                                      //addSearchedFOrItemsToSearchedList(searchText,context.read<LayoutListBloc>().layoutListModel!);


                                    },
                                    decoration: InputDecoration(
                                      labelStyle: GoogleFonts.inter(
                                        color: ColorResource.color5A5C60,
                                        fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen: FontSize1.thirteen,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hintText:StringResource.searchAllLayouts,
                                      hintStyle:  GoogleFonts.inter(
                                        color: ColorResource.color5A5C60,
                                        fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen: FontSize1.thirteen,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(horizontal:10, vertical: 10.0),
                                      suffixIcon: AnimatedOpacity(
                                        duration: const Duration(seconds: 1),
                                        // opacity: _toggle ? 1 : 1,
                                        opacity: 1,
                                        child: IconButton(
                                          icon:  const Icon(Icons.search, size: 20, color: ColorResource.color707070,),
                                          onPressed: () async {
                                            // context.read<UserListBloc>().searchController.clear();
                                            AppUtils.hideKeyBoard(context);
                                          },
                                        ),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height:40.0),
                        if (state is LayoutListLoaded)
                          //context.read<LayoutListBloc>().searchController.text.isEmpty?
                        Expanded(
                          child: ListView.builder(
                            itemCount:context.read<LayoutListBloc>().layoutListModel?.data?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(left:8.0,right: 8.0,),
                                child: Container(
                                  decoration:BoxDecoration(
                                    border: Border(
                                      left: BorderSide(width: 1.0, color: ColorResource.colorF6F6F7.withValues(alpha: 0.8)),
                                      right: BorderSide(width: 1.0, color: ColorResource.colorF6F6F7.withValues(alpha: 0.8)),
                                      bottom: BorderSide(width: 1.0, color: ColorResource.colorF6F6F7.withValues(alpha: 0.8)),
                                      top: BorderSide(width: 1.0, color: ColorResource.colorF6F6F7.withValues(alpha: 0.8)),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 13.0,bottom: 13.0,left:11.0,right:11.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width:AppUtils.getDeviceType()=="tablet"?null:MediaQuery.sizeOf(context).width/2.5,
                                          child: CustomText(
                                            "${context.read<LayoutListBloc>().layoutListModel?.data![index].layoutName}",
                                            //"DOG FOOD - WET",
                                            style: GoogleFonts.inter(
                                                color: ColorResource.color747474,
                                                fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen: FontSize1.thirteen,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        const Spacer(),

                                        Container(
                                          height:AppUtils.getDeviceType()=="tablet"? 30:22,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: ColorResource.color5F5F5F),
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(AppUtils.getDeviceType()=="tablet"?6.0:6.0)),
                                              color: ColorResource.colorCCCCCC),
                                          child: Center(
                                            child: CustomText(
                                            "${context.read<LayoutListBloc>().layoutListModel?.data![index].day?.toUpperCase()}",
                                              style: GoogleFonts.inter(
                                                  color: ColorResource.color5A5C60,
                                                  fontSize:AppUtils.getDeviceType()=="tablet"? FontSize1.fourteen:FontSize1.twelve,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width:AppUtils.getDeviceType()=="tablet"?17:10),
                                        addRadioButton(context.read<LayoutListBloc>().layoutListModel!.data![index]),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )


                      ],
                    ),
                  ),
                  Positioned(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state is LayoutListLoading)
                            SizedBox(child: AppUtils().buildLoading()),
                        ],
                      )),
                ],
              ),
            ),
                bottomNavigationBar:     GestureDetector(
                  onTap: (){
                    debugPrint(context.read<LayoutListBloc>().selectedId.toString());
                    if(context.read<LayoutListBloc>().selectedId.toString() != "" && context.read<LayoutListBloc>().selectedId != null) {
                      context.pushNamed(
                          RouterNames.addTaskEmployeeScreenRouter,
                          queryParameters: {"layout_id": context
                              .read<LayoutListBloc>()
                              .selectedId.toString(), "layout_name": context
                              .read<LayoutListBloc>()
                              .selectedLayoutName});
                    } else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                          backgroundColor: Colors.red,
                          content: Text(StringResource.selectLayout),
                        ),
                      );
                    }
                  },

                  child: Padding(
                    padding: const EdgeInsets.only(left: 54.0, right:54.0,bottom: 20.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              width: 1.0, color: ColorResource.color003867),
                          color: ColorResource.color003867),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            StringResource.next,
                            style: GoogleFonts.inter(
                                color: ColorResource.colorWhite,
                                fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen: FontSize1.fourteen,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          )
          ),
        );
      }, listener: (BuildContext context, state) {
        if(state is LayoutListException){
          AppUtils.showInternetDialog(context,onPressed: () {
            data();
            context.pop();
          });
        }
        if(state is LayoutAuthorization){
          AppUtils.showAuthDialog(context,onPressed: () {
            SharedPreferences.getInstance().then((value) {
              value.setBool(SharedPrefKeys.isLogin, false).then((value) {
               if(context.mounted){
                 context.pushReplacementNamed(RouterNames.loginRouter);
               }
              });
            });
            context.pop();
          });
        }
    },
    );
  }
  Row addRadioButton(Datum btnValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          value:btnValue.id,
          groupValue: context.read<LayoutListBloc>().selectedId,
          onChanged: (value) {
            context.read<LayoutListBloc>().add(SelectedLayoutEvent(btnValue.id!, btnValue.layoutName!));
          },
          activeColor: ColorResource.color003867,
          fillColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {

              if (states.contains(WidgetState.selected)) {
                // Color for the selected (active) radio button
                return ColorResource.color003867; // Change this to your desired color
              }
              // Color for the unselected (inactive) radio button
              return ColorResource.color003867; // Change this to your desired color
            },
          ),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
  void addSearchedFOrItemsToSearchedList(String searchedCharacter,  LayoutListModel model) {
    var result = model.data!
        .where((character) =>
        character.layoutName!.toLowerCase().startsWith(searchedCharacter))
        .toList();
    modelResult = result;
    context.read<LayoutListBloc>().add(const SearchEvent());
  }

}
