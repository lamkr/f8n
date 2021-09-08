extension ListExtension on List
{
  int get hashCodeFromItems {
    var hashCode = 0;
    for(var e in this) {
      hashCode ^= e.hashCode;
    }
    return hashCode;
  }
}
