module day_09::bounty_board {

    use std::string::String;
    
    public enum TaskStatus has copy, drop, store {
        Open,
        Completed
    }

    public struct Task has store {
        title: String,
        reward: u64,
        status:TaskStatus
    }

    public fun new_task(title: String, reward: u64): Task {
        Task {
            title,
            reward,
            status: TaskStatus::Open
        }
    }

    public fun is_open(task: &Task): bool {
        task.status == TaskStatus::Open
    }
}

