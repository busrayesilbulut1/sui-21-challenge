module day_06::main {
    use std::vector;
    use sui::object::UID;

    // Habit struct
    public struct Habit has key, store {
        id: UID,
        name: vector<u8>,
        completed: bool,
    }

    // Yeni Habit yarat
    public fun new_habit(name: vector<u8>, id: UID): Habit {
        Habit {
            id,
            name,
            completed: false,
        }
    }

    // Helper: bytes -> Habit
    public fun make_habit(bytes: vector<u8>, id: UID): Habit {
        new_habit(bytes, id)
    }

    // Örnek kullaným
    public fun example(id: UID): Habit {
        let habit_bytes = b"Workout";
        make_habit(habit_bytes, id)
    }
}
