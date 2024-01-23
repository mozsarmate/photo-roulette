class Player {
  final String name;
  late int points;
  late String guess;
  late String avatar;

  Player(this.name, {this.guess = '', this.points = 0, this.avatar = ''});
}
