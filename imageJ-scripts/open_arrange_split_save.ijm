// open, re-arrange, split 
setBatchMode("hide");
t = getTime(); 
input = "/Volumes/4TB/Sam/96WP_DATA/data/ALL_PLATES/F";
output = "/Volumes/4TB/Sam/96WP_DATA/data/ALL_PLATES/96_wellplate_data";
images_to_open = getFileList(input); 

for (i = 0; i < images_to_open.length; i++){
	
	
	print(images_to_open[i]);
	image = input + "/" + images_to_open[i];
	run("Bio-Formats", "open=image autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");	
	run("Stack to Hyperstack...", "order=xyczt(default) channels=3 slices=1 frames=1 display=Grayscale");
	run("Split Channels");
	
		for (j=0;j<nImages;j++) {
	        selectImage(j+1);
	        title = getTitle;
	        saveAs("tiff", output + "/" + title);
		}
		
	close("*");	
}
t2 = getTime();
	time_taken = (t2-t)/60000;
	print(time_taken + " minutes");

// run("Stack to Hyperstack...", "order=xyczt(default) channels=3 slices=1 frames=1 display=Grayscale");
// run("Arrange Channels...", "new=132");


t = getTime(); 
input = "/Volumes/4TB/Sam/96WP_DATA/data/ALL_PLATES/G";
output = "/Volumes/4TB/Sam/96WP_DATA/data/ALL_PLATES/96_wellplate_data";
images_to_open = getFileList(input); 

for (i = 0; i < images_to_open.length; i++){
	
	
	print(images_to_open[i]);
	image = input + "/" + images_to_open[i];
	run("Bio-Formats", "open=image autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");	
	run("Stack to Hyperstack...", "order=xyczt(default) channels=3 slices=1 frames=1 display=Grayscale");
	run("Split Channels");
	
		for (j=0;j<nImages;j++) {
	        selectImage(j+1);
	        title = getTitle;
	        saveAs("tiff", output + "/" + title);
		}
		
	close("*");	
}
t2 = getTime();
	time_taken = (t2-t)/60000;
	print(time_taken + " minutes");