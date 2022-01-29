time = getTime();
setBatchMode("hide");

for (i = 1; i < 26; i++) {

	if (expression) {

}




name = "2020_009_VTA_1008.nd2";
name2 = "2020_009_VTA_2008.nd2";
name3 = "2020_009_VTA_3008.nd2";

run("Bio-Formats", "open=[/Users/samuelorion/Desktop/roGFP data/toclean/2020_009_VTA/"+name+"] autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
run("Bio-Formats", "open=[/Users/samuelorion/Desktop/roGFP data/toclean/2020_009_VTA/"+name2+"] autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
run("Bio-Formats", "open=[/Users/samuelorion/Desktop/roGFP data/toclean/2020_009_VTA/"+name3+"] autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");

//run("Concatenate...", "open image1=2020_009_SN_1002.nd2 image2=2020_009_SN_2002.nd2 image3=2020_009_SN_3002.nd2");
run("Concatenate...", "open image1="+name+" image2="+name2+" image3="+name3);
run("Enhance Contrast", "saturated=0.35");
run("StackReg ", "transformation=Translation");
setBatchMode("exit and display");
time2 = getTime();
time_taken = (time2-time)/1000;
print(time_taken);