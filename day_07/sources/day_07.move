module day_07::habit_tracker;

use std::vector;

public struct Habit has copy, drop {
    name: vector<u8>,
    completed: bool,

}

public fun create_habit(name: vector<u8>): Habit {
    Habit {
        name,
        completed:false,
    }

}
public fun complete_habit(habit: &mut Habit) {
    habit.completed = true;
}
#[test]
fun test_create_habit() {
    let habit = create_habit(b"Read Book");

    assert!(habit.completed == false);
}

#[test]
fun test_complete_habit() {
    let mut habit = create_habit(b"workout");

    complete_habit(&mut habit);

    assert!(habit.completed == true);
}



