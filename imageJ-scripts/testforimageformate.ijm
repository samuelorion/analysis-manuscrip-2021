close("*");
//setBatchMode("hide");
//input = "/Volumes/4TB/96WP/96WP_Data/C3";
input = "/Volumes/4TB/96WP/2020_020_outoffocus/"

images_to_open = getFileList(input); 

//for (i = 0; i < images_to_open.length; i++){
for (i = 0; i < images_to_open.length; i+=5){

	t = getTime();
	print(images_to_open[i]); 
	print(i); 
	file = input + "/" + images_to_open[i];
	run("Bio-Formats", "open=file autoscale color_mode=Default crop rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT x_coordinate_1=1000 y_coordinate_1=400 width_1=400 height_1=1000");
	
	
// for looking at images 
	
	run("mpl-viridis");
	run("Enhance Contrast", "saturated=0.35");
	//close("*");

	t2 = getTime();
	time_taken = (t2-t)/1000;

	print(time_taken + " seconds");
}
