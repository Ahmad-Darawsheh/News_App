abstract class NewsStates{}

class NewsInitalState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class GetBusinessState extends NewsStates {}

class ErrorBusinessState extends NewsStates {
  late final String  error;

  ErrorBusinessState(this.error);

}

class NewsBusinessLoadingState extends NewsStates {}

class GetFinanceState extends NewsStates {}

class ErrorFinanceState extends NewsStates {
  late final String  error;

  ErrorFinanceState(this.error);

}

class NewsFinanceLoadingState extends NewsStates {}

class GetSearchState extends NewsStates {}

class ErrorSearchState extends NewsStates {
  late final String  error;

  ErrorSearchState(this.error);

}

class NewsSearchLoadingState extends NewsStates {}


