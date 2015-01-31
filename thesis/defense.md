# Timing and Hippocampal Information Processing {data-background="../finalFigs/titleSlide.png"}

<br>

 - Gregory Hale 
 - Doctoral Dissertation
 - February 12, 2015

<br/>

 - Wilson Lab
 - Brain & Cognitive Sciences
 - MIT

# Overview

<div class="spacedBullets">
 1. [Synchronized information processing in a desynchronized network](#waves)
 1. [Hippocampal-Cortical Sleep Interactions, During Wake](#sww)
 1. [A tool for real time population decoding](#arte)
</div>

---

# Synchronized information in a desynchronized circuit{#waves}

---

## Theta oscillations, timing offsets

<div class="leftHalf">
![](../talkFigs/brainAndWavesOneChan.png "Overhead image of rat brain with one hippocampal recording site indicated. A voltage trace from that site shows several cycles of the theta rhythm in the local field potential")
</div>

<div class="leftHalf ">
<br/>

 - 8 Hz *Theta* rhythm in local field potential^[1]^
 - Coordinates communication between brain areas^[2],[3]^
 - Coordinates spike timing in local neural ensembles^[4],[5]^

</div>

[1]:http://www.sciencedirect.com/science/article/pii/S089662730200586X
[2]:http://www.sciencedirect.com/science/article/pii/S0896627308007629
[3]:http://www.ncbi.nlm.nih.gov/pubmed/15820700
[4]:http://onlinelibrary.wiley.com/doi/10.1002/hipo.450030307/abstract;jsessionid=16CD25E4E33682387124A01897AC938B.f03t04
[5]:http://onlinelibrary.wiley.com/doi/10.1002/hipo.20345/abstract

---

## Hippocampal-Cortical Coherence

<br/>

![](../talkFigs/siapasPFC2.jpg "Figure 1 of Lubenov and Spaipas 2006, showing prefrental spike timing preferentially aligned to peaks of hippocampal theta oscillations")

[Lubenov, Spiapas and Wilson (2006)](http://www.sciencedirect.com/science/article/pii/S0896627305001972)

 - Theta rhythms in hippocampal field potential (red)
 - No theta in prefrontal field potential (blue)
 - PFC spikes (blue) locked to HPC theta

---

## Theta sequences

![](../talkFigs/exampleThetaSequencesAndRaster2.png "A raster plot of four place cells, for about 500 milliseconds. The cells are sorted vertically by preferred location on the track. At fine timescales, they can be seen to fire in fast sequences that reflect the ordering of their preferred locations. In the background is a position reconstruction in the same time interval, showing the same information: that the ensemble sweeps ahead of the rat in his direction of running. There is one such sweep per theta cycle.")

 - Hippocampal units ("place cells") fire at stable preferred track locations
 - Sort units by preferred location (y-axis) and zoom in time (x-axis)
 - Place cells fire in quick sequences reflecting place field order
 - Grey background: fine time-scale position estimate from 30 place cells

---



## Local theta desynchronization

<div class="leftHalf">
![](../talkFigs/brainAndWaves.png "")
</div>
<div class="leftHalf">

<br/><br/>
	
 - Within hippocampus, theta is desynchronized^[6]^
 - Field potential is increasingly delayed more laterally
 
</div>

[6]:http://www.nature.com/nature/journal/v459/n7246/full/nature08010.html

---

## Local theta desynchronization

<video width="640" height="480" controls>
<source src="../movies/thanos1.ogg" type="video/ogg"/>
</video>

---

## Local theta desynchronization

<div class="leftHalf">
![](../talkFigs/brainAndWaves.png "")
</div>
<div class="leftHalf">

<br/>

 - About 13 ms of delay per millimeter (HPC is 10 mm)
 - What effect does this have on cortical communication?
 - What effect does this have on theta sequences?
 
</div>

[6]:http://www.nature.com/nature/journal/v459/n7246/full/nature08010.html

---

## Position Decoding, Regional Time Offsets

<div class="leftHalf">
![](../talkFigs/decodingStrategy.png "An illustration of the procedure for measuring the impact of theta phase differences on theta sequences.")
</div>
<div class="leftHalf">

 - Divide cells into <span style="color:red">**medial**</span> and <span style="color:green">**lateral**</span> groups
 - Reconstruct theta sequences independently
 - Average together individual theta sequences
 - Compare group averaged theta sequences

</div>

---

## Position Decoding, Regional Time Offsets


<div class="leftHalf">
![](../talkFigs/sequences_all.png "")
</div>
<div class="leftHalf">

<br/>

 Session                Yolanda A    Yolanda B    Morpheus     Caillou
--------------------- ------------ ------------ ----------- ------------
 Mean spacing(mm)       1.33         1.30          2.27       1.05
 Min spacing (mm)       0.94         0.94          1.47       0.69
 Expected offset(ms)    17.02        16.64         29.06      13.44
 Observed offset(ms)    -4.0          -3.0         6.0         3.5

</div>

---

## Follow-up: pairwise time offsets
## Interpretation



# Hippocampal Cortical Sleep Interactions, During Wake {#sww}

---

## Slow-wave sleep, frames, and HPC-CTX interactions

Content

---


## RSC exhibits SWS-like behavior during rewards

Content

## SWW coordinates with HPC

## SWW appearance under diverse conditions

## SWW anatomical restriction

## Interpretation



# A Tool for Real Time Population Decoding {#arte}
## Hippocampal replay
## Real time experiments
## Position decoding
## Real time decoding challenges
## Concurrency
## Haskell
## Real time demo
## Example decodings
## Bugs, deadlocks, crashes, and performance debugging
## Sketching a full real time decoding system







# Thank you's
