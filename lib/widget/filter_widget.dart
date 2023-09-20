class Filter {
  final String name;
  Filter(this.name);
}

List<Filter> getFilterList() {
  return <Filter>[
    Filter("Classic"),
    Filter("Modern"),
    Filter("Comming"),
  ];
}
