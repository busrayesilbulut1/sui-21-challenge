module day_20::farm {

    use sui::object::UID;
    use sui::tx_context::TxContext;
    use sui::transfer;
    use sui::event;

    const E_INVALID_PLOT: u64 = 0;
    const E_DUPLICATE_PLOT: u64 = 1;
    const E_MAX_PLOTS: u64 = 2;
    const E_PLOT_NOT_FOUND: u64 = 3;

    public struct Farm has key {
        id: UID,
        planted_count: u64,
        harvested_count: u64,
        planted_plots: vector<u8>,
    }

    public struct PlantEvent has copy, drop {
        planted_after: u64,
    }

    public entry fun create_farm(ctx: &mut TxContext) {
        let farm = Farm {
            id: object::new(ctx),
            planted_count: 0,
            harvested_count: 0,
            planted_plots: vector::empty<u8>(),
        };

        transfer::share_object(farm);
    }

    public fun plant_on_farm(farm: &mut Farm, plotId: u8) {

        assert!(plotId >= 1 && plotId <= 20, E_INVALID_PLOT);

        let len = vector::length(&farm.planted_plots);
        assert!(len < 20, E_MAX_PLOTS);

        let mut i = 0;
        while (i < len) {
            let existing = *vector::borrow(&farm.planted_plots, i);
            assert!(existing != plotId, E_DUPLICATE_PLOT);
            i = i + 1;
        };

        vector::push_back(&mut farm.planted_plots, plotId);
        farm.planted_count = farm.planted_count + 1;
    }

    public entry fun plant_on_farm_entry(farm: &mut Farm, plotId: u8) {

        plant_on_farm(farm, plotId);

        let planted_count = total_planted(farm);

        event::emit(PlantEvent {
            planted_after: planted_count
        });
    }

    public fun harvest_from_farm(farm: &mut Farm, plotId: u8) {

        let len = vector::length(&farm.planted_plots);

        let mut i = 0;
        let mut found = false;

        while (i < len) {
            let existing = *vector::borrow(&farm.planted_plots, i);
            if (existing == plotId) {
                vector::remove(&mut farm.planted_plots, i);
                found = true;
                break;
            };
            i = i + 1;
        };

        assert!(found, E_PLOT_NOT_FOUND);

        farm.harvested_count = farm.harvested_count + 1;
    }

    public fun total_planted(farm: &Farm): u64 {
        farm.planted_count
    }

    public fun total_harvested(farm: &Farm): u64 {
        farm.harvested_count
    }
}
