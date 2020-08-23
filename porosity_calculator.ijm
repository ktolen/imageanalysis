//This macro is intended to measure pore size of a cryo-EM image of hydrogel
run("Clear Results");
img = getTitle();
run("Set Measurements...", "area perimeter shape feret's stack limit display redirect=None decimal=3");
//Calibrating length-pixel scale
setTool("line");
waitForUser("Draw a line on the scale bar");
run("Set Scale...");
//determining the smallest pore by user (make this interactive, ask whether user wants to define smallest pore size)
//setTool("ellipse");
//waitForUser("Select the smallest pore");
//run("Measure");
//minPore = Table.get("Area", 0);
run("Select None");
//cropping region of interest
selectImage(img);
run("Duplicate...", "title=convolved");
setTool("rectangle");
waitForUser("Crop region of interest");
run("Crop");
//applying filters for pore detection
run("Convolve...", "text1=[-1 -1 -1 -1 -1\n-1 -1 -1 -1 -1\n-1 -1 24 -1 -1\n-1 -1 -1 -1 -1\n-1 -1 -1 -1 -1\n] normalize");
run("Duplicate...", "title=binary");
//creating a binary image
setAutoThreshold("Otsu dark");
setOption("BlackBackground", true);
run("Convert to Mask");
setThreshold(255, 255);
//preparing the binary image to mask for measurement
setAutoThreshold("Otsu");
setOption("BlackBackground", true);
run("Convert to Mask");
setThreshold(255, 255);
run("Watershed");
run("Duplicate...", "title=mask");
//minSize = minPore+(-5);
run("Analyze Particles...", "size=0-Infinity show=Masks display exclude clear include summarize");
//create a saving directory and files to keep
//make the macro for batch processing