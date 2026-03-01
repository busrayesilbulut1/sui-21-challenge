module day_03::main {
 
 public struct Habit has copy, drop {
    name: vector<u8>,
    completed: bool,
}

public fun new_habit(name: vector<u8>): Habit {
    Habit {
        name,
        completed: false,
    }
 }
}