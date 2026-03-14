module day_16::farm_simulator {
    use sui::test_scenario;
    use sui::object;
    use sui::object::UID;
    use sui::tx_context::TxContext;

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

    #[test]
    fun test_new_counters() {
        let counters = new_counters();

        assert!(counters.planted == 0, 100);
        assert!(counters.harvested == 0, 101);
        assert!(vector::length(&counters.plots) == 0, 102);
    }

    #[test]
    fun test_new_farm() {
        let mut scenario = test_scenario::begin(@0xA);
        let farm = new_farm(scenario.ctx());

        assert!(farm.counters.planted == 0, 103);
        assert!(farm.counters.harvested == 0, 104);
        assert!(vector::length(&farm.counters.plots) == 0, 105);

        let Farm { id, counters: _ } = farm;
        id.delete();

        test_scenario::end(scenario);
    }
}
