// @description Dust variables with random variation
// Dust variables
// Larger, slower dust clouds
image_xscale = random_range(1.0,1.5);
image_yscale = image_xscale;
rotSpeed = random_range(0.2,1);
fadeSpeed = random_range(0.02,0.04);
driftSpeed = random_range(0.5,2);

// OR - Many tiny, fast dust puffs
image_xscale = random_range(0.4,0.7);
image_yscale = image_xscale;
rotSpeed = random_range(1,3);
fadeSpeed = random_range(0.04,0.08);
driftSpeed = random_range(2,8);