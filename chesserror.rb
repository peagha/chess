class ChessError < StandardError; end
class EmptySquareError < ChessError; end
class IlegalMoveError < ChessError; end
