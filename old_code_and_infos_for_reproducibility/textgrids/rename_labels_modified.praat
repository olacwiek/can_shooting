# This script takes all the files in the specified directory
# and modifies their tiers.
# Place this script in the same folder as the sound files.
# There should be an output folder, named "output"

form Files
	sentence inputDir C:\Users\ola\OneDrive\PSIMS\2018-f0-can\scripts\textgrids\
	sentence outputDir C:\Users\ola\OneDrive\PSIMS\2018-f0-can\scripts\textgrids\output\
endform

# this lists everything in the directory into
# what’s called a Strings list

Create Strings as file list... list 'inputDir$'*.TextGrid

# and counts how many there are

numberOfFiles = Get number of strings

# then it loops through, doing some actions for every file in the list

for ifile to numberOfFiles
	
	# opens each file, one at a time
	select Strings list
	fileName$ = Get string... ifile
	Read from file... 'inputDir$''fileName$'
	
	# and manipulates the tiers:
	n = Get number of intervals: 1
	m = Get number of intervals: 3
	
	# ...change labels on the first tier
	for i from 1 to n
		label$ = Get label of interval: 1, i
		if label$ = ""
			Set interval text: 1, i, "-"
		else
			Set interval text: 1, i, ""
		endif
	endfor
	
	# ...change labels on the third tier
	for i from 1 to m
		label$ = Get label of interval: 3, i
		if label$ = "<p:>"
			Set interval text: 3, i, "-"
		endif
	endfor
	
	# ...delete the second tier
	Remove tier: 2

	# and saves as TextGrid
	Write to text file... 'outputDir$''fileName$'

	# then remove all the objects except
	# the strings list so Praat isn’t all cluttered up
	select all
	minus Strings list
	Remove
endfor

# at the very end, remove any other objects
# sitting around - like the strings list

select all
Remove
