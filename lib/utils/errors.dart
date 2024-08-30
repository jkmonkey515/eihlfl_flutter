/// A few custom errors defined by the project

class TradeError implements Exception {
  TradeErrorType type;
  TradeError(this.type);
}

enum TradeErrorType {
  tooManyTrades, //Must not trade more than 3 players
  notEnoughPositions, //Must be 1 netminder, 6 defensemen, 12 forwards
  notEnoughBritish, //Must be at least 5 British players
  tooManyFromATeam, //Must not be more than 3 players from a team
  tradeNotFound, //The trade was not found
  noCurrentTeam, //There is no current team
  tradeUnlinkedFromUser //The user has not linked their account (often username was erased from cache)
}

class AuthenticationError implements Exception {
  AuthenticationErrorType type;
  AuthenticationError(this.type);
}

enum AuthenticationErrorType {
  userNotFound,
  wrongPasswordOrUsername,
  internalError,
}
