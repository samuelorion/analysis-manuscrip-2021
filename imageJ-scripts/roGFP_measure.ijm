directory = "/Users/samuelorion/Desktop/R_roGFP/aligned/";

list = getFileList(directory);

//setBatchMode("hide");

for (i = 0; i < list.length; i++) {

	close("*");

	if (isOpen("Results")) {
	selectWindow("Results");
	run("Close" );
	}
	
	if (isOpen("ROI Manager")) {
	selectWindow("ROI Manager");
	run("Close");
	}
	
	run("ROI Manager...");
	
	
	
	file = directory + list[i];
	
	open(file);
	stack = getTitle(); 
	run("Duplicate...", "duplicate");
	z_stack = getTitle(); 
	run("Z Project...", "projection=[Max Intensity]");
	run("Duplicate...", " ");
	z_stack_gaussain = getTitle(); 
	run("Gaussian Blur...", "sigma=500");
	imageCalculator("Subtract", z_stack, z_stack_gaussain);
	selectWindow(z_stack_gaussain); run("Close");
	selectWindow(z_stack);
	
	run("Find Maxima...", "prominence=30 output=[Point Selection]");

	run("Create Mask");
	setOption("BlackBackground", true);
	run("Dilate");run("Dilate");
	run("Set Measurements...", "mean centroid display redirect=None decimal=1");
	run("Analyze Particles...", "add");

	selectWindow(stack);
	roiManager("Deselect");
	roiManager("multi-measure measure_all")

	saveAs("Results", "/Users/samuelorion/Downloads/output_roGFP/Results_" + i + ".csv");
	run("Clear Results"); run("Close");


}

