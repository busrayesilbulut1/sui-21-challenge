module day_12::task_board {

    use sui::object::UID;

    public struct Task has copy, drop, store {
        title: vector<u8>,
    }

    public struct Board has key {
        id: UID,
        tasks: vector<Task>,
    }

    public fun find_task_by_title(board: &Board, title: vector<u8>): Option<u64> {
        let mut i = 0;
        let len = vector::length(&board.tasks);

        while (i < len) {
            let task = vector::borrow(&board.tasks, i);

            if (task.title == title) {
                return option::some(i)
            };

            i = i + 1;
        };

        option::none()
    }
}