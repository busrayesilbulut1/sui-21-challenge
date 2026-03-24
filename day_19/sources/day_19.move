module day_19::farm {

    use sui::object::UID;

    public struct Farm has key {
        id: UID,
        planted_count: u64,
        harvested_count: u64,
    }

    public fun total_planted(farm: &Farm): u64 {
        farm.planted_count
    }

    public fun total_harvested(farm: &Farm): u64 {
        farm.harvested_count
    }
}