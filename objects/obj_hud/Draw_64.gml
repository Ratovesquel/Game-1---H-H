#region SKILL

// Skill 1
draw_sprite(spr_hudSkill, 1, 50, 670);
draw_sprite(spr_Hbasic_skillsIncos, 0, 50, 670);


if (instance_exists(follow)) {
    var max_frame = sprite_get_number(spr_hudSkillCooldown) - 1;
    var cd = clamp(follow.cooldown_skl1, 0, follow.cooldown_skl1MAX);
    var pct = 1 - (cd / follow.cooldown_skl1MAX);
    var frame = floor(pct * max_frame);

    draw_sprite(spr_hudSkillCooldown, frame, 50, 670);
}


// Skill 2
draw_sprite(spr_hudSkill, 1, 150, 670);
draw_sprite(spr_Hbasic_skillsIncos, 1, 150, 670);

if (instance_exists(follow)) {
    var max_frame = sprite_get_number(spr_hudSkillCooldown) - 1;
    var cd = clamp(follow.cooldown_skl2, 0, follow.cooldown_skl2MAX);
    var pct = 1 - (cd / follow.cooldown_skl2MAX);
    var frame = floor(pct * max_frame);

    draw_sprite(spr_hudSkillCooldown, frame, 150, 670);
}

#endregion

#region HEALTH

draw_sprite(spr_hudHealth, 0, 85, 45);
draw_sprite(spr_healthBackground, 0, 85, 45);
if(instance_exists(obj_Hbasic)) draw_sprite_stretched(spr_health, 0, 85, 45,(obj_Hbasic.hp/obj_Hbasic.hp_max) * 200, 24)


#endregion

#region ICONS

#endregion