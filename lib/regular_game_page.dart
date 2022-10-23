import 'package:flutter/material.dart';
import 'package:tictactoe/main.dart';

class RegularGamePage extends StatefulWidget {
  const RegularGamePage({super.key});

  @override
  State<RegularGamePage> createState() => _RegularGamePageState();
}

class _RegularGamePageState extends State<RegularGamePage> {
  bool xTurn = true;

  List<String> xoxBoard = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tic Tac Toe"),
          backgroundColor: const Color.fromARGB(240, 0, 0, 0),
          centerTitle: true,
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.indigoAccent, Colors.greenAccent],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                scoreBoard(),
                gameGrid(),
                playerTurn(),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  )),
                  child: const Text("Back"),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            clearBoard();
            xScore = 0;
            oScore = 0;
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }

  Widget scoreBoard() {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const Text("Player X",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text(xScore.toString(),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const Text("Player O",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text(oScore.toString(),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ],
          ),
        ),
      ],
    ));
  }

  Widget gameGrid() {
    return Expanded(
      flex: 3,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        itemCount: 9,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => tapped(index),
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Center(
                child: Text(
                  xoxBoard[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void tapped(int index) {
    setState(() {
      if (xTurn && xoxBoard[index] == '') {
        xoxBoard[index] = 'X';
        filledBoxes += 1;
      } else if (!xTurn && xoxBoard[index] == '') {
        xoxBoard[index] = 'O';
        filledBoxes += 1;
      }
      xTurn = !xTurn;
      checkTheWinner();
    });
  }

  Widget playerTurn() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Center(
        child: Text(xTurn ? "Turn of X" : "Turn of O",
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
    );
  }

  clearBoard() {
    setState(() {
      for (var i = 0; i < 9; i++) {
        xoxBoard[i] = "";
      }
      filledBoxes = 0;
    });
  }

  void checkTheWinner() {
    // rows
    // row 1
    if (xoxBoard[0] == xoxBoard[1] &&
        xoxBoard[0] == xoxBoard[2] &&
        xoxBoard[0] != "") {
      resultDailog("Winner", xoxBoard[0]);
      return;
    }
    // row 2
    if (xoxBoard[3] == xoxBoard[4] &&
        xoxBoard[3] == xoxBoard[5] &&
        xoxBoard[3] != "") {
      resultDailog("Winner", xoxBoard[3]);
      return;
    }
    // row 3
    if (xoxBoard[6] == xoxBoard[7] &&
        xoxBoard[6] == xoxBoard[8] &&
        xoxBoard[6] != "") {
      resultDailog("Winner", xoxBoard[6]);
      return;
    }
    // columns
    // column 1
    if (xoxBoard[0] == xoxBoard[3] &&
        xoxBoard[0] == xoxBoard[6] &&
        xoxBoard[0] != "") {
      resultDailog("Winner", xoxBoard[0]);
      return;
    }
    // column 2
    if (xoxBoard[1] == xoxBoard[4] &&
        xoxBoard[1] == xoxBoard[7] &&
        xoxBoard[1] != "") {
      resultDailog("Winner", xoxBoard[1]);
      return;
    }
    // column 1
    if (xoxBoard[2] == xoxBoard[5] &&
        xoxBoard[2] == xoxBoard[8] &&
        xoxBoard[2] != "") {
      resultDailog("Winner", xoxBoard[2]);
      return;
    }
    // Diagonals
    // Diagonal 1
    if (xoxBoard[0] == xoxBoard[4] &&
        xoxBoard[0] == xoxBoard[8] &&
        xoxBoard[0] != "") {
      resultDailog("Winner", xoxBoard[0]);
      return;
    }
    // Diagonal 2
    if (xoxBoard[2] == xoxBoard[4] &&
        xoxBoard[2] == xoxBoard[6] &&
        xoxBoard[2] != "") {
      resultDailog("Winner", xoxBoard[2]);
      return;
    }
    if (filledBoxes == 9) {
      resultDailog("No Result", "");
    }
  }

  void resultDailog(String result, String winner) {
    showDialog(
      context: context,
      builder: ((BuildContext context) {
        return AlertDialog(
          title: Text(
              winner != "" ? "Congratulations! Player $winner " : "Match Tied"),
          content: Text(winner != "" ? "You got a point" : "Play again "),
          actions: [
            TextButton(
              onPressed: () {
                clearBoard();
                Navigator.of(context).pop();
              },
              child: const Text("New Game"),
            )
          ],
        );
      }),
    );
    if (winner == "X") {
      xScore += 1;
    } else if (winner == "O") {
      oScore += 1;
    }
  }
}
