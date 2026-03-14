 module day_15::farm_simulator {
    use std::vector;

    const E_INVALID_PLOT_ID: u64 = 1;
    const E_PLOT_ALREADY_PLANTED: u64 = 2;
    const E_PLOT_NOT_FOUND: u64 = 3;
    const E_MAX_PLOTS_REACHED: u64 = 4;

    const MIN_PLOT_ID: u8 = 1;
    const MAX_PLOT_ID: u8 = 20;

    public struct FarmCounters has copy, drop, store {
        planted: u64,
        harvested: u64,
        plots: vector<u8>,
    }

    public fun new_counters(): FarmCounters {
        FarmCounters {
            planted: 0,
            harvested: 0,
            plots: vector::empty<u8>(),
        }
    }

    fun is_valid_plot_id(plot_id: u8): bool {
        plot_id >= MIN_PLOT_ID && plot_id <= MAX_PLOT_ID
    }

    fun contains_plot(plots: &vector<u8>, plot_id: u8): bool {
        let length = vector::length(plots);
        let mut i = 0;

        while (i < length) {
            if (*vector::borrow(plots, i) == plot_id) {
                return true
            };
            i = i + 1;
        };

        false
    }

    fun find_plot_index(plots: &vector<u8>, plot_id: u8): u64 {
        let length = vector::length(plots);
        let mut i = 0;

        while (i < length) {
            if (*vector::borrow(plots, i) == plot_id) {
                return i
            };
            i = i + 1;
        };

        abort E_PLOT_NOT_FOUND
    }

    public fun plant(counters: &mut FarmCounters, plot_id: u8) {
        assert!(is_valid_plot_id(plot_id), E_INVALID_PLOT_ID);
        assert!(vector::length(&counters.plots) < 20, E_MAX_PLOTS_REACHED);
        assert!(!contains_plot(&counters.plots, plot_id), E_PLOT_ALREADY_PLANTED);

        vector::push_back(&mut counters.plots, plot_id);
        counters.planted = counters.planted + 1;
    }

    public fun harvest(counters: &mut FarmCounters, plot_id: u8) {
        assert!(is_valid_plot_id(plot_id), E_INVALID_PLOT_ID);
        assert!(contains_plot(&counters.plots, plot_id), E_PLOT_NOT_FOUND);

        let index = find_plot_index(&counters.plots, plot_id);
        vector::remove(&mut counters.plots, index);
        counters.harvested = counters.harvested + 1;
    }

    #[test]
    fun test_new_counters() {
        let counters = new_counters();

        assert!(counters.planted == 0, 100);
        assert!(counters.harvested == 0, 101);
        assert!(vector::length(&counters.plots) == 0, 102);
    }

    #[test]
    fun test_plant() {
        let mut counters = new_counters();

        plant(&mut counters, 5);

        assert!(counters.planted == 1, 103);
        assert!(vector::length(&counters.plots) == 1, 104);
        assert!(*vector::borrow(&counters.plots, 0) == 5, 105);
    }

    #[test]
    fun test_harvest() {
        let mut counters = new_counters();

        plant(&mut counters, 7);
        harvest(&mut counters, 7);

        assert!(counters.planted == 1, 106);
        assert!(counters.harvested == 1, 107);
        assert!(vector::length(&counters.plots) == 0, 108);
    }
}
