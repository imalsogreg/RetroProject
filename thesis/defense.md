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

<br/>

<div class="spacedBullets">
 1. [Synchronized information processing in a desynchronized network](#waves)
 1. [A tool for real time population decoding](#arte)
</div>

---

# Synchronized Information in a Desynchronized Circuit {#waves style="width:80%;margin-left:10%;margin-right:10%;"}

---

# Place Cells

<br/>

![](../talkFigs/decodeExample2.png "")


 - Single cells become active at one track location
 - Many cells' activity can be combined to estimate rat's position^[6],[7]^

[6]:http://jn.physiology.org/content/79/2/1017.short
[7]:http://www.sciencedirect.com/science/article/pii/S0896627309005820


---

# Theta Sequences

<div style="width:80%;margin:auto;">
![](../talkFigs/thetaSequencesRaster2.png "A raster plot of four place cells, for about 500 milliseconds. The cells are sorted vertically by preferred location on the track. At fine timescales, they can be seen to fire in fast sequences that reflect the ordering of their preferred locations. In the background is a position reconstruction in the same time interval, showing the same information: that the ensemble sweeps ahead of the rat in his direction of running. There is one such sweep per theta cycle.")
</div>

 - Place cells fire in quick sequences reflecting place field order


---

# Theta Sequences

<div style="width:80%;margin:auto;">
![](../talkFigs/thetaSequencesRaster3.png "A raster plot of four place cells, for about 500 milliseconds. The cells are sorted vertically by preferred location on the track. At fine timescales, they can be seen to fire in fast sequences that reflect the ordering of their preferred locations. In the background is a position reconstruction in the same time interval, showing the same information: that the ensemble sweeps ahead of the rat in his direction of running. There is one such sweep per theta cycle.")
</div>

 - Place cells fire in quick sequences reflecting place field order

---

# Theta Sequences {data-background="../rawArt/black.png"}

<video width="480" height="480" controls>
<source src="../movies/sequences.ogg" type="video/ogg"/>
</video>

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

 - ~13 ms of delay per millimeter (HPC is 10 mm)
 - What effect does this have on cortical communication?
 - What effect does this have on theta sequences?

---

# Traveling Wave and Theta Sequences

<br/>

![](../talkFigs/thetaSequenceModel.png "")

<div style="font-size:24pt;">Theta phase offsets may anatomically arrange theta sequences.</div>

---

# Traveling Wave and Theta Sequences

<br/>

![](../talkFigs/thetaSequenceModelBlurry.png "")

<div style="font-size:24pt;">Theta phase offsets may anatomically arrange theta sequences.</div>

---

# Position Decoding: Measuring Regional Time Offsets

<div class="leftHalf">
![](../talkFigs/sequencesPre.png "An illustration of the procedure for measuring the impact of theta phase differences on theta sequences.")
</div>
<div class="leftHalf">

 - Divide cells into <span style="color:red">**medial**</span>
   and <span style="color:green">**lateral**</span> groups
 - Reconstruct theta sequences independently
 - Average together individual theta sequences
 - Compare group averaged theta sequences

</div>

---

# Position Decoding: Measuring Regional Time Offsets

<div class="leftHalf">
![](../talkFigs/sequencesPost.png "An illustration of the procedure for measuring the impact of theta phase differences on theta sequences.")
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

# Gradient Dual-Input Model

<br/>

<div class="leftHalf">
![](../talkFigs/thetaSequenceModelExplanation.png "")
</div>

<div class="leftHalf">

 - Two inputs areas
 - With synchronized theta sequences but different theta phase
 - Preferentially projecting to medial/lateral CA1
 - CA1 inherits spike times directly
 - CA1 theta is a mixture of input's theta
 - Different input contributions at different phases in CA1



---

# Real Time Position Decoding {#arte}

---


# Place Cells

<br/>

![](../talkFigs/decodeExample2.png "")



---


# Sequence Replay

![](../talkFigs/replayExample2.png "Another plot of rat's position as a function of time with position estimate overlaid, zoomed in to a few seconds. Although the rat is stationary at the end of the track, the decoded position sweeps down the track in a linear way.")

 - Place cell sequence in stationary period
 - Neural activity replays high-speed track traversal^[8]^

[8]:http://www.nature.com/nature/journal/v440/n7084/full/nature04587.html

---


# Sequence Replay {data-background="../rawArt/black.png"}

<video width="480" height="480" controls>
<source src="../movies/replay.ogg" type="video/ogg"/>
</video>

---



# Sequence Replay

<div class="leftHalf">
![](../talkFigs/replayExample2.png "Another plot of rat's position as a function of time with position estimate overlaid, zoomed in to a few seconds. Although the rat is stationary at the end of the track, the decoded position sweeps down the track in a linear way.")
</div>
<div class="leftHalf">
<br/>

 - What is it for?
 - What causes it to travel one direction or the other?
 - Can we influence it?
 - Does it influence later place cell spiking?

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

# Real time decoding challenges

<div class="leftHalf">

![](../talkFigs/concurrency.png "")
</div>
<div class="leftHalf">

<br/>

 - Concurrency: many sources of input, several jobs to do at once
 - Streaming data: all computations must run in constant time
 - *Solution:* Implement in Haskell - great concurrency support, excellent for domain modeling


</div>

---

# Old Decoder Design

![](../rawArt/oldArte.png "")

---

# New Decoder Design

![](../rawArt/newArte.png "")

--- 

# When to split a program into two?

Benefits of splitting

 - Forces you to define an interface
 - Swap components easily (get input from disk for testing, from rat for real)
 - Possibly allows the use of more computers

Costs of splitting

 - Difficulty moving data (must choose data transport, more tradeoffs)
 - Must keep multiple programs schemas in sync
 - Types are lost (data are serialized before being shared)

---

# When to split a program in two?

 - Two ends of the spectrum
   - One program doing everything
   - One program per function per tetrode
 - Both extremes obviously wrong
   - Giant program is too slow (although many other befenits of splitting can be had just by recompiling)
   - One program per function -> raw data swamp
 - Right answer comes from considering the costs & benefits at each stage. 

---

# Streaming Data

![](../talkFigs/states/running1/1.png "")

---

# Streaming Data

![](../talkFigs/states/running1/2.png "")

---

# Streaming Data

![](../talkFigs/states/running1/3.png "")

---

# Streaming Data

![](../talkFigs/states/running1/4.png "")

---

# Streaming Data

![](../talkFigs/states/running2/q.png "")

---

# Streaming Data

![](../talkFigs/states/running2/1.png "")

---

# Streaming Data

![](../talkFigs/states/running2/2.png "")

---

# Streaming Data

![](../talkFigs/states/running2/3.png "")

---

# Streaming Data

![](../talkFigs/states/running2/4.png "")

---

# Streaming Data

![](../talkFigs/states/placefield/q.png "")

---

# Streaming Data

![](../talkFigs/states/placefield/1.png "")

---

# Streaming Data

![](../talkFigs/states/placefield/2.png "")

---

# Streaming Data

![](../talkFigs/states/placefield/3.png "")

---

# Streaming Data

![](../talkFigs/states/placefield2/q.png "")

---

# Streaming Data

![](../talkFigs/states/placefield2/1.png "")

---

# Streaming Data

![](../talkFigs/states/placefield2/2.png "")

---

# Streaming Data

![](../talkFigs/states/placefield2/3.png "")

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

# Throughput

![](../talkFigs/arteTiming.png "")

---

# Sketching a Full Real Time Decoding System

<br/>

 - Accept spikes from ArtE, Open-ephys, Puggle, etc.
 - Real time position tracking
 - *Spike sorting*

# Spike Sorting

<br/>

![](../talkFigs/stereotrode.png "")

---

# Clusterless Decoding

<br/>

![ [Kloosterman, Layton & Chen, 2014](http://jn.physiology.org/content/111/1/217.short) ](../talkFigs/clusterlessCartoon.png "")

<br/>



---

# Streaming Clusterless Decoding

![](../talkFigs/states/clusterless/q.png "")

---

# Streaming Clusterless Decoding

![](../talkFigs/states/clusterless/1.png "")

---

# Streaming Clusterless Decoding

![](../talkFigs/states/clusterless/2.png "")

---

# Streaming Clusterless Decoding

![](../talkFigs/states/clusterless/3.png "")

---

# Streaming Clusterless Decoding

![](../talkFigs/states/clusterless2/q.png "")

---

# Streaming Clusterless Decoding

![](../talkFigs/states/clusterless2/1.png "")

---

# Streaming Clusterless Decoding

![](../talkFigs/states/clusterless2/2.png "")

---

# Streaming Clusterless Decoding

![](../talkFigs/states/clusterless2/3.png "")

---

# Real Time Position Decoding

<br/>

 - Most real time decoders focus on behavioral correlates
 - We want to focus on fine timescale decoding
 - This is needed for interrupting/enhancing replay
 - Thus, we can get closer to underlying encoding mechanisms

---

# Summary

<br/>

![](../talkFigs/summary.png "")

---

# Thank You's

---

# 

![](../people/pages/lab.png "")

---

#

![](../people/pages/friends.png "")

---

#

![](../people/pages/mentors.png "")

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

# Retrosplenial and Somatosensory Activity During Reward Consumption

![](../talkFigs/ctxVsRsc.png "")


---

# Up/Down States Coordinate with Hippocampus

![](../talkFigs/exampleExtended.png "")

---

# Up/Down States Coordinate with Hippocampus

<br/>

![](../talkFigs/SWWDark.png "")

 - Repeat experiment at night: rat's active phase
 - Persisting strong Up/Down states during pauses for large reward

---

# Summary

![](../talkFigs/SWWbarchart.png "")

---


# Summary & New Questions

 - Retrosplenial cortex enters sleep-like state during reward consumption
 - Hippocampus is coordinated at the behavioral timescale
 - HPC $\rightarrow$ CTX information not limited to sleep
 - Future question: is replayed spatial information moving 
   between hippocampus and cortex?

---

