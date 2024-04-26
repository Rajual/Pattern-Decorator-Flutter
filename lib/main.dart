import 'package:flutter/material.dart';

// Definimos una interfaz para nuestros decoradores de animación.
abstract class AnimationDecorator {
  Widget decorate(Widget widget);
}

// Implementamos un decorador de animación para la rotación.
class RotationAnimationDecorator extends AnimationDecorator {
  @override
  Widget decorate(Widget widget) {
    // Usamos TweenAnimationBuilder para crear una animación de rotación.
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
          begin: 0,
          end: 2 * 3.141592653589793), // De 0 a 2pi (una vuelta completa)
      duration: const Duration(seconds: 4), // Duración de la animación
      builder: (BuildContext context, double angle, Widget? child) {
        // Transform.rotate aplica una rotación al widget.
        return Transform.rotate(angle: angle, child: widget);
      },
    );
  }
}

// Implementamos un decorador de animación para el escalado.
class ScaleAnimationDecorator extends AnimationDecorator {
  @override
  Widget decorate(Widget widget) {
    // Usamos TweenAnimationBuilder para crear una animación de escalado.
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.1, end: 10.0), // De 0.1 a 10.0
      duration: const Duration(seconds: 4), // Duración de la animación
      builder: (BuildContext context, double scale, Widget? child) {
        // Transform.scale aplica un escalado al widget.
        return Transform.scale(scale: scale, child: widget);
      },
    );
  }
}

// Implementamos un decorador de animación para el desplazamiento.
class SlideAnimationDecorator extends AnimationDecorator {
  @override
  Widget decorate(Widget widget) {
    // Usamos TweenAnimationBuilder para crear una animación de desplazamiento.
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(
          begin: Offset(-5, 0), end: Offset(5, 0)), // De -5 a 5 en el eje x
      duration: const Duration(seconds: 2), // Duración de la animación
      builder: (BuildContext context, Offset offset, Widget? child) {
        // FractionalTranslation aplica un desplazamiento al widget.
        return FractionalTranslation(translation: offset, child: widget);
      },
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Este es el widget al que se le aplicarán las animaciones.
  Widget child = FlutterLogo();

  // Esta es la lista de decoradores de animación disponibles.
  List<AnimationDecorator> decorators = [
    RotationAnimationDecorator(),
    ScaleAnimationDecorator(),
    SlideAnimationDecorator(),
  ];

  // Este método aplica una animación al widget.
  void addAnimation(int index) {
    if (index < decorators.length) {
      setState(() {
        child = decorators[index].decorate(child);
      });
    }
  }

  // Este método restablece el widget a su estado original.
  void resetAnimations() {
    setState(() {
      child = FlutterLogo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: child),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildAnimationButton(
                0, Icons.rotate_right, 'Add rotation animation'),
            SizedBox(height: 10),
            _buildAnimationButton(1, Icons.zoom_out_map, 'Add scale animation'),
            SizedBox(height: 10),
            _buildAnimationButton(2, Icons.slideshow, 'Add slide animation'),
            SizedBox(height: 10),
            _buildResetButton(),
          ],
        ),
      ),
    );
  }

  // Este método construye un botón para agregar una animación.
  Widget _buildAnimationButton(int index, IconData icon, String tooltip) {
    return FloatingActionButton(
      onPressed: () => addAnimation(index),
      child: Icon(icon),
      tooltip: tooltip,
    );
  }

  // Este método construye un botón para restablecer las animaciones.
  Widget _buildResetButton() {
    return FloatingActionButton(
      onPressed: resetAnimations,
      child: Icon(Icons.refresh),
      tooltip: 'Reset animations',
    );
  }
}
