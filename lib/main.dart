// Flutter هي إطار عمل لتطوير تطبيقات الجوال والويب والسطح المكتب
// يمكنك تعلم المزيد عن Flutter من هنا 

// يجب علينا استيراد حزمة Flutter المطلوبة لإنشاء واجهة المستخدم
import 'package:flutter/material.dart';

// هذه هي الدالة الرئيسية التي تبدأ التنفيذ
void main() {
  // نستخدم هذه الدالة لتشغيل التطبيق
  runApp(MyApp());
}

// هذا هو الفئة التي تمثل التطبيق بأكمله
class MyApp extends StatelessWidget {
  // هذه الدالة تقوم بإنشاء واجهة المستخدم للتطبيق
  @override
  Widget build(BuildContext context) {
    // نستخدم هذا العنصر لتوفير مظهر عام للتطبيق
    return MaterialApp(
      // نحدد عنوان التطبيق
      title: 'آلة حاسبة بسيطة',
      // نحدد الصفحة الرئيسية للتطبيق
      home: CalculatorPage(),
    );
  }
}

// هذا هو الفئة التي تمثل الصفحة التي تحتوي على آلة حاسبة
class CalculatorPage extends StatefulWidget {
  // هذه الدالة تقوم بإنشاء حالة لهذه الصفحة
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

// هذا هو الفئة التي تحتوي على حالة ومنطق آلة حاسبة
class _CalculatorPageState extends State<CalculatorPage> {
  // نحدد بعض المتغيرات لتخزين قيم آلة حاسبة
  String input = '0'; // يحتوي على المدخلات من المستخدم
  String output = '0'; // يحتوي على النتائج من العمليات
  String operator = ''; // يحتوي على العامل المحدد من المستخدم
  double num1 = 0.0; // يحتوي على الرقم الأول من المستخدم
  double num2 = 0.0; // يحتوي على الرقم الثاني من المستخدم

  // هذه الدالة تقوم بإجراء عملية حسابية بناءً على المشغل والأرقام
  void calculate() {
    // نحول المدخلات إلى رقم ثنائي
    num2 = double.parse(input);

    // نستخدم جملة switch لتنفيذ عملية مختلفة بناءً على المشغل
    switch (operator) {
      case '+': // إذا كان المشغل هو +
        output = (num1 + num2).toString(); // نضيف الرقمين ونحولها إلى سلسلة
        break;
      case '-': // إذا كان المشغل هو -
        output = (num1 - num2).toString(); // نطرح الرقم الثاني من الأول ونحولها إلى سلسلة
        break;
      case '×': // إذا كان المشغل هو ×
        output = (num1 * num2).toString(); // نضرب الرقمين ونحولها إلى سلسلة
        break;
      case '÷': // إذا كان المشغل هو ÷
        if (num2 == 0) { // نتحقق من عدم قسمة الرقم على صفر
          output = 'Error'; // نعرض رسالة خطأ
        } else {
          output = (num1 / num2).toString(); // نقسم الرقم الأول على الثاني ونحولها إلى سلسلة
        }
        break;
      default: // إذا لم يكن المشغل معروفًا
        output = 'Error'; // نعرض رسالة خطأ
    }

    // نحدد المشغل إلى فارغ
    operator = '';

    // نحدد المدخلات إلى الناتج
    input = output;
  }

  // هذه الدالة تقوم بالتعامل مع ضغطة زر من المستخدم
  void onPress(String buttonText) {
    // نستخدم جملة if للتحقق من نوع الزر المضغوط
    if (buttonText == 'C') { // إذا كان الزر هو C
      // نقوم بإعادة تعيين جميع المتغيرات إلى قيمها الافتراضية
      input = '0';
      output = '0';
      operator = '';
      num1 = 0.0;
      num2 = 0.0;
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '×' ||
        buttonText == '÷') { // إذا كان الزر هو عامل حسابي
      // نحول المدخلات إلى رقم ثنائي ونخزنه في الرقم الأول
      num1 = double.parse(input);

      // نحدد المشغل إلى الزر المضغوط
      operator = buttonText;

      // نحدد المدخلات إلى فارغة
      input = '';
    } else if (buttonText == '=') { // إذا كان الزر هو =
      // نستدعي دالة calculate لإجراء العملية الحسابية
      calculate();
    } else { // إذا كان الزر هو رقم أو نقطة عشرية
      // نتحقق من عدم وجود أكثر من نقطة عشرية في المدخلات
      if (buttonText == '.' && input.contains('.')) return;

      // نتحقق من عدم وجود صفر في بداية المدخلات
      if (input == '0' && buttonText != '.') input = '';

      // نضيف الزر المضغوط إلى المدخلات
      input += buttonText;
    }

    // نستخدم هذه الدالة لإعادة بناء واجهة المستخدم مع التغييرات الجديدة
    setState(() {});
  }

