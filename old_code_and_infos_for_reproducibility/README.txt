2018-08-15
- 130x130cm screen projected on the wall
- participants stand ca. 100cm from the wall
- projector positioned ca. 300 cm from the wall

2018-05-25
- a presentation with all possibilities created (30x30-all-piff-paff.pptx)
	- 5x5 raster (horizontally/vertically)
		position:
			11 12 13 14 15
			21 22 23 24 25
			31 32 33 34 35
			41 42 43 44 45
			51 52 53 54 55
	- 2 sizes (small/medium)
		size: s, m
	- 2 vowels (piff/paff)
		vowel: i, a
	- together 25 * 2 * 2 = 100 items
- in the presentation first slides are all possibilities at one slide
- then single possibilities follow:
	- static pic with word on it
	- animation
	- empty slide

- i generated random lists that choose from item slide range (in steps of 3, because there are always 3 slides for each item)
- the number of the beginning slide in ppt file is also coded in the data-coding table
		rand-number: 8, 11, 14, (n+3...), 305

random lists generated:
1.
[29, 62, 8, 50, 260, 47, 149, 200, 170, 302, 119, 197, 164, 224, 53, 11, 248, 272, 146, 215, 143, 173, 278, 167, 137, 305, 26, 203, 209, 218, 266, 236, 176, 32, 245, 263, 257, 128, 107, 155, 77, 125, 284, 290, 239, 281, 182, 188, 299, 242, 74, 140, 41, 89, 227, 287, 179, 269, 158, 98, 80, 212, 191, 14, 230, 68, 110, 194, 92, 116, 161, 134, 293, 221, 104, 122, 275, 251, 296, 35, 44, 38, 65, 131, 23, 101, 95, 206, 254, 17, 59, 113, 185, 86, 152, 20, 83, 233, 56, 71]

2.
[209, 137, 131, 290, 161, 74, 245, 227, 230, 8, 167, 299, 197, 83, 233, 35, 29, 215, 158, 50, 92, 86, 194, 17, 155, 20, 38, 101, 110, 77, 173, 266, 125, 23, 14, 275, 185, 287, 140, 179, 62, 218, 65, 302, 104, 32, 59, 116, 143, 53, 164, 221, 212, 203, 128, 119, 257, 89, 26, 239, 293, 11, 170, 71, 296, 107, 206, 272, 191, 44, 80, 281, 146, 224, 236, 98, 251, 200, 284, 47, 176, 278, 188, 248, 269, 134, 305, 122, 41, 68, 113, 254, 242, 56, 95, 260, 263, 152, 149, 182]

3.
[104, 209, 107, 299, 170, 80, 197, 146, 62, 260, 206, 26, 29, 275, 245, 194, 167, 98, 212, 11, 140, 110, 266, 185, 221, 182, 50, 296, 143, 155, 257, 230, 218, 119, 65, 128, 173, 122, 278, 302, 164, 77, 14, 47, 287, 236, 251, 71, 281, 38, 272, 35, 203, 179, 149, 290, 83, 227, 20, 17, 101, 233, 248, 89, 41, 263, 74, 152, 68, 161, 224, 284, 254, 176, 188, 95, 56, 200, 293, 116, 59, 8, 215, 131, 137, 32, 239, 305, 113, 158, 86, 23, 125, 92, 44, 242, 134, 53, 191, 269]

4.
[278, 86, 257, 59, 92, 65, 188, 200, 122, 218, 71, 224, 140, 239, 23, 41, 110, 8, 275, 47, 137, 233, 119, 191, 50, 260, 296, 44, 173, 83, 62, 299, 89, 206, 128, 263, 152, 305, 20, 251, 125, 17, 68, 281, 29, 242, 38, 155, 113, 221, 77, 143, 164, 107, 98, 167, 101, 290, 287, 245, 284, 248, 80, 272, 26, 176, 158, 269, 212, 203, 293, 74, 116, 230, 53, 185, 104, 32, 11, 149, 95, 146, 209, 131, 266, 215, 161, 170, 236, 134, 194, 227, 35, 254, 302, 182, 14, 56, 197, 179]

5.
[89, 155, 224, 236, 176, 95, 221, 245, 278, 140, 80, 200, 248, 20, 302, 215, 92, 284, 104, 86, 206, 239, 305, 53, 197, 281, 23, 173, 32, 143, 65, 230, 44, 242, 287, 116, 107, 83, 212, 293, 74, 152, 50, 101, 137, 146, 119, 149, 158, 257, 71, 254, 188, 98, 296, 26, 227, 122, 131, 8, 17, 29, 35, 185, 170, 260, 68, 11, 77, 38, 203, 266, 233, 269, 164, 263, 128, 62, 194, 110, 179, 290, 209, 134, 161, 113, 14, 299, 218, 182, 41, 191, 272, 47, 125, 167, 275, 251, 59, 56]

Pre-processing:
- random lists translated into code names, according to the coding.csv via a python script
- lists with orthographical text (piffs and paffs) generated for WebMaus
- .wav files: deleted parts of speech which were disturbing the WebMaus annotation
	- DO NOT CHANGE THE TIMES, you can only silence the parts that are problematic, but DO NOT CUT THEM OUT (otherwise, how do you want to align the mocap data?)
- WebMaus annotation of piffs and paffs succesful
- run rename_labels_modified.praat to prepare the first tier:
	- pauses annotated as '-'
	- orthographic annotations deleted
- run label_from_text_file.praat to annotate the labels:
	- choose a correct list-x-partx.txt file from \scripts and use it on each of the textgrids
	- unfortunately this has to be done semi-manually (every file has to be selected and saved separately)
- manual correction of the annotations:
	- /p/ starts with a burst
	- vowel starts with the end of friction from the aspiration and ends with the beginning of the friction of /f/
	- /f/ ends with the end of visible "rauschen"
- run extract_measurements.praat:
	- problem 1: the parameters are given for ALL intervals, which is more than needed
		- solution: either you can rewrite the praat script or you can exclude the redundant rows later on in R (I will proceed with the second solution)
	- problem 2: the segment intervals are not coded with their codes (e.g., si42)
		- solution: clean-up.ipynb now includes a script which generated a list of tripled item codes from the list previously used for labeling; I couldn't manage to overwrite the existing files, so I copied the generated tripled lists into new lists into scripts\listy
		- now the lists should be transferred to cleaned up csv-tables, accordingly to the version a given id was confronted with
- clean-up.R contains the processing of the extracted .csv files








