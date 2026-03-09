module day_11::main {

    use std::vector;
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;

    public struct Task has copy, drop, store {
        id: u64,
        description: vector<u8>,
        completed: bool
    }

    public struct TaskBoard has key, store {
        id: UID,
        owner: address,
        tasks: vector<Task>
    }

    public fun new_board(owner: address, ctx: &mut TxContext): TaskBoard {
        TaskBoard {
            id: object::new(ctx),
            owner,
            tasks: vector::empty<Task>()
        }
    }

    public fun add_task(board: &mut TaskBoard, task: Task) {
        vector::push_back(&mut board.tasks, task);
    }
}