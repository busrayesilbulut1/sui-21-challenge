module day_04::day_04;


use std::string::String;
use std::vector;
public struct Habit has store {
    id: u64,
    name: String,
    completed: bool,
}
public struct HabitList has store {
    habits: vector<Habit>,
}
public fun empty_list(): HabitList {
    HabitList {
        habits: vector::empty<Habit>(),
    }
}
public fun add_habit(list: &mut HabitList, habit: Habit){
    vector::push_back(&mut list.habits, habit);
}