  // هذه الدالة تقوم بإنشاء زر آلة حاسبة مع خصائص معينة
  Widget calculatorButton(String text, Color color, Color textColor) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () => onPress(text), // نستخدم دالة onPress عند ضغط الزر
          child: Text(
            text, // نعرض النص المحدد للزر
            style: TextStyle(
              fontSize: 28.0, // نحدد حجم الخط للزر
              color: textColor, // نحدد لون الخط للزر
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color, // نحدد لون خلفية الزر
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0), // نحدد شكل حافة الزر
            ),
          ),
        ),
      ),    
    );
  }

  // هذه الدالة تقوم بإنشاء واجهة المستخدم للصفحة
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // نستخدم هذا العنصر لتوفير شريط علوي للصفحة
      appBar: AppBar(
        // نحدد عنوان الشريط العلوي
        title: Text('آلة حاسبة بسيطة'),
        // نحدد لون خلفية الشريط العلوي
        backgroundColor: Colors.blueGrey,
      ),
      // نستخدم هذا العنصر لتوفير محتوى للصفحة
      body: Container(
        // نستخدم هذا العنصر لترتيب العناصر بشكل عمودي
        child: Column(
          children: [
            // نستخدم هذا العنصر لإظهار المدخلات من المستخدم
            Container(
              alignment: Alignment.centerRight, // نحدد محاذاة النص إلى اليمين
              padding: EdgeInsets.symmetric(
                vertical: 24.0, // نحدد التباعد العمودي
                horizontal: 12.0, // نحدد التباعد الأفقي
              ),
              child: Text(
                input, // نعرض المدخلات من المستخدم
                style: TextStyle(
                  fontSize: 48.0, // نحدد حجم الخط
                  color: Colors.blueGrey, // نحدد لون الخط
                ),
              ),
            ),
            // نستخدم هذا العنصر لإظهار النتائج من العمليات
            Container(
              alignment: Alignment.centerRight, // نحدد محاذاة النص إلى اليمين
              padding: EdgeInsets.symmetric(
                vertical: 24.0, // نحدد التباعد العمودي
                horizontal: 12.0, // نحدد التباعد الأفقي
              ),
              child: Text(
                output, // نعرض النتائج من العمليات
                style: TextStyle(
                  fontSize: 48.0, // نحدد حجم الخط
                  color: Colors.blueGrey, // نحدد لون الخط
                ),
              ),
            ),
            // نستخدم هذا العنصر لإضافة خط فاصل بين المساحات
            Expanded(
              child: Divider(),
            ),
            // نستخدم هذا العنصر لترتيب أزرار آلة حاسبة بشكل شبكي
            Column(
              children: [
                Row( // هذه هي صف أول من أزرار آلة حاسبة
                  children: [
                    calculatorButton('C', Colors.redAccent,
                        Colors.white), // زر C باللون الأحمر والخط بالأبيض
                    calculatorButton('÷', Colors.blueAccent,
                        Colors.white), // زر ÷ باللون الأزرق والخط بالأبيض
                    calculatorButton('×', Colors.blueAccent,
                        Colors.white), // زر × باللون الأزرق والخط بالأبيض
                    calculatorButton('-', Colors.blueAccent,
                        Colors.white), // زر - باللون الأزرق والخط بالأبيض
                  ],
                ),
                Row( // هذه هي صف ثاني من أزرار آلة حاسبة
                  children: [
                    calculatorButton('7', Colors.grey,
                        Colors.black), // زر 7 باللون الرمادي والخط بالأسود
                    calculatorButton('8', Colors.grey,
                        Colors.black), // زر 8 باللون الرمادي والخط بالأسود
                    calculatorButton('9', Colors.grey,
                        Colors.black), // زر 9 باللون الرمادي والخط بالأسود
                    calculatorButton('+', Colors.blueAccent,
                        Colors.white), // زر + باللون الأزرق والخط بالأبيض
                  ],
                ),
                Row( // هذه هي صف ثالث من أزرار آلة حاسبة
                  children: [
                    calculatorButton('4', Colors.grey,
                        Colors.black), // زر 4 باللون الرمادي والخط بالأسود
                    calculatorButton('5', Colors.grey,
                        Colors.black), // زر 5 باللون الرمادي والخط بالأسود
                    calculatorButton('6', Colors.grey,
                        Colors.black), // زر 6 باللون الرمادي والخط بالأسود
                    calculatorButton('=', Colors.greenAccent,
                        Colors.white), // زر = باللون الأخضر والخط بالأبيض
                  ],
                ),
                Row( // هذه هي صف رابع من أزرار آلة حاسبة
                  children: [
                    calculatorButton('1', Colors.grey,
                        Colors.black), // زر 1 باللون الرمادي والخط بالأسود
                    calculatorButton('2', Colors.grey,
                        Colors.black), // زر 2 باللون الرمادي والخط بالأسود
                    calculatorButton('3', Colors.grey,
                        Colors.black), // زر 3 باللون الرمادي والخط بالأسود
                    calculatorButton('.', Colors.blueAccent,
                        Colors.white), // زر . باللون الأزرق والخط بالأبيض
                  ],
                ),
                Row( // هذه هي صف خامس من أزرار آلة حاسبة
                  children: [
                    calculatorButton('0', Colors.grey,
                        Colors.black), // زر 0 باللون الرمادي والخط بالأسود
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}