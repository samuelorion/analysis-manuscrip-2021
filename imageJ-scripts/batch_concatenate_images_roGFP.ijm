close("*");

// images to convert 
//directory_open = "/Users/samuelorion/Desktop/toclean_new.nosync/New Folder With Items/"; 
directory_open = "/Users/samuelorion/Desktop/roGFP data/to_be_aligned_DMV/"; 

// where to put the images 
//directory_to_save = "/Users/samuelorion/Desktop/concatenated_registered/"
directory_to_save = "/Users/samuelorion/Desktop/toclean_new.nosync/output/"



file_list = getFileList(directory_open);

Array.print(file_list);

//setBatchMode("hide");

for (i = 39; i < 40; i++) {

	key = "set"+i;
	
	print(key);
	
	for (j = 0; j < file_list.length; j++) {
		
		
		if(startsWith(file_list[j], key)){

			//open images if match

			file_name = directory_open + file_list[j];
			
			run("Bio-Formats", "open=["+file_name+"] autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
			
			print(file_list[j]);
			
			}	
		}

	open_images = getList("image.titles");
	
	run("Concatenate...", "open image1="+open_images[0]+" image2="+open_images[1]+" image3="+open_images[2]);
	
	run("Enhance Contrast", "saturated=0.35");
	
	run("StackReg ", "transformation=Translation");	

	new_file_name = directory_to_save + open_images[0];
	new_file_name = replace(new_file_name, ".nd2", "");
	
	saveAs("Tiff", new_file_name);  close("*");
		
	}

	

