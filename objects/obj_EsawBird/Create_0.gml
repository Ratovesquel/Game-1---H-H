target = noone;
hitbox_spawned = false;
hitbox_timer = 0;
hitbox_timer_max = Seconds(2);


function FindTarget(_selfTeam, _range, _object) {
    var nearest = noone;
    var bestDist = _range;

    with (_object) {
        if (team != _selfTeam && canDamage) {
            var d = point_distance(x, y, other.x, other.y);

            if (d < bestDist) {
                if (!collision_line(other.x, other.y, x, y, obj_wall, false, true)) {
                    bestDist = d;
                    nearest = id;
                }
            }
        }
    }

    return nearest;
}
