from __future__ import annotations
from jaclang.lib import (
    Edge,
    Node,
    OPath,
    Root,
    Walker,
    build_edge,
    connect,
    on_entry,
    refs,
    root,
    spawn,
    visit,
)


class Person(Node):
    name: str

    @on_entry
    def announce(self, visitor: FriendFinder) -> None:
        print(f"{visitor} is checking me out")


class Friend(Edge):
    pass


class Family(Edge):

    @on_entry
    def announce(self, visitor: FriendFinder) -> None:
        print(f"{visitor} is traveling to family member")


# Build the graph
p1 = Person(name="John")
p2 = Person(name="Susan")
p3 = Person(name="Mike")
p4 = Person(name="Alice")
connect(left=root(), right=p1)
connect(left=p1, right=p2, edge=Friend)
connect(left=p2, right=[p1, p3], edge=Family)
connect(left=p2, right=p3, edge=Friend)


class FriendFinder(Walker):
    started: bool = False

    @on_entry
    def report_friend(self, here: Person) -> None:
        if self.started:
            print(f"{here.name} is a friend of friend, or family")
        else:
            self.started = True
            visit(self, refs(OPath(here).edge_out().visit()))
        visit(
            self,
            refs(
                OPath(here).edge_out(edge=lambda i: isinstance(i, Family)).edge().visit()
            ),
        )

    @on_entry
    def move_to_person(self, here: Root) -> None:
        visit(self, refs(OPath(here).edge_out().visit()))


result = spawn(FriendFinder(), root())
print(result)