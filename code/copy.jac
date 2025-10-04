import std;

obj Game {
    has secret_number: int;
    has attempts: int = 0;

    def start_game() {
        #Generate a random number between 1 and 100
        self.secret_number = std.rand(1, 100);
        std.out("I have chosen a number between 1 and 100. Can you guess it?");
    }

    def play_round(guess: int) -> str {
        self.attempts += 1;
        if guess < self.secret_number {
            print("Too low! Try again.");
        } elif guess > self.secret_number {
            print("Too high! Try again.");
        } else {
            print("Correct! You've guessed it in " + std.str(self.attempts) + " attempts.");
        }
    }
}

with entry {
    game = new Game;
    game.start_game();
    
    #Simple game loop (this will later be replaced by a walker)
    while (true) {
        user_input = std.in("Enter your guess: ");
        guess = int(user_input);
        result = game.play_round(guess);
        std.out(result);
        
        if result.index_of("Correct") != -1 {
            break;
        }
    }
}

