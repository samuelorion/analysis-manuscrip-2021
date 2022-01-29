close("*");
if (isOpen("Results")) {
         selectWindow("Results"); 
         run("Clear Results"); 
         run("Close");
}
				
input = "/Volumes/4TB/96WP/96WP_Data/C2/";
file_list = getFileList(input);
output = "/Users/samuelorion/Downloads/untitled folder/";
			
	for (j = 0; j < file_list.length; j++) {
			
		if (nImages<10){
			
			i = round(random()*file_list.length);
			
			if (matches(file_list[i], ".*HP_0.*")) {
			
			file = input  + file_list[i];
			run("Bio-Formats", "open=file autoscale color_mode=Default crop rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT x_coordinate_1=1000 y_coordinate_1=1000 width_1=2000 height_1=2000");		
			run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
			run("mpl-viridis");
			//run("Brightness/Contrast...");
			run("Enhance Contrast", "saturated=0.35");
			original = getTitle();
			
				
			
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


			run("Tile");
			waitForUser("hit OK");   
			close("*");	
				}
			} 
		}
	}


			
			
