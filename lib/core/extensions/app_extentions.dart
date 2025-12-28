import 'package:flutter/material.dart';

extension AppNumberExtension on num {
  //----------------------- borderRadius ------------------------
  BorderRadius get allBorderRadius => BorderRadius.circular(toDouble());
  //----------------------- Padding ------------------------
  EdgeInsets get allPading => EdgeInsets.all(toDouble());
  BorderRadius get bottomBorderRadius =>
      BorderRadius.vertical(bottom: Radius.circular(toDouble()));
  EdgeInsets get hPading => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get vPading => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets get topPading => EdgeInsets.only(top: toDouble());
  EdgeInsets get leftPading => EdgeInsets.only(left: toDouble());
  EdgeInsets get bottomPading => EdgeInsets.only(bottom: toDouble());
  EdgeInsets get rightPading => EdgeInsets.only(right: toDouble());


  //----------------------- SizedBox ------------------------
  Widget get verticalSizedBox => SizedBox(height: toDouble());
  Widget get horizontalSizedBox => SizedBox(width: toDouble());
}
extension SizeExtension on BuildContext{
  double get heigh => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
}
extension ContextExtension on BuildContext{
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
  void pop<T>([T? result]) => Navigator.pop(this,result);
  Future<T?> pushNamed<T>(String routeName,{Object? arguments}){
    return Navigator.of(this).pushNamed(routeName,arguments: arguments);
  }
  Future<T?> pushNamedAndRemoveUntil<T>(String routeName,{required RoutePredicate predicate,Object? arguments}){
    return Navigator.of(this).pushNamedAndRemoveUntil(routeName,predicate,arguments: arguments);
  }
  Future<T?> pushReplacementNamed<T>(String routeName,{Object? arguments}){
    return Navigator.of(this).pushReplacementNamed(routeName,arguments: arguments);
  }
}
extension WidgetExtension on Widget{
  Widget allPading (double padding)=> Padding(padding: EdgeInsets.all(padding),child: this,);
  Widget center()=>Center(child: this,);
  Widget sizedBox({double heigh=0,double width=0,})=>SizedBox(height:heigh,width: width,child: this,);
  Widget clipRRect({BorderRadius borderRadius = BorderRadius.zero})=>ClipRRect(borderRadius: borderRadius,child: this,);
  Widget horizontalPadding(double padding)=>Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: padding),child: this,);
  Widget verticalPadding(double padding)=>Padding(padding: EdgeInsetsGeometry.symmetric(vertical: padding),child: this,);
  Widget onlyPadding({double topPadding=0,double bottomPadding=0,double leftPadding=0,double rightPadding=0,})=>Padding(padding: EdgeInsets.only(bottom:bottomPadding ,left:leftPadding ,right: rightPadding,top:topPadding ),child: this,);
  Widget onlyPaddingDirectional({double topPadding=0,double bottomPadding=0,double leftPadding=0,double rightPadding=0,})=>Padding(padding: EdgeInsetsDirectional.only(bottom:bottomPadding ,end:leftPadding ,start: rightPadding,top:topPadding ),child: this,);

}