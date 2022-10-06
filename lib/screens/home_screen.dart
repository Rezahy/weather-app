import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/services/network.dart';
import 'package:weather_app/widgets/weather_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController textEditingController = TextEditingController();
  Map<String, dynamic>? city;
  bool isLoading = false;
  Map<String, dynamic>? cityInfo;
  Map<String, dynamic>? weatherInfo;
  bool isHasError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 10),
              //   child: Text(
              //     'Weather App',
              //     style: GoogleFonts.lato(
              //         fontSize: 40,
              //         color: kPrimaryColor,
              //         fontWeight: FontWeight.w300,
              //         letterSpacing: 2.5),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              // SizedBox(
              //   height: 8,
              // ),
              // Text(
              //   'enter a location for weather information',
              //   textAlign: TextAlign.center,
              //   style: GoogleFonts.lato(
              //       letterSpacing: 2.5,
              //       fontSize: 16,
              //       color: kPrimaryColor,
              //       fontWeight: FontWeight.w300),
              // ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: TextField(
                  controller: textEditingController,
                  onEditingComplete: () async {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      isLoading = true;
                      isHasError = false;
                    });
                    var currentCityName = textEditingController.text;
                    var searchCityInfo =
                        await Network.getCityId(currentCityName);
                    if (searchCityInfo != null) {
                      var weatherInfoOfCity =
                          await Network.getWeatherInfo(searchCityInfo['Key']);
                      if (weatherInfoOfCity != null) {
                        setState(() {
                          cityInfo = searchCityInfo;
                          weatherInfo = weatherInfoOfCity;
                          isLoading = false;
                        });
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Some Thing Wrong!',
                            style: GoogleFonts.lato(
                                letterSpacing: 2.5,
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      setState(() {
                        isHasError = true;
                        isLoading = false;
                      });
                    }
                  },
                  style: kTextFieldTextStyle,
                  cursorColor: Color(0xFF495057),
                  cursorRadius: Radius.circular(50),
                  decoration: InputDecoration(
                    hintText: 'Search City',
                    hintStyle: GoogleFonts.lato(
                      color: Color(0xFF495057).withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kTextFieldBorderColor, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kTextFieldBorderColor, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFF495057).withOpacity(0.25), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              isHasError
                  ? const SizedBox()
                  : Expanded(
                      child: isLoading
                          ? Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : (weatherInfo == null && cityInfo == null)
                              ? SizedBox.shrink()
                              : WeatherInfo(
                                  cityName: cityInfo!['EnglishName'],
                                  weatherText: weatherInfo!['WeatherText'],
                                  temperature: weatherInfo!['Temperature']
                                      ['Metric']['Value'],
                                  iconSrc:
                                      'assets/icons/${weatherInfo!['WeatherIcon']}.svg',
                                  isDayTime: weatherInfo!['IsDayTime'],
                                )),
              SizedBox(
                height: 13,
              )
            ],
          ),
        ),
      ),
    );
  }
}
