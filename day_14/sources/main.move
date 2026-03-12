module day_14::bounty_board {

    use std::vector;

    public struct Board has copy, drop, store {
        tasks: vector<u64>,
    }

    public fun create_board(): Board {
        Board { tasks: vector::empty<u64>() }
    }

    public fun add_task(board: &mut Board, reward: u64) {
        vector::push_back(&mut board.tasks, reward);
    }

    public fun task_count(board: &Board): u64 {
        vector::length(&board.tasks)
    }

    public fun complete_task(board: &mut Board, index: u64) {
        vector::remove(&mut board.tasks, index);
    }

    public fun total_reward(board: &Board): u64 {
        let mut sum = 0;
        let mut i = 0;
        let len = vector::length(&board.tasks);

        while (i < len) {
            sum = sum + *vector::borrow(&board.tasks, i);
            i = i + 1;
        };

        sum
    }

    #[test]
    fun test_create_board_and_add_task() {
        let mut board = create_board();

        add_task(&mut board, 100);
        add_task(&mut board, 200);

        let count = task_count(&board);

        assert!(count == 2, 0);
    }

    #[test]
    fun test_complete_task() {
        let mut board = create_board();

        add_task(&mut board, 100);
        add_task(&mut board, 200);

        complete_task(&mut board, 0);

        let count = task_count(&board);

        assert!(count == 1, 1);
    }

    #[test]
    fun test_total_reward() {
        let mut board = create_board();

        add_task(&mut board, 100);
        add_task(&mut board, 200);
        add_task(&mut board, 300);

        let total = total_reward(&board);

        assert!(total == 600, 2);
    }
}