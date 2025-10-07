"""A Quiz Game with Jac's Object-Spatial Architecture"""

walker QuizGame {
    has score: int = 0;

    can start_quiz with entry {
        print(" Starting the quiz...");
    }

    def process_answer(answer: str) {
        if self.correct_answer == answer {
            print("Correct!");
            score += 1;
            visit [-->];  # move to the next question
        } else {
            print("Wrong! Final Score: " + str(score));
            disengage;   # stop the game
        }
    }
}

node question {
    has prompt: str = "";
    has correct_answer: str = "";

    can ask with QuizGame entry {
        print(self.prompt);
        # read user input from stdin and pass it to the QuizGame walker
        ans = input();
        entry.process_answer(ans);
    }
}

# Build the quiz graph
with entry {
    q1 = spawn question;
    q1.prompt = "What is 2 + 2?";
    q1.correct_answer = "4";

    q2 = spawn question;
    q2.prompt = "What is the capital of France?";
    q2.correct_answer = "Paris";

    q3 = spawn question;
    q3.prompt = "Which planet is known as the Red Planet?";
    q3.correct_answer = "Mars";

    # Link them in a chain
    q1 ++> q2;
    q2 ++> q3;

    # Start the quiz (spawn the walker on q1 so the node receives the walker as entry)
    q1 spawn QuizGame;
}
