import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dot_animation_enum.dart';
import 'list_rtl_language.dart';
import 'scrollbar_behavior_enum.dart';
import 'slide_object.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroSlider extends StatefulWidget {
  // ---------- Slides ----------
  /// An array of Slide object
  final List<Slide>? slides;

  /// Background color for all slides
  final Color? backgroundColorAllSlides;

  final bool? desktopActionButtonEnabled;

  // ---------- SKIP button ----------
  /// Render your own widget SKIP button
  final Widget? renderSkipBtn;

  /// Render your own style SKIP button
  final ButtonStyle? skipButtonStyle;

  /// Fire when press SKIP button
  final void Function()? onSkipPress;

  /// Show or hide SKIP button
  final bool? showSkipBtn;

  /// Assign Key to SKIP button
  final Key? skipButtonKey;

  // ---------- PREV button ----------
  /// Render your own widget PREV button
  final Widget? renderPrevBtn;

  /// Render your own style PREV button
  final ButtonStyle? prevButtonStyle;

  /// Show or hide PREV button (only visible if skip is hidden)
  final bool? showPrevBtn;

  /// Assign Key to PREV button
  final Key? prevButtonKey;

  // ---------- NEXT button ----------
  /// Render your own widget NEXT button
  final Widget? renderNextBtn;

  /// Render your own style NEXT button
  final ButtonStyle? nextButtonStyle;

  /// Show or hide NEXT button
  final bool? showNextBtn;

  /// Assign Key to NEXT button
  final Key? nextButtonKey;

  // ---------- DONE button ----------
  /// Render your own widget DONE button
  final Widget? renderDoneBtn;

  /// Render your own style NEXT button
  final ButtonStyle? doneButtonStyle;

  /// Fire when press DONE button
  final void Function()? onDonePress;

  /// Show or hide DONE button
  final bool? showDoneBtn;

  /// Assign Key to DONE button
  final Key? doneButtonKey;

  // ---------- Dot indicator ----------
  /// Show or hide dot indicator
  final bool? showDotIndicator;

  /// Color for dot when passive
  final Color? colorDot;

  /// Color for dot when active
  final Color? colorActiveDot;

  /// Size of each dot
  final double? sizeDot;

  final double? subTitleFontSize;
  final double? titleFontSize;

  /// Type dots animation
  final dotSliderAnimation? typeDotAnimation;

  // ---------- Tabs ----------
  /// Render your own custom tabs
  final List<Widget>? listCustomTabs;

  /// Notify when tab change completed
  final void Function(int index)? onTabChangeCompleted;

  /// Ref function go to specific tab index
  final void Function(Function function)? refFuncGoToTab;

  // ---------- Behavior ----------
  /// Whether or not the slider is scrollable (or controlled only by buttons)
  final bool? isScrollable;
  final ScrollPhysics? scrollPhysics;

  /// Show or hide status bar
  final bool? hideStatusBar;

  final String? termsLink;

  /// The way the vertical scrollbar should behave
  final scrollbarBehavior? verticalScrollbarBehavior;

  // Constructor
  IntroSlider({
    this.termsLink,
    // Slides
    this.slides,
    this.backgroundColorAllSlides,
this.desktopActionButtonEnabled,
    // Skip
    this.renderSkipBtn,
    this.skipButtonStyle,
    this.onSkipPress,
    this.showSkipBtn,
    this.skipButtonKey,

    // Prev
    this.renderPrevBtn,
    this.prevButtonStyle,
    this.showPrevBtn,
    this.prevButtonKey,

    // Done
    this.renderDoneBtn,
    this.onDonePress,
    this.doneButtonStyle,
    this.showDoneBtn,
    this.doneButtonKey,

    // Next
    this.renderNextBtn,
    this.nextButtonStyle,
    this.showNextBtn,
    this.nextButtonKey,

    // Dots
    this.colorActiveDot,
    this.colorDot,
    this.showDotIndicator,
    this.sizeDot,
    this.subTitleFontSize,
    this.titleFontSize,
    this.typeDotAnimation,

    // Tabs
    this.listCustomTabs,
    this.onTabChangeCompleted,
    this.refFuncGoToTab,

    // Behavior
    this.isScrollable,
    this.scrollPhysics,
    this.hideStatusBar,
    this.verticalScrollbarBehavior,
  });

  @override
  IntroSliderState createState() => IntroSliderState();
}

