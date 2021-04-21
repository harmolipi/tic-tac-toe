# Tic Tac Toe
Created as part of [The Odin Project](https://www.theodinproject.com) curriculum.

View on [Github](https://github.com/harmolipi/tic-tac-toe)

### Functionality

This is the [Tic Tac Toe](https://www.theodinproject.com/courses/ruby-programming/lessons/tic-tac-toe) project, which simply lets you play a game of tic tac toe with another person.

It's also been updated with some rspec tests as part of the [Testing Your Ruby Code](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/testing-your-ruby-code) project.

### Thoughts

This project was a good exercise in writing simple logic in Ruby, and learning to use objects.

The trickiest part was finding an elegant way to measure win conditions. It seemed uncouth to simply take an array of every possible combination of winning positions, and check the board against it every time a move was made. Fortunately, I realized that associating the board with a coordinate system (an array of arrays) allowed me to simply check to see if any three past moves had either the same X or Y (X,Y) position. This still didn't cover the diagonals, however, and I was left having to explicitly define them and check for them every time. Still rather inelegant, but better than it could have been.

EDIT: I returned to this project to build some tests for it. Firstly, I realized that that was a great way to force myself to refactor it, as the tests were much easier to create if I first simplified each of my methods. Also, having progressed quite a bit further into my Ruby studies from when I created this Tic Tac Toe game, some things that were unecessarily long or convoluted jumped out at me, and it was simple to create more elegant solutions.

As far as the rspec testing goes, that was a good exercise too. Some things I wasn't able to figure out how exactly to test (like whether a loop has repeated as many times as I expect it to), but I was able to create some tests for the #player_input, #game_loop, #ending, and #game_over? methods. Jumping into rspec has been tricky but I think it's starting to make more sense now. TDD really does seem arduous, but I can see how it will be useful in the future, and how it will help me write better and more manageable code. So that's good!

If you want to run the tests, simply run `rspec spec/tic_tac_toe_spec.rb`

God bless.

-Niko Birbilis