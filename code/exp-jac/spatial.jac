node Library {
    has location: str;
    can search_shelves with borrower entry;
}

node Shelf {
    has category: str;
    can check_books with borrower entry;
}

node Book {
    has title: str;
    has available: bool;
}

walker borrower {
    has book_needed: str;
    can find_book with `root entry;
}

with entry {
    # Building the world is just linking nodes
    lib1 = root ++> Library("Central Library");
    lib2 = root ++> Library("Community Library");

    shelf1 = lib1 ++> Shelf("Fiction");
    shelf2 = lib1 ++> Shelf("Non-Fiction");
    shelf3 = lib2 ++> Shelf("Science");

    book1 = shelf1 ++> Book("1984", True);
    book2 = shelf1 ++> Book("Brave New World", False);
    book3 = shelf2 ++> Book("Sapiens", True);
    book4 = shelf3 ++> Book("A Brief History of Time", False);
    book5 = shelf3 ++> Book("The Selfish Gene", True);

    # Send Borrower walking
    borrower("1984") spawn root;
}

impl Library.search_shelves {
    visit [-->(`?Shelf)]; # No loops, just visit
}

impl Shelf.check_books {
    found_book = [self -->(`?Book)](
        ?title == visitor.book_needed, available == True
    );

    if (found_book) {
        print(f"Borrowed: {found_book}");
        print(f"From Shelf: {self.category}");
        disengage; # Stop traversal cleanly
    } else {
        print("Book not available in shelf", self.category);
    }
}

impl borrower.find_book {
    visit [-->(`?Library)];
}