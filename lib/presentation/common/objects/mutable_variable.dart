class MutableVariable<T> {
  T value;

  MutableVariable(this.value);

  void setValue(T value) {
    this.value = value;
  }
}
