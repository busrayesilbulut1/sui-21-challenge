module challenge::day_02 {
    public fun sum(a: u64, b: u64): u64 {
        a+b
    }
    #[test_only]
    use std::unit_test::assert_eq;

    #[test]
    fun test_sum()  {
        assert_eq!(sum(1 , 2), 3);
    }
}