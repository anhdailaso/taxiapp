import 'package:flutter_taxiapp/model/step_res.dart';

class TripInfoRes {
  final int distance; // met
  final List<StepsRes> steps;

  TripInfoRes(this.distance, this.steps);
}
