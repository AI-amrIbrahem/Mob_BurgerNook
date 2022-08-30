

extension NonNullString on String? {
  String orNull() {
    if (this == null) {
      return '';
    } else {
      return this!;
    }
  }
}

extension NonNullInt on int? {
  int orNull() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}

extension NonNullDouble on double? {
  double orNull() {
    if (this == null) {
      return 0.0;
    } else {
      return this!;
    }
  }
}

extension NonNullBool on bool? {
  bool orNull() {
    if (this == null) {
      return false;
    } else {
      return this!;
    }
  }
}



