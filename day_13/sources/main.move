module day_13::main {

    use std::vector;
    use sui::object::UID;

    public struct Task has copy, drop, store {
        reward: u64,
        completed: bool,
    }

    public struct TaskBoard has key {
        id: UID,
        tasks: vector<Task>,
    }

    public fun total_reward(board: &TaskBoard): u64 {
        let mut i = 0;
        let mut total = 0;

        while (i < vector::length(&board.tasks)) {
            let task = vector::borrow(&board.tasks, i);
            total = total + task.reward;
            i = i + 1;
        };

        total
    }

    public fun completed_count(board: &TaskBoard): u64 {
        let mut i = 0;
        let mut count = 0;

        while (i < vector::length(&board.tasks)) {
            let task = vector::borrow(&board.tasks, i);

            if (task.completed) {
                count = count + 1;
            };

            i = i + 1;
        };

        count
    }
}