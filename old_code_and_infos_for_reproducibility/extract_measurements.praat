clearinfo

#The script assumes that there is one parent directory, containing individual directories in which the data from individual subjects are stored
#Enter the path of the superordinate parent here

fullpath$="C:/Users/ola/OneDrive/PSIMS/2018-f0-can/data/temp/"

sex=do ("Read Strings from raw text file...", "C:/Users/ola/OneDrive/PSIMS/2018-f0-can/data/temp/sex.txt")

vpcounter=1
	
wavpath$=fullpath$+"*.wav"
textgridpath$=fullpath$+"*.TextGrid"

wavs=do ("Create Strings as file list...", "wavs", wavpath$)
nr=do ("Get number of strings")

textgrids=do ("Create Strings as file list...", "TextGrids", textgridpath$)


for ifile to nr

	selectObject (wavs)
	wavname$=do$ ("Get string...", ifile)
	fullpath_wav$=fullpath$+wavname$

	objectname$=replace$(wavname$,".wav","",1)
	objectname$=replace$(objectname$,"'","_",0)		
	printline 'objectname$'
	
	printline 'fullpath_wav$'
	selectObject (textgrids)
	textgridname$=do$ ("Get string...", ifile)
	fullpath_textgrid$=fullpath$+textgridname$
	printline 'fullpath_textgrid$'


	do ("Read from file...", fullpath_wav$)
	do ("Read from file...", fullpath_textgrid$)
	selectObject ("TextGrid 'objectname$'")
	do ("Down to Table...", "no", 6, "yes", "no")
	selectObject ("TextGrid 'objectname$'")
	selectObject ("Sound 'objectname$'")
	do ("To Intensity...", 75, 0, "yes")

	selectObject ("Strings sex")
	sex$=do$ ("Get string...", wavs)
		
	selectObject ("Sound 'objectname$'")
	
	if sex$=="f"
		do ("To Pitch...", 0, 140, 400)
	else
		do ("To Pitch...", 0, 50, 300)
	endif

	selectObject ("Sound 'objectname$'")
	do ("To Formant (burg)...", 0, 5, 5500, 0.002, 50)

	selectObject ("Table 'objectname$'")

	do ("Append difference column...", "tmax", "tmin", "duration")

	do ("Append column...", "maxF0")
	do ("Append column...", "meanF0")
	do ("Append column...", "meanF0st")
	do ("Append column...", "medianF0")
	do ("Append column...", "minF0")
	do ("Append column...", "sdF0")
	do ("Append column...", "midpointF0")
	do ("Append column...", "slopeF0")

	do ("Append column...", "maxInt")
	do ("Append column...", "meanInt")
	do ("Append column...", "medianInt")
	do ("Append column...", "minInt")
	do ("Append column...", "sdInt")
	do ("Append column...", "midpointInt")

	do ("Append column...", "medianF1")
	do ("Append column...", "medianF1Bark")
	#do ("Append column...", "maxF1")
	#do ("Append column...", "meanF1")
	#do ("Append column...", "minF1")
	#do ("Append column...", "sdF1")
	#do ("Append column...", "midpointF1")

	do ("Append column...", "medianF2")
	do ("Append column...", "medianF2Bark")
	#do ("Append column...", "maxF2")
	#do ("Append column...", "meanF2")
	#do ("Append column...", "medianF2")
	#do ("Append column...", "minF2")
	#do ("Append column...", "sdF2")
	#do ("Append column...", "midpointF2")

	do ("Append column...", "medianF3")
	do ("Append column...", "medianF3Bark")

	do ("Append column...", "SPLH-SPL")

	n=do ("Get number of rows")
	
	for line from 1 to n
	
		tmin=do ("Get value...", line, "tmin")
		tmax=do ("Get value...", line, "tmax")
		dur=do ("Get value...", line, "duration")
		midpoint=(tmin+tmax)/2
		tmin01=midpoint-dur*0.4
		tmax01=midpoint+dur*0.4
	
		selectObject ("Pitch 'objectname$'")
	
		maxF0=do ("Get maximum...", tmin01, tmax01, "Hertz", "Parabolic")
		meanF0=do ("Get mean...", tmin, tmax, "Hertz")
		meanF0st=do ("Get mean...", tmin, tmax, "semitones re 1 Hz")
		medianF0=do ("Get quantile...", tmin, tmax, 0.5, "Hertz")
		minF0=do ("Get minimum...", tmin01, tmax01, "Hertz", "Parabolic")
		sdF0=do ("Get standard deviation...", tmin, tmax, "Hertz")
		midpointF0=do ("Get value at time...", midpoint, "Hertz", "Linear")

		t_minF0=do ("Get time of minimum...", tmin01, tmax01, "Hertz", "Parabolic")
		t_maxF0=do ("Get time of maximum...", tmin01, tmax01, "Hertz", "Parabolic")

		slopeF0=(maxF0-minF0)/(t_maxF0-t_minF0)

		selectObject ("Intensity 'objectname$'")

		maxInt=do ("Get maximum...", tmin, tmax, "Parabolic")
		meanInt=do ("Get mean...", tmin, tmax, "energy")
		medianInt=do ("Get quantile...", tmin, tmax, 0.5)
		minInt=do ("Get minimum...", tmin, tmax, "Parabolic")
		sdInt=do ("Get standard deviation...", tmin, tmax)
		midpointInt=do ("Get value at time...", midpoint, "Cubic")
	
		selectObject ("Formant 'objectname$'")
			
		if dur>0.02
			start=midpoint-0.01
			end=midpoint+0.01
		else
			start=tmin
			end=tmax
		endif
	
		medianF1=do ("Get quantile...", 1, start, end, "Hertz", 0.5)	
		medianF1Bark=do ("Get quantile...", 1, start, end, "Bark", 0.5)	
		#maxF1=do ("Get maximum...", 1, tmin, tmax, "Hertz", "Parabolic")
		#meanF1=do ("Get mean...", 1, tmin, tmax, "Hertz")
		#minF1=do ("Get minimum...", 1, tmin, tmax, "Hertz", "Parabolic")
		#sdF1=do ("Get standard deviation...", 1, tmin, tmax, "Hertz")
		#midpointF1=do ("Get value at time...", 1, midpoint, "Hertz", "Linear")

		medianF2=do ("Get quantile...", 2, start, end, "Hertz", 0.5)
		medianF2Bark=do ("Get quantile...", 2, start, end, "Bark", 0.5)		
		#maxF2=do ("Get maximum...", 2, tmin, tmax, "Hertz", "Parabolic")
		#meanF2=do ("Get mean...", 2, tmin, tmax, "Hertz")			
		#minF2=do ("Get minimum...", 2, tmin, tmax, "Hertz", "Parabolic")
		#sdF2=do ("Get standard deviation...", 2, tmin, tmax, "Hertz")
		#midpointF2=do ("Get value at time...", 2, midpoint, "Hertz", "Linear")

		medianF3=do ("Get quantile...", 3, start, end, "Hertz", 0.5)
		medianF3Bark=do ("Get quantile...", 3, start, end, "Bark", 0.5)

		selectObject ("Sound 'objectname$'")

		#tmin=1.5
		#tmax=2

		do ("Extract part...", tmin, tmax, "Hamming", 1, "no")

		#do ("To Pitch...", 0, 75, 300)
		#slopeF0=do ("Get mean absolute slope...", "Hertz")

		#selectObject ("Pitch 'objectname$'_part")
		#Remove
	
		selectObject ("Sound 'objectname$'_part")
		spl=do ("Get root-mean-square...", 0, 0)

		do ("Copy...", "'objectname$'_part_splh")

		selectObject ("Sound 'objectname$'_part_splh")
		do ("To Spectrum...", "yes")

		selectObject ("Sound 'objectname$'_part_splh")
		Remove

		selectObject ("Spectrum 'objectname$'_part_splh")
		Formula... self*(((1+x^2/200^2)/(1+x^2/5000^2))^0.5)
		do ("To Sound")
	
		selectObject ("Sound 'objectname$'_part_splh")
		splh=do ("Get root-mean-square...", 0, 0)

		spec_emph=splh-spl

		selectObject ("Spectrum 'objectname$'_part_splh")
		Remove
		selectObject ("Sound 'objectname$'_part_splh")
		Remove
		selectObject ("Sound 'objectname$'_part")
		Remove

		selectObject ("Table 'objectname$'")

		do ("Set numeric value...", line, "maxF0", maxF0)
		do ("Set numeric value...", line, "meanF0", meanF0)
		do ("Set numeric value...", line, "meanF0st", meanF0st)
		do ("Set numeric value...", line, "medianF0", medianF0)
		do ("Set numeric value...", line, "minF0", minF0)
		do ("Set numeric value...", line, "sdF0", sdF0)
		do ("Set numeric value...", line, "midpointF0", midpointF0)
		do ("Set numeric value...", line, "slopeF0", slopeF0)
	
		do ("Set numeric value...", line, "maxInt", maxInt)
		do ("Set numeric value...", line, "meanInt", meanInt)
		do ("Set numeric value...", line, "medianInt", medianInt)
		do ("Set numeric value...", line, "minInt", minInt)
		do ("Set numeric value...", line, "sdInt", sdInt)
		do ("Set numeric value...", line, "midpointInt", midpointInt)

		do ("Set numeric value...", line, "medianF1", medianF1)
		do ("Set numeric value...", line, "medianF1Bark", medianF1Bark)
		#do ("Set numeric value...", line, "maxF1", maxF1)
		#do ("Set numeric value...", line, "meanF1", meanF1)
		#do ("Set numeric value...", line, "minF1", minF1)
		#do ("Set numeric value...", line, "sdF1", sdF1)
		#do ("Set numeric value...", line, "midpointF1", midpointF1)	

		do ("Set numeric value...", line, "medianF2", medianF2)
		do ("Set numeric value...", line, "medianF2Bark", medianF2Bark)
		#do ("Set numeric value...", line, "maxF2", maxF2)
		#do ("Set numeric value...", line, "meanF2", meanF2)
		#do ("Set numeric value...", line, "medianF2", medianF2)
		#do ("Set numeric value...", line, "minF2", minF2)
		#do ("Set numeric value...", line, "sdF2", sdF2)
		#do ("Set numeric value...", line, "midpointF2", midpointF2)

		do ("Set numeric value...", line, "SPLH-SPL", spec_emph)
		
	endfor

	selectObject ("Sound 'objectname$'")
	Remove

	selectObject ("TextGrid 'objectname$'")	
	Remove

	selectObject ("Intensity 'objectname$'")
	Remove

	selectObject ("Pitch 'objectname$'")
	Remove

	selectObject ("Formant 'objectname$'")
	Remove

	selectObject ("Table 'objectname$'")
	#printline 'fullpath$'
	outpath$=fullpath$+objectname$+".csv"
	do ("Save as comma-separated file...", outpath$)
	Remove


endfor

selectObject (wavs)
Remove

selectObject (textgrids)
Remove
vpcounter=vpcounter+1