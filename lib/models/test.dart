class UngVien {
  String name;
  int salary;
  UngVien({
    required this.name,
    required this.salary,
  });

  static List<UngVien> list = [
    UngVien(name: 'kien', salary: 100),
    UngVien(name: 'lok', salary: 400),
    UngVien(name: 'long', salary: 500),
    UngVien(name: 'khanh', salary: 120),
    UngVien(name: 'khoa', salary: 600),
  ];

  static int countUngVien() {
    int sum = 1000;
    int count = 0;
    list.sort((a, b) => a.salary - b.salary);
    for (var ungVien in list) {
      if (sum > ungVien.salary) {
        count++;
        sum = sum - ungVien.salary;
        print(ungVien.toString());
      }
    }
    return count;
  }

  @override
  String toString() => 'UngVien(name: $name, salary: $salary)';
}

void main(List<String> args) {
  print(UngVien.countUngVien());
}
