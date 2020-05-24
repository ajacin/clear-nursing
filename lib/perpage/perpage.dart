import 'package:mobx/mobx.dart';

part 'perpage.g.dart';//flutter packages pub run build_runner watch

class PerPage = _PerPage with _$PerPage;//flutter packages pub run build_runner watch

abstract class _PerPage with Store{
  
  @observable
  int perPage =4;
  int startIndex=0;
  int endIndex=0;
  int totalquestions=41;

  @action
  void nextPages(){
  
    startIndex=startIndex+perPage;
    endIndex=endIndex+perPage;
    perPage=perPage+10;
  }

}