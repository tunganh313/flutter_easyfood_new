import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminCardItemWidget extends StatelessWidget {
  final IconData? icon;
  final String? text;

  const AdminCardItemWidget({
    Key? key,
    this.icon,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      borderOnForeground: true,
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 10,
        height: MediaQuery.of(context).size.height / 5,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,size: 40),
              SizedBox(height: 20,),
              Text('$text',style: GoogleFonts.jetBrainsMono(
                fontSize: 18,
                fontWeight: FontWeight.w900
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
