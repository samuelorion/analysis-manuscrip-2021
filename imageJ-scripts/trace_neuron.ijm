close("*");
setBatchMode("hide");
input = "/Volumes/4TB/96WP/96WP_Data/C2/";
output = "/Users/samuelorion/Documents/GitHub/2020_Manuscript/R/DATA-OUT/96WP/TRACE_NEURON/";
File.makeDirectory(output);
images_to_open = getFileList(input); 


for (i = 533; i < images_to_open.length; i++){



// TEST AREA LOOP 
// loop for testing
//for (j = 0; j < 4; j++){
// random number for opening for testing
//u = random(); u = round(images_to_open.length*u); 
//i = u; 
// TEST AREA END

 	
	file = input + "/" + images_to_open[i];
	t = getTime();
	image_name = replace(images_to_open[i],".tif","");
	
	print(image_name);  
	print(i); 
	//run("Bio-Formats", "open=file autoscale color_mode=Default crop rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT x_coordinate_1=5000 y_coordinate_1=5000 width_1=3000 height_1=3000");
	open(file);
	
	run("mpl-viridis");
	run("Enhance Contrast", "saturated=0.35");
	run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
	original = getTitle();	
	run("Duplicate...", " ");	
	gaussian = getTitle();	
	run("Gaussian Blur...", "sigma=20");	
	imageCalculator("Subtract", original, gaussian);
	selectWindow(gaussian); run("Close"); 
	selectWindow(original);
	run("Subtract...", "value=100");	
	setOption("ScaleConversions", true);	
	setMinAndMax(0, 100);	
	//run("Duplicate...", " ");
	setAutoThreshold("Otsu dark");
	//run("Threshold...");
	setThreshold(377, 65535);
	setOption("BlackBackground", true);
	run("Convert to Mask");
	run("Despeckle"); 
	run("Dilate");	
	run("Despeckle");
	run("Dilate");
	run("Skeletonize");
	run("Set Measurements...", "area redirect=None decimal=1");
	run("Analyze Particles...", "size=2-Infinity summarize");
	saveAs("Results", output + image_name + "_sep_trace_neuron.csv"); run("Clear Results"); run("Close");
	close("*");
	t2 = getTime();
	time_taken = (t2-t)/1000;
	print(time_taken + " seconds");
		
}


	


