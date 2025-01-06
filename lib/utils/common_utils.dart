const double defaultPadding = 16.0;
const double defaultRadius = 12.0;

const Duration defaultDuration = Duration(milliseconds: 200);

bool isValEmpty(dynamic val) {
  String? value = val.toString();
  return (val == null || value.isEmpty || value == "null" || value == "" || value == "NULL");
}
