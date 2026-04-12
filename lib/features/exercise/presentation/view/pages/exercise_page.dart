import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:fitness_app/core/resources/assets_manager.dart';
import 'package:fitness_app/core/reusable_widgets/back_arrow_icon.dart';
import 'package:fitness_app/core/reusable_widgets/transparent_container.dart';
import 'package:fitness_app/features/exercise/presentation/view/widgets/sources_tabs_builder.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExercisePage extends StatefulWidget {
  ExercisePage({super.key});
  List<String>?sourcesNames=['ass1','ass2','ass3','ass4'];
  
  int? selectedIndex=0;
  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
   YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'TsHAvzGt2-M',
      flags: YoutubePlayerFlags(autoPlay: true, mute: true),
      
    );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      
      body: Stack(
        children: [
          Image.asset(
              AssetsImage.onBoardingBackGround,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                leading: InkWell(child: BackArrowIcon(),
                onTap: () => Navigator.pop(context),
                ),
                expandedHeight: height*0.50,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    color: AppColors.lightBlack,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        YoutubePlayer(
                          aspectRatio: 6/9,
                          controller: _controller,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: AppColors.primaryColor,
                          progressColors: const ProgressBarColors(
                            playedColor: AppColors.primaryColor,
                            handleColor: AppColors.primaryColor,
                          ),
                        ),
                        TransparentContainer(
                          height: height*0.20,
                          child: Column(
                          children: [
                            Text("Chest Exercise",style: Theme.of(context).textTheme.titleLarge,),
                            Text("Lorem ipsum dolor sit amet consectetur. Tempus volutpat ut nisi morbi. ",style: Theme.of(context).textTheme.bodyLarge,),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(width: 2,color: AppColors.baseWhiteColor)
                                  ),
                                  child: Text("30 MIN",style: Theme.of(context).textTheme.bodyLarge,),
                                ),
                                 Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(width: 2,color: AppColors.baseWhiteColor)
                                  ),
                                  child: Text("130 Cal",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.primaryColor),),
                                ),
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width*0.05),
                  height: height*0.10,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: AppColors.lightBlack),
                  child: DefaultTabController(length: widget.sourcesNames!.length,
                      child: TabBar(
                        tabs:widget.sourcesNames!.map((s)=>Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color:AppColors.primaryColor,
                          ),
                          child: Center(child: Text(s,style: Theme.of(context).textTheme.headlineLarge,),),
                          )
                      ).toList(),
                      labelPadding: EdgeInsets.symmetric(horizontal: width*0.02),
                      isScrollable: true,
                      dividerColor: Colors.transparent,
                      tabAlignment: TabAlignment.start,
                      indicatorColor: Theme.of(context).secondaryHeaderColor,
                      onTap: (index){widget.selectedIndex=index;
                        setState(() {});
                        },
                      labelColor: Colors.black,)
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: height*2,),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: height*2,),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: height*2,),
              ),
            ],
           
          ),
        ],
      ),
    );
  }
}
