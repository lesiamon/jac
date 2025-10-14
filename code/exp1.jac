node User {
    has username: str;
    has email: str;
    has created_at: str;
}

node Post {
    has title: str;
    has content: str;
    has likes: int = 0;
}

with entry {
    # This is where your program starts.
    # We will create the nodes in the graph here.
    user = root ++> User(
        username="alice",
        email="alice@example.com",
        created_at="2024-01-01"
    );

    post = user ++> Post(
        title="Hello Jac!",
        content="My first post in Jac"
    );

    print(f"User {user[0].username} created post: {post[0].title}");
}