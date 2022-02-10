class I18nMessages {
  final Map<String, String> messages;
  I18nMessages(this.messages);

  String get(String key) {
    assert(messages.containsKey(key));
    return messages[key] ?? '????????';
  }

  @override
  String toString() {
    int entries = messages.entries.length - 1;
    int entry = -1;
    String string = messages.entries.fold('I18nMessages: {', (
      previousValue,
      element,
    ) {
      entry++;
      return '$previousValue "${element.key}": "${element.value}" ${entry == entries ? "}" : ""}';
    });
    return string;
  }
}
