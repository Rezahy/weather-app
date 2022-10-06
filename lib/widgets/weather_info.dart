import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/constants.dart';

class WeatherInfo extends StatefulWidget {
  const WeatherInfo(
      {Key? key,
      required this.cityName,
      required this.temperature,
      required this.weatherText,
      required this.iconSrc,
      required this.isDayTime})
      : super(key: key);
  final String cityName;
  final String weatherText;
  final double temperature;
  final String iconSrc;
  final bool isDayTime;

  @override
  State<WeatherInfo> createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  double opacity = 0.0;
  Duration duration = Duration(milliseconds: 500);
  @override
  void initState() {
    Future.delayed(duration, () {
      setState(() {
        opacity = 1.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.iconSrc);
    return AnimatedOpacity(
      opacity: opacity,
      duration: duration,
      child: LayoutBuilder(builder: (context, constraints) {
        double height = constraints.maxHeight;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: height,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.175),
                      offset: Offset(0, 16),
                      blurRadius: 20)
                ]),
              ),
              Positioned(
                left: 5,
                top: 5,
                bottom: height / 3 + 60,
                right: 5,
                child: SvgPicture.asset(
                  widget.isDayTime
                      ? 'assets/images/day.svg'
                      : 'assets/images/night.svg',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              Positioned(
                left: 5,
                right: 5,
                top: height * 2 / 3 - 60,
                bottom: 5,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 42,
                      ),
                      Text(
                        widget.cityName,
                        style: GoogleFonts.lato(
                            letterSpacing: 2.5,
                            color: kPrimaryColor,
                            fontSize: 21,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.weatherText,
                        style: GoogleFonts.lato(
                            letterSpacing: 2.5,
                            color: kPrimaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.temperature}',
                            style: GoogleFonts.lato(
                                letterSpacing: 2.5,
                                color: kPrimaryColor,
                                fontSize: 55,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '°C',
                            style: GoogleFonts.lato(
                                letterSpacing: 2.5,
                                color: kPrimaryColor,
                                fontSize: 55,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: height / 3 + 60 - 35,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF8F9FA),
                  ),
                  child: SvgPicture.asset(widget.iconSrc),
                ),
              ),
              Container(
                width: double.infinity,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kScaffoldBackgroundColor, width: 5),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
