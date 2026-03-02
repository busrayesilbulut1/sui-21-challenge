module 0x1::Day05 {
    use std::vector;

    #[allow(unused_field)]
    public struct Habit has store {
        name: vector<u8>,
        completed: bool,
    }

    public fun complete_habit(habits: &mut vector<Habit>, index: u64) {
        let len = vector::length(habits);

        if (index < len) {
            let habit_ref = vector::borrow_mut(habits, index);
            habit_ref.completed = true;
        } else {
            // index geçersizse hiçbir şey yapma
        }
    }
}