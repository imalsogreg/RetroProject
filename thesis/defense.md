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

# Synchronized Information in a Desynchronized Circuit {#waves style="width:60%;margin-left:15%;margin-right:15%;"}

---

## Theta Oscillations

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

## Place Cells

<br/>

<div class="leftHalf">
![](../talkFigs/placeField2.png "A circular track viewed from above. Blue dots clustered together at one point indicate rat's position when a particular cell fired spikes. That small area is the neuron's place field.")
</div>
<div class="leftHalf">
![](../talkFigs/slowDecode2.png "A plot of the rat's position on the track (y-axis) as a function of time. Overlaid is an estimate of the rat's position made by considering which neurons fired spikes in any small time window, and looking up those neurons' place fields for the entire run session.")
</div>

 - Single cells become active at one track location
 - Many cells' activity can be combined to estimate rat's position^[6],[7]^

[6]:http://jn.physiology.org/content/79/2/1017.short
[7]:http://www.sciencedirect.com/science/article/pii/S0896627309005820

---

## Sequence Replay

![](../talkFigs/replayExample2.png "Another plot of rat's position as a function of time with position estimate overlaid, zoomed in to a few seconds. Although the rat is stationary at the end of the track, the decoded position sweeps down the track in a linear way.")

 - Zoom in on stationary rat
 - Neural activity replays high-speed track traversal^[8]^

[8]:http://www.nature.com/nature/journal/v440/n7084/full/nature04587.html

---

## Theta Sequences

![](../talkFigs/exampleThetaSequencesAndRaster2.png "A raster plot of four place cells, for about 500 milliseconds. The cells are sorted vertically by preferred location on the track. At fine timescales, they can be seen to fire in fast sequences that reflect the ordering of their preferred locations. In the background is a position reconstruction in the same time interval, showing the same information: that the ensemble sweeps ahead of the rat in his direction of running. There is one such sweep per theta cycle.")

 - Hippocampal units ("place cells") fire at fixed track locations (y-axis)
 - Sort units by preferred location (y-axis) and zoom in time (x-axis)
 - Place cells fire in quick sequences reflecting place field order
 - Grey background: fine time-scale position estimate from 30 place cells

---



## Local Theta Desynchronization

<div class="leftHalf">
![](../talkFigs/brainAndWaves.png "A figure of a brain with three recording sites all in hippocampus, but progressively more lateral and posterior. Beside, three local field potential traces showing the theta rhythm. More lateral/posterior tetrodes have a graded time delay.")
</div>
<div class="leftHalf">

<br/><br/>
	
 - Within hippocampus, theta is desynchronized^[9]^
 - Field potential is increasingly delayed more laterally
 
</div>

[9]:http://www.nature.com/nature/journal/v459/n7246/full/nature08010.html

---

## Theta is a Traveling Wave

<video width="640" height="480" controls>
<source src="../movies/thanos1.ogg" type="video/ogg"/>
A high-speed animation of several cycles theta in the local field potentials of 32 tetrodes organized in an array along the hippocampus. Theta can be seen as a traveling wave here, with a peak that begins at the most medial tetrodes and sweeps laterally.
</video>

---

## Local Theta Desynchronization

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

## Position Decoding, Measuring Regional Time Offsets

<div class="leftHalf">
![](../talkFigs/decodingStrategy.png "An illustration of the procedure for measuring the impact of theta phase differences on theta sequences.")
</div>
<div class="leftHalf">

 - Divide cells into <span style="color:red">**medial**</span>
   and <span style="color:green">**lateral**</span> groups
 - Reconstruct theta sequences independently
 - Average together individual theta sequences
 - Compare group averaged theta sequences

</div>

---

## Regional Time Offsets are Actually Small 

<br/>


![](../talkFigs/sequences_all.png "")

 - Black arrows: x-intercept, theta sequence time delay
 - Blue arrows: Time delay of theta oscillation
 - Theta sequence delay < theta wave delay (p < 0.05)
 - Stretched diagonal shape: regional theta sequences are similarly streaked
 - Center of mass: when (>0), lateral cells participate later


---

## Time Offsets in Neuron Pairs Are Small

<br/>

![](../talkFigs/pairwise.png "A scatterplot with each point representing a pair of place cells. Time offset is on the z-axis, place-field offset is on the y-axis (right, blue) and anatomical offset is on the x-axis (left, red)")

 - All pairs of nearby cells, spike timing *vs.* anatomical distance & field distance
 - Strong relationship between <span style="color:#0040A0">
   place fields and timing</span> (theta sequences)
 - No strong relationship between <span style="color:#C00020">
   anatomical location and timing</span>

[10]:https://github.com/imalsogreg/RetroProject/tree/master/thesis

---

## Interpretation

<div class="spacedBullets">
 - Most spikes from place cells fall in sequences
 - Spike sequences are tightly aligned in time
 - ...despite time offsets in the underlying oscillations
 - What's the mechanism?
</div>

---

## Mechanism

<br/>

<div class="spacedBullets">

 - Several competing models for theta sequences
 - All rely on a local theta & predict sequences desynchronized by traveling wave
 - Two classes of explanation for our data:
    - Traveling wave is counteracted by a factor with the opposite timing gradient.
	  **Test through properties of place fields.**
	- Theta sequences are inherited from upstream regions that *are* synchronized.
	  **Test by recording upstream areas.**

</div>


---

# Hippocampal Cortical Sleep Interactions, During Wake {#sww}

---

## Slow-wave sleep

<br/>

<div class="leftHalf" style="width:75%">
![](../talkFigs/exampleSleep.png "")
</div>
<div class="leftHalf" style="width:25%;">

  - Hippocampus
	- Irregular field potential ripples
	- Bursts of action potentials
	- Replay
	- Sleep + rest

  - Cortex
	- ~4 Hz delta oscillations
	- K-complexes
	- Up/Down states
	- Sleep only
	
</div>

---

## Hippocampal-cortical sleep interactions

![From [Mehta's review](http://www.gmail.com) of [Ji & Wilson 2007](http://www.gmail.com)](../talkFigs/jiMehtaModel.gif "Pictures of three stages of learning. First, random neocortical inputs and a weak hippocampal connectivity matrix result in unstructured spiking in sleeping hippocampus. Then structured neocortical input during run results in structured firing of hippocampus and sequence learning in hippocampus. Third, the newly structured synaptic weights in hippocampus result in spontaneous replay, as well as driving the activity of cortex.")

---

## Experimental Setup

<br/>

![](../talkFigs/expDesign.png "")

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
