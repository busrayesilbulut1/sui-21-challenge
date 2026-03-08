module day_10::main {

    use sui::object::UID;
    use sui::object;
    use sui::tx_context::TxContext;

    public enum TaskStatus has copy, drop, store {
        Open,
        Completed
    }

    public struct Task has key, store {
        id: UID,
        description: vector<u8>,
        status: TaskStatus
    }

    public fun create_task(ctx: &mut TxContext, description: vector<u8>): Task {
        Task {
            id: object::new(ctx),
            description,
            status: TaskStatus::Open
        }
    }

    public fun complete_task(task: &mut Task) {
        mark_completed(task);
    }

    fun mark_completed(task: &mut Task) {
        task.status = TaskStatus::Completed;
    }
}