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

# Place Cells

<br/>

![](../talkFigs/decodeExample2.png "")


 - Single cells become active at one track location
 - Many cells' activity can be combined to estimate rat's position^[6],[7]^

[6]:http://jn.physiology.org/content/79/2/1017.short
[7]:http://www.sciencedirect.com/science/article/pii/S0896627309005820


---

# Sequence Replay

![](../talkFigs/replayExample2.png "Another plot of rat's position as a function of time with position estimate overlaid, zoomed in to a few seconds. Although the rat is stationary at the end of the track, the decoded position sweeps down the track in a linear way.")

 - Zoom in on stationary rat
 - Neural activity replays high-speed track traversal^[8]^

[8]:http://www.nature.com/nature/journal/v440/n7084/full/nature04587.html

---


# Sequence Replay {data-background="../rawArt/black.png"}

<video width="480" height="480" controls>
<source src="../movies/replay.ogg" type="video/ogg"/>
</video>

---

# Theta Sequences

![](../talkFigs/exampleThetaSequencesAndRaster2.png "A raster plot of four place cells, for about 500 milliseconds. The cells are sorted vertically by preferred location on the track. At fine timescales, they can be seen to fire in fast sequences that reflect the ordering of their preferred locations. In the background is a position reconstruction in the same time interval, showing the same information: that the ensemble sweeps ahead of the rat in his direction of running. There is one such sweep per theta cycle.")

 - Place cells fire in quick sequences reflecting place field order
 - Grey background: fine time-scale position estimate from 30 place cells

---

# Theta Sequences {data-background="../rawArt/black.png"} 

<video width="480" height="480" controls>
<source src="../movies/sequences.ogg" type="video/ogg"/>
</video>

---

# Theta Oscillations

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
 
# Local Theta Desynchronization

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

# Theta is a Traveling Wave

<video width="640" height="480" controls>
<source src="../movies/thanos1.ogg" type="video/ogg"/>

A high-speed animation of several cycles theta in the local field potentials of 32 tetrodes organized in an array along the hippocampus. Theta can be seen as a traveling wave here, with a peak that begins at the most medial tetrodes and sweeps laterally.

</video>

---

# Local Theta Desynchronization

<div style="width:50%;margin:auto;">
![](../talkFigs/brainAndWaves.png "") 
</div>

 - About 13 ms of delay per millimeter (HPC is 10 mm)
 - What effect does this have on cortical communication?
 - What effect does this have on theta sequences

---

# Traveling Wave and Theta Sequences

<br/>

![](../talkFigs/thetaSequenceModel.png "")

<div style="font-size:24pt;">Theta phase offsets may anatomically arrange theta sequences.</div>

---

# Position Decoding, Measuring Regional Time Offsets

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

# Regional Time Offsets are Small 

<br/>


![](../talkFigs/sequences_all.png "")

 - Black arrows: x-intercept, theta sequence time delay
 - Blue arrows: Time delay of theta oscillation
 - Theta sequence delay < theta wave delay (p < 0.05)
 - Stretched diagonal shape: regional theta sequences are similarly streaked
 - Center of mass: when (>0), lateral cells participate later


---

# Time Offsets in Neuron Pairs Are Small



![](../talkFigs/pairXCorr.png "A scatterplot with each point representing a pair of place cells. Time offset is on the z-axis, place-field offset is on the y-axis (right, blue) and anatomical offset is on the x-axis (left, red)")

 - Strong relationship between <span style="color:#0040A0">
   place fields and timing</span> (theta sequences)
 - Not between <span style="color:#C00020">
   anatomical location and timing</span>


---

# Interpretation

<div class="spacedBullets">
 - Most spikes from place cells fall in sequences
 - Spike sequences are tightly aligned in time
 - ...despite time offsets in the underlying oscillations
 - What's the mechanism?
</div>

---

# Mechanism

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


# Hippocampal-cortical sleep interactions

