// @description Create dust cloud
// Create dust particle
if (startDust == 1) {
    instance_create_depth(x+random_range(-30,30),y+random_range(-30,30),depth-1,obj_dust);
    alarm[0] = 2;
}