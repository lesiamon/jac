"""A Number Guessing Game with Player Name"""
""""
import random;


class Game {
    def init(self: Game, attempts: int = 10) {
        self.attempts = attempts;
        self.won = False;
    }

    def play(self: Game) {
        raise NotImplementedError("Subclasses must implement this method.");
    }
}


class GuessTheNumberGame(Game) {
    def init(self: GuessTheNumberGame, attempts: int = 10) {
        super.init(attempts);
        self.correct_number = random.randint(1, 10);
        self.player_name = "";
    }

    def play(self: GuessTheNumberGame) {
        # Ask for player name once
        name = input("Enter your name: ");
        self.player_name = name;
        print(f"Welcome, {self.player_name}! Let's play Guess the Number.");

        while self.attempts > 0 {
            guess = input("Guess a number between 1 and 10: ");
            if guess.isdigit() {
                self.process_guess(int(guess));
                if self.won {
                    break;
                }
            } else {
                print("That's not a valid number! Try again.");
            }
        }
        if not self.won {
            print(f"Sorry {self.player_name}, you didn't guess the number. Better luck next time!");
        }
    }

    def process_guess(self: GuessTheNumberGame, guess: int) {
        if guess > self.correct_number {
            print("Too high!");
        } elif guess < self.correct_number {
            print("Too low!");
        } else {
            print(f"Congratulations {self.player_name}! You guessed correctly.");
            self.won = True;
            return;
        }
        self.attempts -= 1;
        print(f"You have {self.attempts} attempts left.");
    }
}


with entry {
    game = GuessTheNumberGame();
    game.play();
}"""
#runs well no issue with it as addition 
"""with entry {
    a = int(input("Enter first number: ")) ;
    b = int(input("Enter second number: ")) ;
    sum = a + b;
    print("The sum is: " + str(sum));
}"""
// guess_game_basic.jac
use std;

obj Game {
    has secret_number: int;
    has attempts: int = 0;

    def start_game() {
        // Generate a random number between 1 and 100
        here.secret_number = std.rand(1, 100);
        std.out("I have chosen a number between 1 and 100. Can you guess it?");
    }

    def play_round(guess: int) -> str {
        here.attempts += 1;
        if guess < here.secret_number {
            return "Too low! Try again.";
        } else if guess > here.secret_number {
            return "Too high! Try again.";
        } else {
            return "Correct! You've guessed it in " + str(here.attempts) + " attempts.";
        }
    }
}

with entry {
    game = spawn obj::Game();
    game.start_game();
    
    // Simple game loop (this will later be replaced by a walker)
    while (true) {
        user_input = std.in("Enter your guess: ");
        guess = int(user_input);
        result = game.play_round(guess);
        std.out(result);
        
        if (result contains "Correct") {
            break;
        }
    }
}

