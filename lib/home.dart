import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const String player_X = "X";
  static const String player_O = "O";
  late String currentPlayer;
  late bool gameEnd;
  late List<String> occupied;
  @override
  void initState() {
    initializeGame();
    super.initState();
  }

  void initializeGame() {
    currentPlayer = player_X;
    gameEnd = false;
    occupied = ["", "", "", "", "", "", "", "", ""];
  }

  changeTurn() {
    if (currentPlayer == player_X) {
      currentPlayer = player_O;
    } else {
      currentPlayer = player_X;
    }
  }

  checkForWinner() {
    List<List<int>> winningList = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    for (var winnerPos in winningList) {
      String playerPosition0 = occupied[winnerPos[0]];
      String playerPosition1 = occupied[winnerPos[1]];
      String playerPosition2 = occupied[winnerPos[2]];
      if (playerPosition0.isNotEmpty) {
        if (playerPosition0 == playerPosition1 &&
            playerPosition0 == playerPosition2) {
          showGameOverMassage("Player $playerPosition0 Won");
          gameEnd = true;
          return;
        }
      }
    }
  }

  showGameOverMassage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.cyan,
        content: Text(
          "Game over \n $msg",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  checkForDraw() {
    if (gameEnd) {
      return;
    }
    bool draw = true;
    for (var occupiedPlayer in occupied) {
      if (occupiedPlayer.isEmpty) {
        draw = false;
      }
    }
    if (draw) {
      showGameOverMassage("Draw");
      gameEnd = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 199, 207, 239),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 15,
              ),
              child: Container(
                height: 60,
                width: 250,
                margin: const EdgeInsets.only(
                  top: 16,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: Colors.cyan,
                ),
                child: const Center(
                  child: Text(
                    "Tic Tac Toe",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "Player $currentPlayer turn",
              style: const TextStyle(
                fontSize: 30,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.height / 2,
              margin: const EdgeInsets.all(8),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: 9,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (gameEnd || occupied[index].isNotEmpty) {
                        return;
                      }
                      setState(() {
                        occupied[index] = currentPlayer;
                        changeTurn();
                        checkForWinner();
                        checkForDraw();
                      });
                    },
                    child: Container(
                      color: occupied[index].isEmpty
                          ? Colors.black45
                          : occupied[index] == player_X
                              ? Colors.amber
                              : Colors.blue.shade700,
                      margin: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          occupied[index],
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  initializeGame();
                });
              },
              child: Container(
                height: 60,
                width: 250,
                margin: const EdgeInsets.only(
                  top: 16,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: Colors.cyan,
                ),
                child: const Center(
                  child: Text(
                    "Restart Game",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
