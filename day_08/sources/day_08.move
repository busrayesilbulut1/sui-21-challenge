module day_08::bounty_board {

    use std::string::String;

   public struct Task has store {
        title: String,
        reward: u64,
        done:bool
    }

    public fun new_task(title: String, reward: u64): Task {
        Task {
            title,
            reward,
            done:false
        }
    }
}
