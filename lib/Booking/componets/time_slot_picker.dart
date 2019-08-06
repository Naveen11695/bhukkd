import 'package:flutter/material.dart';
import 'package:time_slot_picker/slot.dart';

typedef tapEvent = void Function(DateTime, DateTime);

class TimeSlot_Picker extends StatefulWidget {
  final DateTime date;
  final ShapeBorder slotBorder;
  final TextStyle textStyle;
  final tapEvent onTap;

  TimeSlot_Picker(
      {Key key,
      this.date,
      this.slotBorder,
      this.textStyle,
      @required this.onTap})
      : super(key: key);

  @override
  _TimeSlotPickerState createState() => _TimeSlotPickerState();
}

class _TimeSlotPickerState extends State<TimeSlot_Picker> {
  DateTime _currentDate = new DateTime.now();
  List<Slot> _timeSlots = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      padding: EdgeInsets.all(5.0),
      child: new ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return new Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: <Widget>[
                new FlatButton(
                  color: Color.fromRGBO(0, 0, 0, 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  padding: EdgeInsets.all(10.0),
                  child: new Text(
                    _timeSlots[index].slotString,
                    style: widget.textStyle != null
                        ? TextStyle(fontSize: 15, color: Colors.white)
                        : new TextStyle(),
                  ),
                  onPressed: () {
                    widget.onTap(
                        _timeSlots[index].startTime, _timeSlots[index].endTime);
                  },
                ),
                new FlatButton(
                  color: Color.fromRGBO(0, 0, 0, 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  padding: EdgeInsets.all(10.0),
                  child: new Text(
                    _timeSlots[index].slotString,
                    style: widget.textStyle != null
                        ? TextStyle(fontSize: 15, color: Colors.white)
                        : new TextStyle(),
                  ),
                  onPressed: () {
                    widget.onTap(
                        _timeSlots[index].startTime, _timeSlots[index].endTime);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.date != null) _currentDate = widget.date;
    _currentDate =
        new DateTime(_currentDate.year, _currentDate.month, _currentDate.day);

    this._timeSlots = _createTimeList(_currentDate);
  }

  List<Slot> _createTimeList(DateTime date) {
    List<Slot> slots = [];
    DateTime currentStartTime = date;
    while (true) {
      Slot slot = new Slot();
      slot.startTime = currentStartTime;
      slot.endTime = currentStartTime
          .add(Duration(hours: 1))
          .subtract(Duration(seconds: 1));
      slot.slotString = _24HourTo12HourString(slot.startTime) +
          " - " +
          _24HourTo12HourString(slot.endTime);
      currentStartTime = currentStartTime.add(Duration(hours: 1));
      slots.add(slot);

      if (slot.endTime.hour == 23 && slot.endTime.minute == 59) break;
    }
    return slots;
  }

  String _24HourTo12HourString(DateTime time) {
    if (time.hour == 0) {
//      String hour = time.hour.toString().length<2?"0"+time.hour.toString():time.hour.toString();
      String minute = time.minute.toString().length < 2
          ? "0" + time.minute.toString()
          : time.minute.toString();
      return "12:$minute AM";
    } else if (time.hour < 12) {
      String hour = time.hour.toString().length < 2
          ? "0" + time.hour.toString()
          : time.hour.toString();
      String minute = time.minute.toString().length < 2
          ? "0" + time.minute.toString()
          : time.minute.toString();
      return "$hour:$minute AM";
    } else if (time.hour == 12) {
//      String hour = time.hour.toString().length<2?"0"+time.hour.toString():time.hour.toString();
      String minute = time.minute.toString().length < 2
          ? "0" + time.minute.toString()
          : time.minute.toString();
      return "12:$minute PM";
    } else {
      String hour = (time.hour - 12).toString().length < 2
          ? "0" + (time.hour - 12).toString()
          : (time.hour - 12).toString();
      String minute = time.minute.toString().length < 2
          ? "0" + time.minute.toString()
          : time.minute.toString();
      return "$hour:$minute PM";
    }
  }
}
