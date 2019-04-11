import 'dart:typed_data';

// Implements https://github.com/gre/bezier-easing/blob/master/src/index.js
const int NewtonIterations = 4;
const double NewtonMinSlope = 0.001;
const double SubdivisionPrecision = 0.0000001;
const int SubdivisionMaxIterations = 10;

const int SplineTableSize = 11;
const double SampleStepSize = 1.0 / (SplineTableSize - 1.0);

// Returns x(t) given t, x1, and x2, or y(t) given t, y1, and y2.
double calcBezier(double aT, double aA1, double aA2) {
  return (((1.0 - 3.0 * aA2 + 3.0 * aA1) * aT + (3.0 * aA2 - 6.0 * aA1)) * aT +
          (3.0 * aA1)) *
      aT;
}

// Returns dx/dt given t, x1, and x2, or dy/dt given t, y1, and y2.
double getSlope(double aT, double aA1, double aA2) {
  return 3.0 * (1.0 - 3.0 * aA2 + 3.0 * aA1) * aT * aT +
      2.0 * (3.0 * aA2 - 6.0 * aA1) * aT +
      (3.0 * aA1);
}

double newtonRaphsonIterate(aX, aGuessT, mX1, mX2) {
  for (int i = 0; i < NewtonIterations; ++i) {
    double currentSlope = getSlope(aGuessT, mX1, mX2);
    if (currentSlope == 0.0) {
      return aGuessT;
    }
    double currentX = calcBezier(aGuessT, mX1, mX2) - aX;
    aGuessT -= currentX / currentSlope;
  }
  return aGuessT;
}

abstract class CubicEase {
  static CubicEase make(double x1, double y1, double x2, double y2) {
    if (x1 == y1 && x2 == y2) {
      return LinearCubicEase();
    } else {
      return Cubic(x1, y1, x2, y2);
    }
  }

  double ease(double t);
}

class LinearCubicEase extends CubicEase {
  @override
  double ease(double t) {
    return t;
  }
}

class Cubic extends CubicEase {
  Float64List _values;
  final double x1, y1, x2, y2;
  Cubic(this.x1, this.y1, this.x2, this.y2) {
    // Precompute values table
    _values = Float64List(SplineTableSize);
    for (int i = 0; i < SplineTableSize; ++i) {
      _values[i] = calcBezier(i * SampleStepSize, x1, x2);
    }
  }

  double getT(double x) {
    double intervalStart = 0.0;
    int currentSample = 1;
    int lastSample = SplineTableSize - 1;

    for (;
        currentSample != lastSample && _values[currentSample] <= x;
        ++currentSample) {
      intervalStart += SampleStepSize;
    }
    --currentSample;

    // Interpolate to provide an initial guess for t
    var dist = (x - _values[currentSample]) /
        (_values[currentSample + 1] - _values[currentSample]);
    var guessForT = intervalStart + dist * SampleStepSize;

    var initialSlope = getSlope(guessForT, x1, x2);
    if (initialSlope >= NewtonMinSlope) {
      for (int i = 0; i < NewtonIterations; ++i) {
        double currentSlope = getSlope(guessForT, x1, x2);
        if (currentSlope == 0.0) {
          return guessForT;
        }
        double currentX = calcBezier(guessForT, x1, x2) - x;
        guessForT -= currentX / currentSlope;
      }
      return guessForT;
    } else if (initialSlope == 0.0) {
      return guessForT;
    } else {
      double aB = intervalStart + SampleStepSize;
      double currentX, currentT;
      int i = 0;
      do {
        currentT = intervalStart + (aB - intervalStart) / 2.0;
        currentX = calcBezier(currentT, x1, x2) - x;
        if (currentX > 0.0) {
          aB = currentT;
        } else {
          intervalStart = currentT;
        }
      } while (currentX.abs() > SubdivisionPrecision &&
          ++i < SubdivisionMaxIterations);
      return currentT;
    }
  }

  double ease(double mix) {
    return calcBezier(getT(mix), y1, y2);
  }
}
