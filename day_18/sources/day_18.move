module day_18::main;

use std::vector;

const EInvalidPlotId: u64 = 0;
const EPlotAlreadyPlanted: u64 = 1;
const EPlotNotFound: u64 = 2;
const EMaxPlotsReached: u64 = 3;

public struct Farm has key {
    id: UID,
    planted_count: u64,
    plots: vector<u8>,
}

public fun create_farm(ctx: &mut TxContext): Farm {
    Farm {
        id: object::new(ctx),
        planted_count: 0,
        plots: vector::empty(),
    }
}

public fun plant_on_farm(farm: &mut Farm, plotId: u8) {
    assert!(plotId >= 1 && plotId <= 20, EInvalidPlotId);
    assert!(farm.planted_count < 20, EMaxPlotsReached);
    assert!(!vector::contains(&farm.plots, &plotId), EPlotAlreadyPlanted);

    vector::push_back(&mut farm.plots, plotId);
    farm.planted_count = farm.planted_count + 1;
}

public fun harvest_from_farm(farm: &mut Farm, plotId: u8) {
    assert!(vector::contains(&farm.plots, &plotId), EPlotNotFound);

    let (found, index) = vector::index_of(&farm.plots, &plotId);
    assert!(found, EPlotNotFound);

    vector::remove(&mut farm.plots, index);
    farm.planted_count = farm.planted_count - 1;
}

entry fun create_farm_entry(ctx: &mut TxContext) {
    let farm = create_farm(ctx);
    transfer::share_object(farm);
}

entry fun plant_on_farm_entry(farm: &mut Farm, plotId: u8) {
    plant_on_farm(farm, plotId);
}

entry fun harvest_from_farm_entry(farm: &mut Farm, plotId: u8) {
    harvest_from_farm(farm, plotId);
}

#[test]
fun test_create_farm() {
    let mut ctx = tx_context::dummy();
    let farm = create_farm(&mut ctx);

    assert!(farm.planted_count == 0, 100);
    assert!(vector::length(&farm.plots) == 0, 101);

    let Farm { id, planted_count: _, plots: _ } = farm;
    object::delete(id);
}

#[test]
fun test_plant_on_farm() {
    let mut ctx = tx_context::dummy();
    let mut farm = create_farm(&mut ctx);

    plant_on_farm(&mut farm, 3);

    assert!(farm.planted_count == 1, 102);
    assert!(vector::contains(&farm.plots, &3), 103);

    let Farm { id, planted_count: _, plots: _ } = farm;
    object::delete(id);
}

#[test]
fun test_harvest_from_farm() {
    let mut ctx = tx_context::dummy();
    let mut farm = create_farm(&mut ctx);

    plant_on_farm(&mut farm, 5);
    harvest_from_farm(&mut farm, 5);

    assert!(farm.planted_count == 0, 104);
    assert!(!vector::contains(&farm.plots, &5), 105);

    let Farm { id, planted_count: _, plots: _ } = farm;
    object::delete(id);
}

#[test]
#[expected_failure(abort_code = EInvalidPlotId)]
fun test_invalid_plot_id_low() {
    let mut ctx = tx_context::dummy();
    let mut farm = create_farm(&mut ctx);
    plant_on_farm(&mut farm, 0);

    let Farm { id, planted_count: _, plots: _ } = farm;
    object::delete(id);
}

#[test]
#[expected_failure(abort_code = EInvalidPlotId)]
fun test_invalid_plot_id_high() {
    let mut ctx = tx_context::dummy();
    let mut farm = create_farm(&mut ctx);
    plant_on_farm(&mut farm, 21);

    let Farm { id, planted_count: _, plots: _ } = farm;
    object::delete(id);
}

#[test]
#[expected_failure(abort_code = EPlotAlreadyPlanted)]
fun test_duplicate_plot() {
    let mut ctx = tx_context::dummy();
    let mut farm = create_farm(&mut ctx);

    plant_on_farm(&mut farm, 7);
    plant_on_farm(&mut farm, 7);

    let Farm { id, planted_count: _, plots: _ } = farm;
    object::delete(id);
}

#[test]
#[expected_failure(abort_code = EPlotNotFound)]
fun test_harvest_missing_plot() {
    let mut ctx = tx_context::dummy();
    let mut farm = create_farm(&mut ctx);
    harvest_from_farm(&mut farm, 9);

    let Farm { id, planted_count: _, plots: _ } = farm;
    object::delete(id);
}

#[test]
#[expected_failure(abort_code = EMaxPlotsReached)]
fun test_max_plots_reached() {
    let mut ctx = tx_context::dummy();
    let mut farm = create_farm(&mut ctx);

    let mut i = 1;
    while (i <= 20) {
        plant_on_farm(&mut farm, i);
        i = i + 1;
    };

    plant_on_farm(&mut farm, 1);

    let Farm { id, planted_count: _, plots: _ } = farm;
    object::delete(id);
}