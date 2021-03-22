# Tic Tac Toe
Created as part of [The Odin Project](https://www.theodinproject.com) curriculum.

View on [Github](https://github.com/harmolipi/tic_tac_toe)

### Functionality

This is the [Tic Tac Toe](https://www.theodinproject.com/courses/ruby-programming/lessons/tic-tac-toe) project, which simply lets you play a game of tic tac toe with another person.

### Thoughts

This project was a good exercise in writing simple logic in Ruby, and learning to use objects.

The trickiest part was finding an elegant way to measure win conditions. It seemed uncouth to simply take an array of every possible combination of winning positions, and check the board against it every time a move was made. Fortunately, I realized that associating the board with a coordinate system (an array of arrays) allowed me to simply check to see if any three past moves had either the same X or Y (X,Y) position. This still didn't cover the diagonals, however, and I was left having to explicitly define them and check for them every time. Still rather inelegant, but better than it could have been.

God bless.

-Niko Birbilis