/// @function DealDamage(target, damage)
/// @description Deal damage on the mob seted if it can suffer damage
/// @param {obj} target Who gonna suffer the damage
/// @param {real} damage How much damage it'll take
/// //@returns {type} Description of the returned value (if any)

function DealDamage(target, damage){
	
	if(!instance_exists(target)) return;
	
	if(target.canDamage){
		target.hp -= damage;
	}
		
}