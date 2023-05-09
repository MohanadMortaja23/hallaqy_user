import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('سياسة الخصوصية'),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    '1 - التزاماً بمراعاة خصوصيتك',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: double.infinity,
                  child: Text(
                    'تلتزم نحن بحماية خصوصية عملائنا. وتنطبق سياسة حماية الخصوصية المعتمدة من قبل إي أف ("سياسة حماية الخصوصية") على كل المعلومات الشخصية التي يتم جمعها من قبلنا أو تقديمها لنا',
                    style: TextStyle(fontSize: 11.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: double.infinity,
                  child: Text(
                    '2-ما هي المعلومات الشخصية التي نجمعها؟',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: double.infinity,
                  child: Text(
                    'الاسم الشخصي و اسم المستخدم و  رقم الهاتف و الصورة الشخصية و الإقامة و  التفضيلات',
                    style: TextStyle(fontSize: 11.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: double.infinity,
                  child: Text(
                    'نقوم نحن ومقدمو الخدمات لدينا بجمع معلومات شخصية  من خلال استخدامكم للتطبيق: عند تنزيل أو استخدام أحد التطبيقات، يمكننا نحن ومقدّمو الخدمات لدينا أن نتتبّع ونجمع بيانات استخدام التطبيق، مثل وقت وتاريخ دخول التطبيق الموجود على جهازكم إلى خوادمنا والمعلومات والملفات التي تم تنزيلها على التطبيق بالاعتماد على رقم جهازكم.',
                    style: TextStyle(fontSize: 11.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: double.infinity,
                  child: Text(
                    '3- الامان',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: double.infinity,
                  child: Text(
                    'نحن نعتمد تدابير نظامية وفنية وإدارية معقولة من أجل حماية المعلومات الشخصية التي تكون في حوزتنا',
                    style: TextStyle(fontSize: 11.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: double.infinity,
                  child: Text(
                    '4- المعلومات الحساسة',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: double.infinity,
                  child: Text(
                    'نطلب منكم عادةً ألا ترسلوا أو تكشفوا لنا عن أي معلومات حساسة (مثال: المعلومات المرتبطة بالأصل الإثني أو العرقي، الآراء السياسية، المعتقدات الدينية أو غيرها، الحالة الصحية أو الطبية، الخلفية الجنائية أو العضوية النقابية) على أو عبر المواقع أو غير ذلك.',
                    style: TextStyle(fontSize: 11.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: double.infinity,
                  child: Text(
                    '5-  اتصلوا بنا',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: double.infinity,
                  child: Text(
                    'إذا كانت لديكم أي أسئلة بخصوص سياسة حماية الخصوصية، فتواصل معنا ',
                    style: TextStyle(fontSize: 11.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
