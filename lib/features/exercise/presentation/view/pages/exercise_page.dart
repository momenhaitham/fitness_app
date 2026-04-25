import 'package:fitness_app/app_provider.dart';
import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:fitness_app/core/resources/assets_manager.dart';
import 'package:fitness_app/core/reusable_widgets/back_arrow_icon.dart';
import 'package:fitness_app/core/reusable_widgets/transparent_container.dart';
import 'package:fitness_app/features/exercise/presentation/view/widgets/exercise_item_builder.dart';
import 'package:fitness_app/features/exercise/presentation/view_model/cubit/exercise_cubit.dart';
import 'package:fitness_app/features/exercise/presentation/view_model/cubit/exercise_events.dart';
import 'package:fitness_app/features/exercise/presentation/view_model/cubit/exercise_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class ExercisePage extends StatefulWidget {
  String? muscleId;
  ExercisePage({super.key, this.muscleId = "69d982ef85f6bfa972bf224e"});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  ExerciseCubit cubit = getIt<ExerciseCubit>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cubit.youtubeController?.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    if (cubit.firstTime == true) {
      cubit.doIntent(InitScreenEvent(muscleId: widget.muscleId, currentLocale: provider.currentLocale));
      cubit.firstTime == false;
    }
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocProvider<ExerciseCubit>(
        create: (context) => cubit,
        child: Stack(
          children: [
            Image.asset(AssetsImage.onBoardingBackGround, height: double.infinity, width: double.infinity, fit: BoxFit.cover),

            BlocBuilder<ExerciseCubit, ExerciseStates>(
              builder: (context, state) => CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    leading: InkWell(child: BackArrowIcon(), onTap: () => Navigator.pop(context)),
                    expandedHeight: cubit.state.videoState?.data != null ? height * 0.50 : null,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Container(
                        color: AppColors.lightBlack,
                        child: BlocBuilder<ExerciseCubit, ExerciseStates>(
                          builder: (context, state) {
                            if (state.videoState?.isLoading == true) {
                              return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                            } else if (state.videoState?.data != null && state.videoState?.isLoading == false) {
                              return Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  YoutubePlayer(
                                    aspectRatio: 6 / 9,
                                    controller: cubit.youtubeController!,
                                    showVideoProgressIndicator: true,
                                    progressIndicatorColor: AppColors.primaryColor,
                                    progressColors: const ProgressBarColors(playedColor: AppColors.primaryColor, handleColor: AppColors.primaryColor),
                                  ),
                                  TransparentContainer(
                                    height: height * 0.20,
                                    child: Column(
                                      children: [
                                        Text(state.videoState?.data?.exerciseName ?? "", style: Theme.of(context).textTheme.titleLarge),
                                        Text(state.videoState?.data?.exerciseDefficultyLevel ?? "", style: Theme.of(context).textTheme.bodyLarge),
                                        Spacer(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                border: Border.all(width: 2, color: AppColors.baseWhiteColor),
                                              ),
                                              child: Text("30 MIN", style: Theme.of(context).textTheme.bodyLarge),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                border: Border.all(width: 2, color: AppColors.baseWhiteColor),
                                              ),
                                              child: Text(
                                                "130 Cal",
                                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.primaryColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: BlocBuilder<ExerciseCubit, ExerciseStates>(
                      builder: (context, state) {
                        if (state.levelsState?.isLoading == true) {
                          return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                        } else if (state.levelsState?.data != null && state.levelsState?.isLoading == false) {
                          return Container(
                            //padding: EdgeInsets.symmetric(vertical: height * 0.05),
                            //height: height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                              color: AppColors.lightBlack,
                            ),
                            child: DefaultTabController(
                              length: state.levelsState!.data!.levels!.length,
                              child: TabBar(
                                tabs: state.levelsState!.data!.levels!
                                    .map(
                                      (s) => Container(
                                        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.012),
                                        margin: EdgeInsets.symmetric(vertical: height * 0.01),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: cubit.selectedLevelId == s.levelId ? AppColors.primaryColor : AppColors.grayColor,
                                        ),
                                        child: Center(
                                          child: Text(s.levelName ?? "", style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 19)),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                labelPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
                                isScrollable: true,
                                dividerColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 2),
                                tabAlignment: TabAlignment.start,
                                indicatorColor: AppColors.transparentColor,
                                onTap: (index) {
                                  //cubit.selectedIndex = index;
                                  cubit.selectedLevelId = state.levelsState!.data!.levels![index].levelId;
                                  cubit.doIntent(
                                    GetExercisesEvent(
                                      currentLocale: provider.currentLocale,
                                      muscleId: widget.muscleId,
                                      difficultyLevelId: cubit.selectedLevelId,
                                    ),
                                  );
                                },
                                labelColor: Colors.black,
                              ),
                            ),
                          );
                        } else if (state.levelsState?.error != null && state.levelsState?.isLoading == false) {
                          return Text(
                            state.levelsState?.error.toString() ?? "",
                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: AppColors.errorColor),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: height * 0.05)),
                  SliverToBoxAdapter(
                    child: Expanded(
                      child: BlocBuilder<ExerciseCubit, ExerciseStates>(
                        builder: (context, state) {
                          if (state.exercisesState?.isLoading == true) {
                            return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                          } else if (state.exercisesState?.data != null && state.exercisesState?.isLoading == false) {
                            return Padding(
                              padding: EdgeInsetsGeometry.symmetric(horizontal: width * 0.05),
                              child: TransparentContainer(
                                height: height * 0.70,
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  separatorBuilder: (context, index) {
                                    return TransparentContainer(width: double.infinity, child: Container(),height: height*0.001,color: AppColors.baseWhiteColor,);
                                  },
                                  itemBuilder: (context, index) {
                                    var item = state.exercisesState?.data?.exercises?[index];
                                    print(item?.exerciseYouTubeUrl);
                                    var videoId = cubit.getYoutubeVideoId(item?.exerciseYouTubeUrl ?? '');
                                    return InkWell(
                                      onTap: () {
                                        cubit.doIntent(
                                          LaunchVideoEvent(videoId: videoId, exerciseModel: state.exercisesState!.data!.exercises![index]),
                                        );
                                      },
                                      child: ExerciseItem(
                                        exerciseName: item?.exerciseName,
                                        exerciseDefficultyLevel: item?.exerciseDefficultyLevel,
                                        videoId: videoId,
                                      ),
                                    );
                                  },

                                  itemCount: state.exercisesState?.data?.exercises?.length ?? 0,
                                  //physics: NeverScrollableScrollPhysics(),
                                ),
                              ),
                            );
                          } else if (state.exercisesState?.error != null && state.exercisesState?.isLoading == false) {
                            return Text(
                              state.exercisesState?.error.toString() ?? "",
                              style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: AppColors.errorColor),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                          }
                        },
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: height * 0.05)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
