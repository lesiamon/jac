"""A Number Guessing Game"""

walker GuessGame {
    has guess: int;

    can start with entry {
        # Start node
        spawn here ++> turn;
    }

    can process_guess with turn entry {
        # Placeholder for guess checking
        # Example: compare self.guess with turn.correct_number
        report("Your guess: " + str(self.guess));
        report("Correct number was: " + str(here.correct_number));
    }
}

node turn {
    has correct_number: int;

    can init {
        import random   # ✅ import inside a block
        self.correct_number = random.randint(1, 10);
    }
}

with entry:__main__ {
    root spawn GuessGame(3);
    root spawn GuessGame(4);
}
