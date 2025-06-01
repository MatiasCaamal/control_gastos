import 'package:control_gastos/pages/longin.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Controla tus gastos fácilmente",
      "description":
          "Registra y clasifica todos tus gastos diarios en un solo lugar.",
      "animation": "assets/animations/bills.json",
    },
    {
      "title": "Visualiza tus reportes",
      "description":
          "Obtén gráficos y resúmenes para entender mejor tus finanzas.",
      "animation": "assets/animations/reports.json",
    },
    {
      "title": "Modelo Freemium",
      "description":
          "Accede a funciones básicas gratis y mejora con la versión premium.",
      "animation": "assets/animations/premium.json",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  onboardingData[index]["animation"]!,
                                  height: 250,
                                  repeat: true,
                                ),
                                SizedBox(height: 40),
                                Text(
                                  onboardingData[index]["title"]!,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  onboardingData[index]["description"]!,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[700]),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            // Indicadores
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(onboardingData.length, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 6, vertical: 20),
                  height: 10,
                  width: _currentIndex == index ? 24 : 10,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              }),
            ),

            // Botón Siguiente / Empezar
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (_currentIndex < onboardingData.length - 1) {
                    _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                },
                child: Text(
                  _currentIndex == onboardingData.length - 1
                      ? 'Empezar'
                      : 'Siguiente',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
