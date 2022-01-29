
setBatchMode("hide");

close("*");


input_directory = "/Users/samuelorion/Documents/GitHub/2020_Manuscript/DERIVED-DATA/VARICOSITIES/OPENED-DATA/";
output_directory = "/Users/samuelorion/Documents/GitHub/2020_Manuscript/R/DATA-OUT/VARICOSITIES_SEGMENTED_VARICOSITIES/"
File.makeDirectory(output_directory);
output_directory_segmented_images = "/Users/samuelorion/Documents/GitHub/2020_Manuscript/DERIVED-DATA/VARICOSITIES/SEGMENTED-IMAGES/";
File.makeDirectory(output_directory_segmented_images);
data_out_csv = "/Users/samuelorion/Documents/GitHub/2020_Manuscript/R/DATA-OUT/VARICOSITIES_SEGMENTED_VARICOSITIES/";
File.makeDirectory(data_out_csv);

open_csv_filename = "/Users/samuelorion/Documents/GitHub/2020_Manuscript/DERIVED-DATA/VARICOSITIES/name_of_images.csv";
to_split_image_name_csv = File.openAsString(open_csv_filename);
image_name_csv = split(to_split_image_name_csv, "\n");
image_name_csv_length = lengthOf(image_name_csv);
image_names_array = newArray(image_name_csv_length);

for (n=0; n<image_name_csv_length; n++){
image_names_array[n] = image_name_csv[n];
}


for(i = 0; i < image_names_array.length; i++) { 

//for (i = 0; i < 37; i+=6) {

	close("*");
	image = input_directory + "C2-MAX_" + image_names_array[i] + ".tif";	
	run("Bio-Formats", "open=image autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
	run("mpl-viridis");
	run("Enhance Contrast", "saturated=0.35");
	original_axon = getTitle();
	run("Duplicate...", " ");
	gaussian = getTitle();
	run("Gaussian Blur...", "sigma=10");
	run("Add...", "value=40");
	run("Median...", "radius=2");
	imageCalculator("Subtract create", original_axon, gaussian);
	setOption("ScaleConversions", true);
	raw_sub_gaussian = getTitle();
	selectWindow(gaussian); run("Close");
	selectWindow(raw_sub_gaussian);	
	setAutoThreshold("Li dark no-reset");
	setOption("BlackBackground", false);	
	run("Convert to Mask");	
	run("Despeckle");	
	// to delete probably run("Watershed");	
	rename(image_names_array[i]+"_mask_varicosities");	
	mask_vars = getTitle(); 
	run("Duplicate...", " ");
	mask_vars_2 = getTitle(); 
	image = input_directory + "C1-MAX_" + image_names_array[i] + ".tif";	
	run("Bio-Formats", "open=image autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");	
	run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");	
	run("mpl-viridis");	
	run("Enhance Contrast", "saturated=0.35");	
	original_syt1_MAX = getTitle();

	if (isOpen("Results")) {
	selectWindow("Results");
	run("Close" );
	}
	if (isOpen("ROI Manager")) {
	selectWindow("ROI Manager");
	run("Close");
	}
	
	run("Set Measurements...", "area mean centroid shape feret's integrated redirect=None decimal=1"); 
	selectWindow(mask_vars_2); 
	run("Analyze Particles...", "add");	
	selectWindow(original_syt1_MAX);
	roiManager("multi-measure measure_all");
	roiManager("Delete");
	Table.deleteColumn("FeretX");
	Table.deleteColumn("FeretY");
	Table.deleteColumn("FeretAngle");
	saveAs("Results", data_out_csv + "_sep_" + image_names_array[i] + "_sep_varicosities.csv");
	run("Clear Results"); run("Close");

}

