/// @function DealDamage(target);
/// @description Activate curse on the puppet seted and increase the curse
/// @param {obj} target Who gonna suffer the damage
/// //@returns {type} Description of the returned value (if any)

function ActivateCurse(target){
	if(!instance_exists(target)) return;
	else{
		target.curse++;
		target.hp -= target.curse;		
	}


}