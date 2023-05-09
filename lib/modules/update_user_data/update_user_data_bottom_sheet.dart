import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

var formState = GlobalKey<FormState>();

void bottomSheetUpdateUserData(
    {required BuildContext context, required HallaqCubit cubit}) {
  TextEditingController emailController = TextEditingController();

  TextEditingController fullNameController =
      TextEditingController(text: "${cubit.profilemodel!.data!.name}");

  TextEditingController phoneController =
      TextEditingController(text: '${cubit.profilemodel!.data!.phone}');
  showBarModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (context) => Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'تعديل البيانات',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    bottom: 35,
                  ),
                  child: Form(
                    key: formState,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: fullNameController,
                          cursorColor: indigo,
                          keyboardType: TextInputType.text,
                          validator: (dynamic value) {
                            if (value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'الاسم بالكامل',
                            prefixIcon: Icon(IconBroken.User),
                            enabledBorder: enabledBorder,
                            focusedBorder: focusedBorder,
                            errorBorder: enabledBorder,
                            focusedErrorBorder: focusedBorder,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: phoneController,
                          cursorColor: indigo,
                          keyboardType: TextInputType.phone,
                          maxLength: 11,
                          validator: (dynamic value) {
                            if (value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'الهاتف',
                            prefixIcon: Icon(IconBroken.Call),
                            enabledBorder: enabledBorder,
                            focusedBorder: focusedBorder,
                            errorBorder: enabledBorder,
                            focusedErrorBorder: focusedBorder,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        gradientButton(
                          context: context,
                          title: Text(
                            'تحديث',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            if (formState.currentState!.validate()) {
                              cubit.InfoData2(
                                  name: fullNameController.text,
                                  phone: phoneController.text);
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
