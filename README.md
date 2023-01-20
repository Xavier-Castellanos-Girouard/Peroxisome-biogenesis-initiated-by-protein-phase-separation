# Peroxisome-biogenesis-initiated-by-protein-phase-separation


The scripts in the subdirectories were used to calculate Tau values for fusion events in 8 videos. These analyses pertain to figure 3.


 Each video is classed into its own directory. Each fusion event for a video is classed into a subdirectory.

 Each fusion event subdirectory contains the following files:
 	aspect_ratio_values.csv : This file contains the aspect ratio of each droplet pair at different time points.

	axis_major_values.csv : This file contains the major axis values for each aspect ratio at different time points.

	BoundingBox.fig : This image file is the bounding box selected to create the mask used to make the mask.

	Figure5C_panel2.pdf : This figure illustrates the aspect ratio analysis performed on our data, as described in Figure 5C from Ceballos et al. (2018).

	Mask.fig : This image file contains the mask used to isolate the droplet fusion event.

	pex_droplet_fusion.R : This R script was used to calculate the tau value for the fusion event, and create relevant figures.
	
	Phase_Separation_Imagery(Video number)_(fusion_number).m : This Matlab script was used to calculate aspect ratios at different time points for each fusion event.


 The Tau_values.csv file contains a list of all tau values calculated for individual fusion events


-- SOFTWARE VERSIONS --
MATLAB version: R2022b
R version: 4.2
ggplot2 version: 3.3.6
tidyr version: 1.2.1
dplyr Version: 1.0.10

-- References --

Ceballos AV, McDonald CJ, Elbaum-Garfinkle S. Methods and Strategies to Quantify Phase Separation of Disordered Proteins. Methods Enzymol. 2018;611:31-50. doi: 10.1016/bs.mie.2018.09.037. Epub 2018 Nov 3. PMID: 30471691; PMCID: PMC6688841.
