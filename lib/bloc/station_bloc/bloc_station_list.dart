import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/data/model/station/revp_station_model.dart';
import 'package:railpaytro/data/repo/base/station_repo.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../../data/model/station/station_list_model.dart';

class StationListEvent {}

class StationListRefreshEvent extends StationListEvent {
  List<ASTATIONBean?>? stationListModel;
  List<AREVPSTATIONBean?>? revpStationModel;

  StationListRefreshEvent({this.stationListModel, this.revpStationModel});
}

class StationFilterListEvent extends StationListEvent {
  String? search;

  StationFilterListEvent({this.search});
}

class StationListState {}

class StationListInitialState extends StationListState {}

class StationListLoadingState extends StationListState {}

class StationListSuccessState extends StationListState {
  List<ASTATIONBean?> listData;

  StationListSuccessState(this.listData);
}

class StationListErrorState extends StationListState {
  String errorMsg;

  StationListErrorState(this.errorMsg);
}

//For Revp Station List State
class StationRevpListSuccessState extends StationListState {
  List<AREVPSTATIONBean?> listData;

  StationRevpListSuccessState(this.listData);
}

class StationRevpListErrorState extends StationListState {
  String errorMsg;

  StationRevpListErrorState(this.errorMsg);
}
//-----

class StationListBloc extends Bloc<StationListEvent, StationListState> {
  StationRepo stationRepo;
  List<ASTATIONBean?>? stationList;
  List<AREVPSTATIONBean?>? revpStationList;

  StationListBloc(this.stationRepo) : super(StationListInitialState());

  @override
  Stream<StationListState> mapEventToState(StationListEvent event) async* {
    try {
      if (event is StationListRefreshEvent) {
        yield StationListLoadingState();
        LoginModel user = await SqliteDB.instance.getLoginModelData();
        if (user.RAILPAYSTATIONTYPE == "Common") {
          stationList = event.stationListModel!;
          //    yield StationListSuccessState(stationList ?? []);
        } else {
          revpStationList = event.revpStationModel!;
          //  yield StationRevpListSuccessState(revpStationList ?? []);
        }
      }
    } catch (e, stacktrace) {
      print("$e : $stacktrace");
      yield StationListErrorState("Something Went Wrong");
    }
    try {
      if (event is StationFilterListEvent) {
        yield StationListLoadingState();
        LoginModel user = await SqliteDB.instance.getLoginModelData();
        if (user.RAILPAYSTATIONTYPE == "Common") {
          List<ASTATIONBean?> listData = [];
          if ((event.search ?? "").isNotEmpty) {
            List<ASTATIONBean?> listEqualQueryData = [];
            if (event.search?.length == 3) {
              listEqualQueryData = (stationList ?? [])
                  .where((dynamic selectElement) =>
                      (selectElement.code.toString().toLowerCase() ==
                          event.search.toString().toLowerCase()))
                  .toList();
            }
            List<ASTATIONBean?> listContainsQueryData = (stationList ?? [])
                .where((dynamic selectElement) => (selectElement.value
                    .toString()
                    .toLowerCase()
                    .contains(event.search.toString().toLowerCase())))
                .toList();
            listData.addAll(listEqualQueryData);
            listData.addAll(listContainsQueryData);
            List<ASTATIONBean?> listDataFinal = listData.toSet().toList();
            yield StationListSuccessState(listDataFinal);
          } else {
            listData = stationList ?? [];
            yield StationListSuccessState(listData);
          }
        } else {
          List<AREVPSTATIONBean?> listData = [];
          if ((event.search ?? "").isNotEmpty) {
            List<AREVPSTATIONBean?> listEqualQueryData = [];
            if (event.search?.length == 3) {
              listEqualQueryData = (revpStationList ?? [])
                  .where((dynamic selectElement) =>
                      (selectElement.CRS_CODE.toString().toLowerCase() ==
                          event.search.toString().toLowerCase()))
                  .toList();
            }
            List<AREVPSTATIONBean?> listContainsQueryData = (revpStationList ??
                    [])
                .where((dynamic selectElement) => (selectElement.STATION_NAME
                        .toString()
                        .toLowerCase()
                        .contains(event.search.toString().toLowerCase()) ||
                    selectElement.NLC_CODE
                        .toString()
                        .toLowerCase()
                        .contains(event.search.toString().toLowerCase()) ||
                    selectElement.CRS_CODE
                        .toString()
                        .toLowerCase()
                        .contains(event.search.toString().toLowerCase())))
                .toList();

            listData.addAll(listEqualQueryData);
            listData.addAll(listContainsQueryData);
            List<AREVPSTATIONBean?> listDataFinal = listData.toSet().toList();

            yield StationRevpListSuccessState(listDataFinal);
          } else {
            listData = revpStationList ?? [];
            yield StationRevpListSuccessState(listData);
          }
        }
      }
    } catch (e, stacktrace) {
      print("$e : $stacktrace");
      yield StationListErrorState("Something Went Wrong");
    }
  }
}