![From [Ji & Wilson 2007](http://www.nature.com/neuro/journal/v10/n1/full/nn1825.html)](../talkFigs/jiReplay2.png "")

 - Visual cortex neurons fire in sequences during running
 - Sequence reexpression coordinates with hippocampal sequences
 - But only during sleep

[10]:http://onlinelibrary.wiley.com/doi/10.1002/hipo.20345/abstract

---

# Slow-wave sleep features

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

# Experimental Setup

<br/>

![](../talkFigs/expDesign2.png "Experimental design illustration showing circular track and reward locations; diagram of tetrode recording locations: hippocampus, retrosplenial cortex, and somatosensory and motor cortices.")

 - Track designed to activate head-direction coding cells in RSC
 - Non-trivial reward locations with occasional large rewards
 - Record from HPC, RSC, and Somatosensory/Motor cortex

---


# Retrosplenial Cortex and Hippocampus During Run

![](../talkFigs/SWWNothing2.png "")

---

# Retrosplenial Cortex and Hippocampus During Reward Consumption

<div class="leftHalf" style="width:70%">
![](../talkFigs/exampleDetail.png "")
</div>
<div class="leftHalf" style="width:30%">

  - HPC: ripples, replay
  - As usual

<br/>

  - RSC: Delta, K-complexes, downstates.
  - Strange.

</div>

---

# Up/Down States Coordinate with Hippocampus

![](../talkFigs/exampleExtended.png "")

---

# Up/Down States and Drowsiness

<br/>

![](../talkFigs/SWWDark.png "")

 - Repeat experiment at night: rat's active phase
 - Persisting strong Up/Down states during pauses for large reward

---

# Up/Down States and Reward Size

<br/>

![](../talkFigs/SWWEarly.png "")

 - Recordings from first day of training
 - Strong Up/Down states during large rewards, also during small rewards

---

# Up/Down States and Novelty

<br/>

![](../talkFigs/SWWNormal.png "")

 - Recordings from later in training
 - Large rewards are completely predictable
 - Up/Down states still present during stops for large reward

---

# Summary

![](../talkFigs/SWWbarchart.png "")

---

# Up/Down States in Other Cortical Areas?


<br/>

![](../talkFigs/SWWAnatomical.png "")

 - Simultaneous recording from RSC and somatosensory & motor cortex
 - Down-states tightly coordinated during sleep
 - No down-states during wake except in Retrosplenial cortex

---

# Summary & New Questions

 - Slow-waves are not limited to slow-wave sleep and drowsiness
 - Retrosplenial cortex enters SWS-like state during reward
 - HPC $\rightarrow$ CTX information not limited to sleep
 - New questions:
    - Involvement of other cortical areas?
    - Occurance during other behavioral states?
    - Slow wave selectivity mechanism?

---

# Real Time Position Decoding {#arte}

---

# Hippocampal replay

<div class="leftHalf">
![](../talkFigs/replayExample2.png "Another plot of rat's position as a function of time with position estimate overlaid, zoomed in to a few seconds. Although the rat is stationary at the end of the track, the decoded position sweeps down the track in a linear way.")
</div>
<div class="leftHalf">
<br/>

 - What is it for?
 - What causes it to travel one direction or the other?
 - Can we influence it?
 - Does it influence place later place cell spiking?

</div>

---

# Real time experiments
<br/>

<div class="leftHalf">
<hr/>

 - Some replay goes left, some goes right
 - Can we reward left-going replay? Disrupt right-going?
 - Can we encourage large amounts of left-going replay?
 - Will this cause place cell plasticity?
 - Can we train a rat to follow his replay?

<hr/>
</div>
<div class="leftHalf">
![](../talkFigs/tmaze.png "")
</div>

---

# Offline Position Decoding

 - Sort spikes from electrodes into single units
 - Training data:
     - Compute place fields from all tetrode's spikes in recording session
	 - Repeat for all electrodes
 - Testing data:
     - Choose decoding time window (20ms)
     - For cells that spiked in that window, lookup place fields
	 - Bayesian inference to combine active place cells into one estimate
	 - Repeat for all time windows

---

# Real time decoding challenges

<div class="leftHalf">

![](../talkFigs/concurrency.png "")
</div>
<div class="leftHalf">

 - All data must be streaming
    - Can't keep all spikes in memory, too many
    - Too many spikes to process
 - Large amounts of concurrency
    - Can't process tetrodes one at a time, they generate spikes in parallel
    - Parallel data must be shared to produce single position estimate
    - Other data sources (video camera, mouse & keyboard, new clusters) also share the data
 - Need to be creative with data structures and concurrency
 - Lots of experimentation and refactoring

</div>

---

# Real Time Place Field Tracking {data-background="../rawArt/black.png"}

<video width="640" height="480" controls>
<source src="../movies/field.ogg" type="video/ogg"/>
</video>

---

# Real Time Place Position Decoding {data-background="../rawArt/black.png"}

<video width="640" height="480" controls>
<source src="../movies/decoding.ogg" type="video/ogg"/>
</video>

---


# Example Decodings

![](../talkFigs/headToHeadDecoding.png "")

---

# Sketching a full real time decoding system


 - Accept spikes from ArtE, Open-ephys, Puggle, etc.
 - Real time position tracking
 - Condition experimental stimuli on replay direction
 - Visualize replay during experiment for unstructured experimentation

# Thank you's

---

# Refactoring is Hard

```matlab
function p = bayesFields(fields,spikeCounts)

  % spike-times in column 1, interneuron in 2, field-id in 3
  for s = 1:size(spikeCounts,2)
    if (~(spikeCounts(2,s)))
	  spikeCounts(2,:) = [];
    end
  end
  
  pred = zeros(size(fields,1);
  for s = 1:size(spikeCounts,1)
    ...
```

 - There are 10 functions that rely on this column mapping
 - What happens when we modify fieldCounts?
 - Flexible functions: errors are rare

---

# Refactoring Can be Easier

```haskell
-- (f . g) x  == f (g (x))

bayesField fieldMap spikeCounts =
  (foldl' (*) .
  filterBy (not . isInterneuron) .
  map (lookupField fieldMap)) spikeCounts  
								  
```
 - No magic numbers or magic dimensions
 - Very strict functions: errors are obvious

---

# Haskell

![](../talkFigs/haskellPromise.png "")
 

---

# Real time demo

---
