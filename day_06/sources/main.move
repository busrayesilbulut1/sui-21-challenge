module day_06::main {
    use std::string::{Self, String};
    use std::signer;
    use std::vector;

    struct TxContext has store {}

    struct UID has store {
        id: u64,
    }

    public struct Habit has key, store {
        id: UID,
        name: String,
        completed: bool,
    }

    public fun new_habit(name: String, ctx: &mut TxContext): Habit {
        Habit {
            id: UID { id: 0 },
            name,
            completed: false,
        }
    }

    public fun make_habit(bytes: vector<u8>, ctx: &mut TxContext): Habit {
        let name_string = string::utf8(bytes);
        new_habit(name_string, ctx)
    }

    public fun example(ctx: &mut TxContext): Habit {
        let habit_bytes = b"Workout";
        make_habit(habit_bytes, ctx)
    }
}