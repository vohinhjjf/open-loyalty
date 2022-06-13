import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:open_loyalty/Firebase/respository.dart';
import 'package:open_loyalty/constant.dart';
import 'package:table_calendar/table_calendar.dart';

class Repair_user extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Repair();
}

class Repair extends State{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  var name = TextEditingController();
  var sex = TextEditingController();
  var birthday = TextEditingController();
  var nationality = TextEditingController();
  var cmd = TextEditingController();
  var mobile = TextEditingController();
  var email = TextEditingController();
  var location = TextEditingController();
  var loyaltyCardNumber;

  CalendarFormat format = CalendarFormat.month;
  late CalendarController _calendarController;
  late DateTime _currentDate = DateTime.now();
  final _repository = Repository();

  _showMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: Text('Calendar'),
          content: Container(
              height: 300,
              width: 400,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    TableCalendar(
                      onDaySelected: (selectedDay, focusedDay1, focusedDay2) {
                        setState(() {
                          //setDate();
                          _currentDate = selectedDay;
                        });
                        birthday.text = "${selectedDay.day.toString().padLeft(2,'0')}-${selectedDay.month.toString().padLeft(2,'0')}-${selectedDay.year.toString()} ";
                      },
                      startDay: DateTime(1900),
                      calendarController: _calendarController,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      calendarStyle: CalendarStyle(
                          weekdayStyle: dayStyle(FontWeight.normal),
                          weekendStyle: dayStyle(FontWeight.normal),
                          selectedColor: mPrimaryColor,
                          todayColor: Colors.blue),
                      daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                              color: mPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: footnote),
                          weekendStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: footnote)),
                      headerStyle: HeaderStyle(
                          formatButtonVisible: false, centerHeaderTitle: true),
                    ),
                  ],
                ),
              )
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }

  updateProfile(){
    return FirebaseFirestore.instance.collection('Users').doc(user?.uid).update({
      'information':{
        'userId': user?.uid,
        'loyaltyCardNumber': loyaltyCardNumber,
        'name' : name.text,
        'gender' : sex.text,
        'birthday' : birthday.text,
        'nationality' : nationality.text,
        'cmd' : cmd.text,
        'number' : mobile.text,
        'email' : email.text,
        'levelId': '',
        'location' : location.text,
      }
    });
  }

  getDataUser(){
    _repository.getCustomerData().then((value) => {
    if(mounted){
        setState(() {
          name.text = value!.name;
          sex.text = value.gender;
          birthday.text = value.birthday;
          nationality.text = value.nationality;
          cmd.text = value.cmd;
          mobile.text = value.phone;
          email.text = user!.email!;
          location.text = value.location;
          loyaltyCardNumber = value.loyaltyCardNumber;
        })
      }
    });
  }

  @override
  void initState() {
    getDataUser();
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cập nhật hồ sơ',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      bottomSheet: InkWell(
        onTap: (){
          if(_formKey.currentState!.validate()){
            EasyLoading.show(status: 'Đang cập nhật hồ sơ...');
            updateProfile().then((value){
              EasyLoading.showSuccess('Cập nhật thành công');
              Navigator.pop(context);
            });
          }
        },
        child: Container(
          width: double.infinity,
          height: 56,
          color: Colors.blueGrey[900],
          child: const Center(
            child: Text(
              'Cập nhật',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(width: 60,),
              TextFormField(
                controller: name,
                decoration: const InputDecoration(
                    labelText: 'Họ và Tên',
                    labelStyle: TextStyle(fontSize: mFontSize),
                    contentPadding: EdgeInsets.zero
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Vui lòng nhập tên';
                  }
                  return null;
                },
              ),
              //sex
              SizedBox(
                child: Padding(padding: const EdgeInsets.fromLTRB(0,10.0,0,10.0),
                  child: TextFormField(
                  controller: sex,
                  decoration: const InputDecoration(
                      labelText: 'Giới tính',
                      labelStyle: TextStyle(fontSize: mFontSize),
                      contentPadding: EdgeInsets.zero
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Vui lòng nhập giới tính';
                    }
                    return null;
                  },
                ),
              ),),

              //birthday
              SizedBox(
                child: Padding(padding: const EdgeInsets.fromLTRB(0,10.0,0,10.0),
                  child: TextFormField(
                    controller: birthday,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: 'Ngày tháng năm sinh',
                        labelStyle: TextStyle(fontSize: mFontSize),
                        contentPadding: EdgeInsets.zero,
                        suffixIcon: IconButton(
                        onPressed: () {
                          _showMaterialDialog(context);
                        },
                          icon: Icon(
                            Icons.calendar_today,
                            color: mPrimaryColor,
                          ),
                        ),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Vui lòng nhập ngày tháng năm sinh';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              //nationality
              SizedBox(
                child: Padding(padding: const EdgeInsets.fromLTRB(0,10.0,0,10.0),
                  child: TextFormField(
                    controller: nationality,
                    decoration: const InputDecoration(
                        labelText: 'Quốc tịch',
                        labelStyle: TextStyle(fontSize: mFontSize),
                        contentPadding: EdgeInsets.zero
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Vui lòng nhập quốc tịch';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              //cmnd
              SizedBox(
                child: Padding(padding: const EdgeInsets.fromLTRB(0,10.0,0,10.0),
                  child: TextFormField(
                controller: cmd,
                decoration: InputDecoration(
                    labelText: 'CMND/CCCD',
                    labelStyle: TextStyle(fontSize: mFontSize),
                    contentPadding: EdgeInsets.zero
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Vui lòng nhập CMND/CCCD';
                  }
                  return null;
                },
              ),
                ),
              ),
              //phone
              SizedBox(
                child: Padding(padding: const EdgeInsets.fromLTRB(0,10.0,0,10.0),
                  child:TextFormField(
                controller: mobile,
                decoration: InputDecoration(
                    labelText: 'Số điện thoại',
                    labelStyle: TextStyle(fontSize: mFontSize),
                    contentPadding: EdgeInsets.zero
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Vui lòng nhập số điện thoại';
                  }
                  return null;
                },
              ),
                ),
              ),
              //email
              SizedBox(
                child: Padding(padding: const EdgeInsets.fromLTRB(0,10.0,0,10.0),
                  child:  TextFormField(
                controller: email,
                enabled: false,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: mFontSize),
                    contentPadding: EdgeInsets.zero
                ),
              ),
                ),
              ),
              //location
              SizedBox(
                child: Padding(padding: const EdgeInsets.fromLTRB(0,10.0,0,10.0),
                  child:  TextFormField(
                controller: location,
                decoration: const InputDecoration(
                    labelText: 'Địa chỉ',
                    labelStyle: TextStyle(fontSize: mFontSize),
                    contentPadding: EdgeInsets.zero
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Vui lòng nhập địa chỉ';
                  }
                  return null;
                },
              ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}