class IntroSliderState extends State<IntroSlider>
    with SingleTickerProviderStateMixin {
  // ---------- Slides ----------
  /// An array of Slide object
  late final List<Slide>? slides;

  // ---------- SKIP button ----------
  /// Render your own widget SKIP button
  late final Widget renderSkipBtn;

  /// Fire when press SKIP button
  late final void Function()? onSkipPress;

  /// Render your own style SKIP button
  late final ButtonStyle skipButtonStyle;

  /// Show or hide SKIP button
  late final bool showSkipBtn;

  late final String? termsLink;

  /// Assign Key to SKIP button
  late final Key? skipButtonKey;

  // ---------- PREV button ----------
  /// Render your own widget PREV button
  late final Widget renderPrevBtn;

  /// Render your own style PREV button
  late final ButtonStyle prevButtonStyle;

  /// Show or hide PREV button
  late final bool showPrevBtn;

  /// Assign Key to PREV button
  late final Key? prevButtonKey;

  // ---------- DONE button ----------
  /// Render your own widget DONE button
  late final Widget renderDoneBtn;

  /// Fire when press DONE button
  late final void Function()? onDonePress;

  /// Render your own style DONE button
  late final ButtonStyle doneButtonStyle;

  /// Show or hide DONE button
  late final bool showDoneBtn;

  /// Assign Key to DONE button
  late final Key? doneButtonKey;

  // ---------- NEXT button ----------
  /// Render your own widget NEXT button
  late final Widget renderNextBtn;

  /// Render your own style NEXT button
  late final ButtonStyle nextButtonStyle;

  /// Show or hide NEXT button
  late final bool showNextBtn;

  /// Assign Key to NEXT button
  late final Key? nextButtonKey;

  // ---------- Dot indicator ----------
  /// Show or hide dot indicator
  late final bool showDotIndicator;

  /// Color for dot when passive
  late final Color colorDot;

  /// Color for dot when active
  late final Color colorActiveDot;

  /// Size of each dot
  late final double sizeDot;
  late final double? subTitleFontSize;
  late final double? titleFontSize;

  /// Type dots animation
  late final dotSliderAnimation typeDotAnimation;

  // ---------- Tabs ----------
  /// List custom tabs
  List<Widget>? listCustomTabs;

  /// Notify when tab change completed
  Function? onTabChangeCompleted;

  // ---------- Behavior ----------
  /// Allow the slider to scroll
  late final bool isScrollable;
  late final ScrollPhysics scrollPhysics;

  /// The way the vertical scrollbar should behave
  late final scrollbarBehavior verticalScrollbarBehavior;

  late TabController tabController;

  bool isChecked = false;

  List<Widget> tabs = [];
  List<Widget> dots = [];
  List<double> sizeDots = [];
  List<double> opacityDots = [];
  List<ScrollController> scrollControllers = [];

  // For DOT_MOVEMENT
  double marginLeftDotFocused = 0;
  double marginRightDotFocused = 0;

  // For SIZE_TRANSITION
  double currentAnimationValue = 0;
  int currentTabIndex = 0;

  late final int lengthSlide;

  @override
  void initState() {
    super.initState();
    termsLink = widget.termsLink;
    slides = widget.slides;
    subTitleFontSize = widget.subTitleFontSize;
    titleFontSize = widget.titleFontSize;
    skipButtonKey = widget.skipButtonKey;
    prevButtonKey = widget.prevButtonKey;
    doneButtonKey = widget.doneButtonKey;
    nextButtonKey = widget.nextButtonKey;

    lengthSlide = slides?.length ?? widget.listCustomTabs?.length ?? 0;

    onTabChangeCompleted = widget.onTabChangeCompleted;
    tabController = TabController(length: lengthSlide, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        currentTabIndex = tabController.previousIndex;
      } else {
        currentTabIndex = tabController.index;
        onTabChangeCompleted?.call(tabController.index);
      }
      currentAnimationValue = tabController.animation?.value ?? 0;
    });

    // Send reference function goToTab to parent
    widget.refFuncGoToTab?.call(goToTab);

    // Dot animation
    sizeDot = widget.sizeDot ?? 8.0;

    final initValueMarginRight = (sizeDot * 2) * (lengthSlide - 1);
    typeDotAnimation =
        widget.typeDotAnimation ?? dotSliderAnimation.DOT_MOVEMENT;

    switch (typeDotAnimation) {
      case dotSliderAnimation.DOT_MOVEMENT:
        for (var i = 0; i < lengthSlide; i++) {
          sizeDots.add(sizeDot);
          opacityDots.add(1.0);
        }
        marginRightDotFocused = initValueMarginRight;
        break;
      case dotSliderAnimation.SIZE_TRANSITION:
        for (var i = 0; i < lengthSlide; i++) {
          if (i == 0) {
            sizeDots.add(sizeDot * 1.5);
            opacityDots.add(1.0);
          } else {
            sizeDots.add(sizeDot);
            opacityDots.add(0.5);
          }
        }
    }

    tabController.animation?.addListener(() {
      setState(() {
        switch (typeDotAnimation) {
          case dotSliderAnimation.DOT_MOVEMENT:
            marginLeftDotFocused = tabController.animation!.value * sizeDot * 2;
            marginRightDotFocused = initValueMarginRight -
                tabController.animation!.value * sizeDot * 2;
            break;
          case dotSliderAnimation.SIZE_TRANSITION:
            if (tabController.animation!.value == currentAnimationValue) {
              break;
            }

            var diffValueAnimation =
            (tabController.animation!.value - currentAnimationValue).abs();
            final diffValueIndex =
            (currentTabIndex - tabController.index).abs();

            // When press skip button
            if (tabController.indexIsChanging &&
                (tabController.index - tabController.previousIndex).abs() > 1) {
              if (diffValueAnimation < 1.0) {
                diffValueAnimation = 1.0;
              }
              sizeDots[currentTabIndex] = sizeDot * 1.5 -
                  (sizeDot / 2) * (1 - (diffValueIndex - diffValueAnimation));
              sizeDots[tabController.index] = sizeDot +
                  (sizeDot / 2) * (1 - (diffValueIndex - diffValueAnimation));
              opacityDots[currentTabIndex] =
                  1.0 - (diffValueAnimation / diffValueIndex) / 2;
              opacityDots[tabController.index] =
                  0.5 + (diffValueAnimation / diffValueIndex) / 2;
            } else {
              if (tabController.animation!.value > currentAnimationValue) {
                // Swipe left
                sizeDots[currentTabIndex] =
                    sizeDot * 1.5 - (sizeDot / 2) * diffValueAnimation;
                sizeDots[currentTabIndex + 1] =
                    sizeDot + (sizeDot / 2) * diffValueAnimation;
                opacityDots[currentTabIndex] = 1.0 - diffValueAnimation / 2;
                opacityDots[currentTabIndex + 1] = 0.5 + diffValueAnimation / 2;
              } else {
                // Swipe right
                sizeDots[currentTabIndex] =
                    sizeDot * 1.5 - (sizeDot / 2) * diffValueAnimation;
                sizeDots[currentTabIndex - 1] =
                    sizeDot + (sizeDot / 2) * diffValueAnimation;
                opacityDots[currentTabIndex] = 1.0 - diffValueAnimation / 2;
                opacityDots[currentTabIndex - 1] = 0.5 + diffValueAnimation / 2;
              }
            }
            break;
        }
      });
    });

    // Dot indicator
    showDotIndicator = widget.showDotIndicator ?? true;

    colorDot = widget.colorDot ?? const Color(0x80000000);

    colorActiveDot = widget.colorActiveDot ?? colorDot;

    isScrollable = widget.isScrollable ?? true;

    scrollPhysics = widget.scrollPhysics ?? const ScrollPhysics();

    verticalScrollbarBehavior =
        widget.verticalScrollbarBehavior ?? scrollbarBehavior.HIDE;

    setupButtonDefaultValues();

    if (widget.listCustomTabs == null) {
      renderListTabs();
    } else {
      tabs = widget.listCustomTabs!;
    }
  }

  void setupButtonDefaultValues() {
    // Skip button
    onSkipPress = widget.onSkipPress ??
            () {
          if (!isAnimating()) {
            if (lengthSlide > 0) {
              tabController.animateTo(lengthSlide - 1);
            }
          }
        };

    showSkipBtn = widget.showSkipBtn ?? true;

    renderSkipBtn = widget.renderSkipBtn ??
        Text(
          "SKIP",
          style: TextStyle(color: Colors.white),
        );
    skipButtonStyle = widget.skipButtonStyle ?? ButtonStyle();

    // Prev button
    if (showSkipBtn) {
      showPrevBtn = false;
    } else {
      showPrevBtn = widget.showPrevBtn ?? true;
    }

    renderPrevBtn = widget.renderPrevBtn ??
        Text(
          "PREV",
          style: TextStyle(color: Colors.white),
        );
    prevButtonStyle = widget.prevButtonStyle ?? ButtonStyle();

    showNextBtn = widget.showNextBtn ?? true;

    // Done button
    onDonePress = widget.onDonePress ?? () {};
    renderDoneBtn = widget.renderDoneBtn ??
        Text(
          "DONE",
          style: TextStyle(color: Colors.white),
        );
    doneButtonStyle = widget.doneButtonStyle ?? ButtonStyle();
    showDoneBtn = widget.showDoneBtn ?? true;

    // Next button
    renderNextBtn = widget.renderNextBtn ??
        Text(
          "NEXT",
          style: TextStyle(color: Colors.white),
        );
    nextButtonStyle = widget.nextButtonStyle ?? ButtonStyle();
  }

  void goToTab(int index) {
    if (index < tabController.length) {
      tabController.animateTo(index);
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  // Checking if tab is animating
  bool isAnimating() {
    Animation<double>? animation = tabController.animation;
    if (animation != null) {
      return animation.value - animation.value.truncate() != 0;
    } else {
      return false;
    }
  }

  bool isRTLLanguage(String language) {
    return rtlLanguages.contains(language);
  }

  @override
  Widget build(BuildContext context) {
    // Full screen view
    if (widget.hideStatusBar == true) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    }

    return Scaffold(
      body: DefaultTabController(
        length: lengthSlide,
        child: Stack(
          children: <Widget>[
            TabBarView(
              controller: tabController,
              physics: isScrollable
                  ? scrollPhysics
                  : const NeverScrollableScrollPhysics(),
              children: tabs,
              // children: [
              //   Container (
              //     child
              //   )
              // ],
            ),
            renderBottom(),
          ],
        ),
      ),
      backgroundColor: Color(0xff1A1C2E),
    );
  }

  Widget buildSkipButton() {
    if (tabController.index + 1 == lengthSlide) {
      return Container(width: MediaQuery.of(context).size.width / 4);
    } else {
      return TextButton(
        key: skipButtonKey,
        onPressed: onSkipPress,
        style: skipButtonStyle,
        child: renderSkipBtn,
      );
    }
  }

  Widget buildDoneButton() {
    return TextButton(
      key: doneButtonKey,
      onPressed: onDonePress,
      style: doneButtonStyle,
      child: renderDoneBtn,
    );
  }

  Widget buildPrevButton() {
    if (tabController.index == 0) {
      return Container(width: MediaQuery.of(context).size.width / 4);
    } else {
      return TextButton(
        key: prevButtonKey,
        onPressed: () {
          if (!isAnimating()) {
            tabController.animateTo(tabController.index - 1);
          }
        },
        style: prevButtonStyle,
        child: renderPrevBtn,
      );
    }
  }

  Widget buildNextButton() {
    return TextButton(
      key: nextButtonKey,
      onPressed: () {
        if (!isAnimating()) {
          tabController.animateTo(tabController.index + 1);
        }
      },
      style: nextButtonStyle,
      child: renderNextBtn,
    );
  }

  Widget renderBottom() {
    return  Positioned(
        bottom: tabController.index == 2 ? 10.0 : 20.0,
        left: 10.0,
        right: 10.0,
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: showDotIndicator
                  ? Stack(
                children: <Widget>[
                  Container(
                      child: tabController.index == 2?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            checkColor: Colors.purple,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))), // Rounded Checkbox
                            side: BorderSide(
                              width: 16.0,
                              color: Colors.white,
                            ),
                            fillColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                            value: isChecked,
                            onChanged: (bool? value) {
                              renderListTabs();
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          Text(
                              'I agree to the ',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Color(0xffFDFCFC)
                              )
                          ),
                          GestureDetector(
                            child: Text('Terms & Conditions',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xff00D9FF),
                                  fontSize: 12.0,
                                )
                            ),
                            onTap: () async {
                              launch(termsLink ?? "");
                            },
                          )
                        ],
                      )
                          :  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: renderListDots(),
                      )
                  ),
                  if (typeDotAnimation == dotSliderAnimation.DOT_MOVEMENT && tabController.index != 2)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: colorActiveDot,
                                borderRadius:
                                BorderRadius.circular(sizeDot / 2)),
                            width: sizeDot,
                            height: sizeDot,
                            margin: EdgeInsets.only(
                                left: isRTLLanguage(
                                    Localizations.localeOf(context)
                                        .languageCode)
                                    ? marginRightDotFocused
                                    : marginLeftDotFocused,
                                right: isRTLLanguage(
                                    Localizations.localeOf(context)
                                        .languageCode)
                                    ? marginLeftDotFocused
                                    : marginRightDotFocused),
                          )
                        ]
                    )
                  else
                    Container()
                ],
              )
                  : Container(),
            ),
          ],
        )
    );
  }

  List<Widget>? renderListTabs() {
    tabs = [];
    for (var i = 0; i < lengthSlide; i++) {
      final scrollController = ScrollController();
      scrollControllers.add(scrollController);
      tabs.add(
        renderTab(
          scrollController,
          slides?[i].widgetTitle,
          slides?[i].title,
          slides?[i].titleTextFontSize,
          slides?[i].subTitleTextFontSize,
          slides?[i].desktopActionButtonEnabled,
          slides?[i].maxLineTitle,
          slides?[i].styleTitle,
          slides?[i].marginTitle,
          slides?[i].widgetDescription,
          slides?[i].description,
          slides?[i].maxLineTextDescription,
          slides?[i].styleDescription,
          slides?[i].marginDescription,
          slides?[i].btnTitle,
          slides?[i].pathImage,
          slides?[i].widthImage,
          slides?[i].heightImage,
          slides?[i].foregroundImageFit,
          slides?[i].centerWidget,
          slides?[i].onCenterItemPress,
          slides?[i].backgroundColor,
          slides?[i].colorBegin,
          slides?[i].colorEnd,
          slides?[i].directionColorBegin,
          slides?[i].directionColorEnd,
          slides?[i].backgroundImage,
          slides?[i].backgroundImageFit,
          slides?[i].backgroundOpacity,
          slides?[i].backgroundOpacityColor,
          slides?[i].backgroundBlendMode,
        ),
      );
    }
    return tabs;
  }

  void handleClicked (String btnTitle) {

      if(!isChecked && btnTitle == 'Get Started') return;
      if (btnTitle == 'Get Started') onDonePress!();
      if (!isAnimating() && btnTitle != 'Get Started') {
        tabController
            .animateTo(tabController.index + 1);
      }
      // tabController.animateTo(tabController.index - 1);
  }

  Widget getButton (String btnTitle) {
    return TextButton(
        key: UniqueKey(),
        onPressed: () {
          handleClicked(btnTitle);
        },
        child: Center(
            child: Text(
              btnTitle,
              style: TextStyle(color: isChecked ||  btnTitle != 'Get Started'?  Colors.white : Color(0x66FDFAFA)),
              textAlign: TextAlign.center,
            )
        )
    );
  }
  Widget renderTab(
      ScrollController scrollController,
      // Title
      Widget? widgetTitle,
      String? title,
      double? titleTextFontSize,
      double? subTitleTextFontSize,
      bool? desktopActionButtonEnabled,
      int? maxLineTitle,
      TextStyle? styleTitle,
      EdgeInsets? marginTitle,

      // Description
      Widget? widgetDescription,
      String? description,
      int? maxLineTextDescription,
      TextStyle? styleDescription,
      EdgeInsets? marginDescription,
      btnTitle,
      // Image
      String? pathImage,
      double? widthImage,
      double? heightImage,
      BoxFit? foregroundImageFit,

      // Center Widget
      Widget? centerWidget,
      void Function()? onCenterItemPress,

      // Background color
      Color? backgroundColor,
      Color? colorBegin,
      Color? colorEnd,
      AlignmentGeometry? directionColorBegin,
      AlignmentGeometry? directionColorEnd,

      // Background image
      String? backgroundImage,
      BoxFit? backgroundImageFit,
      double? backgroundOpacity,
      Color? backgroundOpacityColor,
      BlendMode? backgroundBlendMode,
      ) {
    final listView = ListView.custom(
      controller: scrollController,
      childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                color: Color(0xff1A1C2E),
                key: Key('$isChecked'),
                height: MediaQuery.of(context).size.height - 60,
                child: Column (
                  mainAxisAlignment: desktopActionButtonEnabled == true ? MainAxisAlignment.spaceBetween : MainAxisAlignment.spaceAround,
                  children: [
                    if(desktopActionButtonEnabled == true && title != 'End-to-End Encryption')
                      Container(
                          height: 26.0,
                          margin: EdgeInsets.only(left: 8.0, top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  tabController.animateTo(tabController.index - 1);
                                },
                                child:  Image.asset('assets/images/icons/WHITE-ARROW.png'),
                              )
                            ],
                          )
                      )
                    else
                      Container(height: 26.0, margin: EdgeInsets.only(left: 8.0, top: 8.0)),
                    Flexible (
                      flex: 20,
                      child: pathImage != null
                          ? Image.asset(
                        pathImage,
                        fit: BoxFit.contain,
                      )
                          : Center(child: centerWidget ?? Container()),
                    ),
                    Flexible (
                        flex: 8,
                        child: Column (
                          children: [
                            widgetTitle ??
                                Text(
                                  title ?? '',
                                  style: styleTitle ??
                                      TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: titleTextFontSize,
                                          fontFamily: 'MontserratExtraBold'),
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            Container(
                              width: desktopActionButtonEnabled == true ? 450.0: 300,
                              margin: marginDescription ??
                                  const EdgeInsets.only(top: 8.0),
                              child: widgetDescription ??
                                  Text(
                                    description ?? '',
                                    style: styleDescription ??
                                        TextStyle(
                                            color: Colors.white,
                                            fontSize: subTitleTextFontSize,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Montserrat'),
                                    textAlign: TextAlign.center,
                                    maxLines: maxLineTextDescription ?? 100,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            )
                          ],
                        )

                    ),
                    desktopActionButtonEnabled == true ?
                    Flexible(
                      flex: 4,
                      child: Container(
                          decoration: isChecked ||  btnTitle != 'Get Started'? BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            color: Color(0xffC24DF8),
                            border: Border.all(width: 1.0, color: Color(0xffC24DF8)),
                          ): BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            color: Color(0x66C24DF8),
                            border: Border.all(width: 1.0, color: Color(0x66C24DF8)),
                          ),
                          width: 120,
                          height: 30,
                          child: TextButton(
                              onPressed: () {
                                handleClicked(btnTitle);
                              },
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text(btnTitle,
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            fontFamily: 'MontserratLight',
                                            color: Color(0xff000000)
                                        )),
                                  ),
                                ],
                              ))
                      ),
                    ) :
                    Flexible(
                        flex: 3,
                        key: Key('$isChecked'),
                        child: Container(
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            border: isChecked ||  btnTitle != 'Get Started'? Border(
                              top: BorderSide(width: 1.0, color: Color(0xFFFDFAFA)),
                              left:
                              BorderSide(width: 1.0, color: Color(0xFFFDFAFA)),
                              right:
                              BorderSide(width: 1.0, color: Color(0xFFFDFAFA)),
                              bottom:
                              BorderSide(width: 1.0, color: Color(0xFFFDFAFA)),
                            ): Border(
                              top: BorderSide(width: 1.0, color: Color(0x66FDFAFA)),
                              left:
                              BorderSide(width: 1.0, color: Color(0x66FDFAFA)),
                              right:
                              BorderSide(width: 1.0, color: Color(0x66FDFAFA)),
                              bottom:
                              BorderSide(width: 1.0, color: Color(0x66FDFAFA)),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 0.0.h, horizontal: 8.0.w),
                          margin: EdgeInsets.only(bottom: 16.0),
                          height: 50.0,
                          width: 110.0,
                          child: getButton(btnTitle)
                        )
                    ),
                  ],
                ),
              );
            },
          );

        },
        childCount: 1,
      ),
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
    );
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: backgroundImage != null
          ? BoxDecoration(
        color: Color(0xff1A1C2E),
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: backgroundImageFit ?? BoxFit.cover,
          colorFilter: ColorFilter.mode(
            backgroundOpacityColor != null
                ? backgroundOpacityColor
                .withOpacity(backgroundOpacity ?? 0.5)
                : Colors.black.withOpacity(backgroundOpacity ?? 0.5),
            backgroundBlendMode ?? BlendMode.darken,
          ),
        ),
      )
          : BoxDecoration(
        color: Color(0xff1A1C2E),
        gradient: LinearGradient(
          colors: backgroundColor != null
              ? ([backgroundColor, backgroundColor])
              : [
            colorBegin ?? Colors.amberAccent,
            colorEnd ?? Colors.amberAccent
          ],
          begin: directionColorBegin ?? Alignment.topLeft,
          end: directionColorEnd ?? Alignment.bottomRight,
        ),
      ),
      child: Container(
        color: Color(0xff1A1C2E),
        // margin: const EdgeInsets.only(bottom: 60.0),
        child: listView,
      ),
    );
  }

  List<Widget> renderListDots() {
    dots.clear();
    for (var i = 0; i < lengthSlide; i++) {
      dots.add(renderDot(sizeDots[i], colorDot, opacityDots[i], i));
    }
    return dots;
  }

  Widget renderDot(double radius, Color? color, double opacity, int index) {
    return GestureDetector(
      onTap: () {
        tabController.animateTo(index);
      },
      child: Opacity(
        opacity: opacity,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius / 2),
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.white),
              left: BorderSide(width: 1.0, color: Colors.white),
              right: BorderSide(width: 1.0, color: Colors.white),
              bottom: BorderSide(width: 1.0, color: Colors.white),
            ),
          ),
          width: radius,
          height: radius,
          margin: EdgeInsets.only(left: radius / 2, right: radius / 2),
        ),
      ),
    );
  }
}