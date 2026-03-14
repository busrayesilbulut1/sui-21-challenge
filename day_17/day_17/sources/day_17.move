module day_17::farm_simulator {
    use sui::object;
    use sui::object::UID;
    use sui::transfer;
    use sui::tx_context::TxContext;

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

    public struct Farm has key {
        id: UID,
        counters: FarmCounters,
    }

    public fun new_counters(): FarmCounters {
        FarmCounters {
            planted: 0,
            harvested: 0,
            plots: vector::empty<u8>(),
        }
    }

    public fun new_farm(ctx: &mut TxContext): Farm {
        Farm {
            id: object::new(ctx),
            counters: new_counters(),
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

    public fun plant_on_farm(farm: &mut Farm, plot_id: u8) {
        plant(&mut farm.counters, plot_id);
    }

    public fun harvest_from_farm(farm: &mut Farm, plot_id: u8) {
        harvest(&mut farm.counters, plot_id);
    }

    entry fun create_farm(ctx: &mut TxContext) {
        let farm = new_farm(ctx);
        transfer::share_object(farm);
    }

    #[test]
    fun test_new_counters() {
        let counters = new_counters();

        assert!(counters.planted == 0, 100);
        assert!(counters.harvested == 0, 101);
        assert!(vector::length(&counters.plots) == 0, 102);
    }

    #[test]
    fun test_plant_on_farm() {
        let mut farm = Farm {
            id: object::new(&mut tx_context::dummy()),
            counters: new_counters(),
        };

        plant_on_farm(&mut farm, 5);

        assert!(farm.counters.planted == 1, 103);
        assert!(vector::length(&farm.counters.plots) == 1, 104);
        assert!(*vector::borrow(&farm.counters.plots, 0) == 5, 105);

        let Farm { id, counters: _ } = farm;
        id.delete();
    }

    #[test]
    fun test_harvest_from_farm() {
        let mut farm = Farm {
            id: object::new(&mut tx_context::dummy()),
            counters: new_counters(),
        };

        plant_on_farm(&mut farm, 7);
        harvest_from_farm(&mut farm, 7);

        assert!(farm.counters.planted == 1, 106);
        assert!(farm.counters.harvested == 1, 107);
        assert!(vector::length(&farm.counters.plots) == 0, 108);

        let Farm { id, counters: _ } = farm;
        id.delete();
    }
}
