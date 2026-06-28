import 'package:alabtechnology/alabtechnology.dart';
import 'package:alabtechnology_example/custom_text_form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: AppTextTheme.textTheme()),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: .center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: AlabTechnologyFormField(
                      decoration: InputDecoration(
                        labelText: "Enter name *",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: .w500,
                          color: Colors.black,
                        ),
                        floatingLabelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: .w600,
                          color: Colors.red,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                            color: Colors.grey.shade100,
                            style: .solid,
                            strokeAlign: 2,
                            width: 1.4,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                            color: Colors.red,
                            style: .solid,
                            strokeAlign: 2,
                            width: 1.4,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                            color: Colors.red,
                            style: .solid,
                            strokeAlign: 2,
                            width: 1.4,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                            color: Colors.red,
                            style: .solid,
                            strokeAlign: 2,
                            width: 1.4,
                          ),
                        ),
                      ),
                      textEditingController: TextEditingController(),
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      validator: (value) {
                        if ( value == null || value.isEmpty) {
                          return "Enter filed";
                        } else if ( value.length < 3) {
                          return 'minimum 3 letter required';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: AlabTechnologyFormField(
                      decoration: InputDecoration(
                        labelText: "Enter name *",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: .w500,
                          color: Colors.black,
                        ),
                        floatingLabelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: .w600,
                          color: Colors.red,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                            color: Colors.grey.shade100,
                            style: .solid,
                            strokeAlign: 2,
                            width: 1.4,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                            color: Colors.red,
                            style: .solid,
                            strokeAlign: 2,
                            width: 1.4,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                            color: Colors.red,
                            style: .solid,
                            strokeAlign: 2,
                            width: 1.4,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                            color: Colors.red,
                            style: .solid,
                            strokeAlign: 2,
                            width: 1.4,
                          ),
                        ),
                      ),
                      textEditingController: TextEditingController(),
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Enter filed";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SocialMediaView(),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: .center,
            children: [AppVersionInfo(version: "1.0.4+2", isProduction: true)],
          ),
        ),
      ),
    );
  }
}
