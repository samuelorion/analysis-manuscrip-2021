close("*");
if (isOpen("Summary")) {
         selectWindow("Summary"); 
         run("Clear Results"); 
         run("Close");
}
				
input = "/Volumes/4TB/96WP/96WP_Data/C2/";
file_list = getFileList(input);
output = "/Users/samuelorion/Documents-MACBOOK/GitHub/2020_Manuscript/R/DATA-OUT/96WP/trace/";
			
	for (j = 0; j < file_list.length; j++) {
			
		if (nImages<10){
			
			i = round(random()*file_list.length);
			
			if (matches(file_list[i], ".*HP_0.*")) {
			if (matches(file_list[i], ".*XII_HP.*")) {
			
			xstart = random()*7000;
			ystart = random()*7000;
			
			file = input  + file_list[i];
			run("Bio-Formats", "open=file autoscale color_mode=Default crop rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT x_coordinate_1=xstart y_coordinate_1=ystart width_1=4000 height_1=4000");		
			run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
			run("mpl-viridis");
			//run("Brightness/Contrast...");
			run("Enhance Contrast", "saturated=0.35");
			original = getTitle();
			
			//count visually 
			title = "number";
			width=512; height=512;
			Dialog.create("visible neurons");
			Dialog.addString("Neurons:", title);
			Dialog.show();
			neurons = Dialog.getString();	
			
			run("Duplicate...", " ");	
			gaussian = getTitle();	
			run("Gaussian Blur...", "sigma=20");	
			imageCalculator("Subtract", original, gaussian);
			selectWindow(gaussian); run("Close"); 
			selectWindow(original);
			setMinAndMax(0, 1000);		
			
			//trace
			selectWindow(original);
			run("Duplicate...", " ");
			run("Gaussian Blur...", "sigma=2");
			run("Subtract...", "value=50");
			run("Duplicate...", " ");
			
			setThreshold(5, 65535);
			setOption("BlackBackground", true);
			run("Convert to Mask");
			run("Despeckle");
			run("Despeckle");
			run("Despeckle");
			run("Dilate");
			run("Skeletonize");
			
			image_name = replace(file_list[i],".tif","");
			image_name = neurons + "_" + image_name;
			rename(image_name);
			run("Tile"); 
			
			// dialog for good tracing 
			Dialog.create("Save?");
			Dialog.addCheckbox("Good tracing?", true);
			Dialog.show();
			
			response = Dialog.getCheckbox();
			
			//if accept tracing - save results  
			if (response == 1){
				
				run("Set Measurements...", "area redirect=None decimal=1");
				run("Analyze Particles...", "size=2-Infinity summarize");
				//saveAs("Results", output + image_name + "_sep_trace.csv"); run("Clear Results"); run("Close");
				
				close("*");
				}
			
			//if do not accept tracing - close image and go to next
			if (response == 0){ 
				
				close("*");
				
				}}
			} 
		}
	}

//run("Tile");
			
			
