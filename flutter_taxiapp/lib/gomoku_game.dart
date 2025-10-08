import 'package:flutter/material.dart';

enum Player { x, o }

class BoardPosition {
  const BoardPosition(this.row, this.col);

  final int row;
  final int col;
}

class GomokuGame extends StatefulWidget {
  const GomokuGame({super.key});

  @override
  State<GomokuGame> createState() => _GomokuGameState();
}

class _GomokuGameState extends State<GomokuGame> {
  static const int _boardSize = 15;

  late List<List<Player?>> _board;
  late bool _xTurn;
  Player? _winner;
  bool _isDraw = false;
  BoardPosition? _lastMove;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    _board = List<List<Player?>>.generate(
      _boardSize,
      (_) => List<Player?>.filled(_boardSize, null, growable: false),
      growable: false,
    );
    _xTurn = true;
    _winner = null;
    _isDraw = false;
    _lastMove = null;
  }

  void _resetGame() {
    setState(_initializeBoard);
  }

  void _handleTap(int row, int col) {
    if (_winner != null || _isDraw || _board[row][col] != null) {
      return;
    }

    final currentPlayer = _xTurn ? Player.x : Player.o;

    setState(() {
      _board[row][col] = currentPlayer;
      _lastMove = BoardPosition(row, col);

      if (_hasPlayerWon(row, col, currentPlayer)) {
        _winner = currentPlayer;
      } else if (_isBoardFull()) {
        _isDraw = true;
      } else {
        _xTurn = !_xTurn;
      }
    });
  }

  bool _isBoardFull() {
    for (final row in _board) {
      for (final cell in row) {
        if (cell == null) {
          return false;
        }
      }
    }
    return true;
  }

  bool _hasPlayerWon(int row, int col, Player player) {
    const directions = <(int, int)>[
      (0, 1),
      (1, 0),
      (1, 1),
      (1, -1),
    ];

    for (final (dRow, dCol) in directions) {
      final count = 1 +
          _countConsecutive(row, col, dRow, dCol, player) +
          _countConsecutive(row, col, -dRow, -dCol, player);
      if (count >= 5) {
        return true;
      }
    }
    return false;
  }

  int _countConsecutive(
    int row,
    int col,
    int dRow,
    int dCol,
    Player player,
  ) {
    int r = row + dRow;
    int c = col + dCol;
    int count = 0;

    while (_isInsideBoard(r, c) && _board[r][c] == player) {
      count += 1;
      r += dRow;
      c += dCol;
    }

    return count;
  }

  bool _isInsideBoard(int row, int col) {
    return row >= 0 &&
        row < _boardSize &&
        col >= 0 &&
        col < _boardSize;
  }

  String get _statusMessage {
    if (_winner != null) {
      final playerLabel = _winner == Player.x ? 'X' : 'O';
      return 'Người chơi $playerLabel chiến thắng!';
    }
    if (_isDraw) {
      return 'Ván đấu hòa!';
    }
    final currentPlayerLabel = _xTurn ? 'X' : 'O';
    return 'Lượt của người chơi $currentPlayerLabel';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final boardSize = constraints.biggest.shortestSide;

        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _statusMessage,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: SizedBox(
                      width: boardSize,
                      height: boardSize,
                      child: _buildBoard(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _resetGame,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Ván mới'),
                      ),
                      if (_winner != null || _isDraw)
                        FilledButton.tonalIcon(
                          onPressed: _resetGame,
                          icon: const Icon(Icons.replay_circle_filled),
                          label: const Text('Chơi lại'),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Cách chơi: Hai người chơi lần lượt đánh dấu X và O trên bàn cờ. '
                    'Ai tạo được một chuỗi 5 quân liên tiếp theo hàng ngang, dọc hoặc chéo trước sẽ thắng.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBoard() {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _boardSize,
        ),
        itemCount: _boardSize * _boardSize,
        itemBuilder: (context, index) {
          final row = index ~/ _boardSize;
          final col = index % _boardSize;
          final player = _board[row][col];
          final isLastMove =
              _lastMove != null && _lastMove!.row == row && _lastMove!.col == col;

          return InkWell(
            onTap: () => _handleTap(row, col),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                color: isLastMove
                    ? Theme.of(context)
                        .colorScheme
                        .secondaryContainer
                        .withOpacity(0.6)
                    : Colors.transparent,
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 150),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: player == Player.x
                        ? Colors.indigo
                        : player == Player.o
                            ? Colors.deepOrange
                            : Colors.transparent,
                  ),
                  child: Text(
                    player == null
                        ? ''
                        : player == Player.x
                            ? 'X'
                            : 'O',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
