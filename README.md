## General

This is a not very accurate port of the game [realtimebattle](http://realtimebattle.sourceforge.net/) which I is written in C++ and I couldn't compile on OSX.

The basic principle: you program little bots and then they fight each other in an arena. A bot is an executable than receives information via STDIN and sends back answers via STDOUT. For an example see the bos/stupid_bot.rb. Bots can be written in any programming language, not just Ruby.

## The GUI

  The GUI is implemented as a web application using Sinatra. 
  You can start the server from the root level of the project directory like this:
  
    $ ruby server/realtimebattleserver.rb
    
This loads an html page and some javascript that will update the arena a few times per second.