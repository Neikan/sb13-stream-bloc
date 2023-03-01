abstract class BlocCartEvent {}

class BlocCartEventInit extends BlocCartEvent {}

class BlocCartEventAdd extends BlocCartEvent {
  final String cardId;

  BlocCartEventAdd(this.cardId);
}

class BlocCartEventRemove extends BlocCartEvent {
  final String cardId;

  BlocCartEventRemove(this.cardId);
}
