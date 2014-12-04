% Outline: Hippocampal coding and time constraints
% Gregory Hale

Overview
========

Three chapters about populations of neurons in the hippocampus coordinating their activity on very fine timescales, and how that coordination relates to the larger context of inputs and readouts. In the first chapter, explore the lack of synchrony in timing of the brain rhythms underlying excitatory drive in hippocampal place cells, and the impact of those differences on the ability of distant place cells to coordinate reliably during population-wide coding events. In the second chapter, describe the development of a tool for detecting place cell population coding events and using the information they contain to manipulate brain activity in an experimental way. In the third chapter, describe the unexpected transition of retrosplenial cortex into a slow-wave-sleep like state during reward consumption, and the timing relationship between hippocampal activity and retrosplenial cortex during these events. Conclude with a discussion about coordinated encoding that ties the three chapters together - how does the sequential nature of coding in hippocampus relate to afferents and efferents - do they also encode information in spike sequences? What experiments using real-time ensemble decoding would help answer those?


Coordinated information coding in a desynchronized network
===========================================================

## Intro

 - CA1 place cell excitation is timed by 10Hz oscillation - theta rhythm
 - theta seems to be a traveling wave, and peak excitation for one point in CA1 
   happens at a different time from peak excitation from another point in CA1.
 - Two views of the role of theta oscillation phase in hippocampal CA1 place 
   cell spiking
     - Different phases of underlying theta responsible for different functions, 
       opening different communication pathways. 
     - Smooth dependence of place cell spiking phase on rat location within 
       place field. 
 - How to reconcile idea of several small windows of opportunity for 
   communication with CA3 or cortex, with the continuum of place cell encoding?
 - For any 'phase' claim (CA3 peak spiking vs. CA1 phase, phase precession, etc.)
   we have to address whether phenomenon happens at different times for different
   points in CA1
 - My focus: do place cells in different parts of CA1 start precessing at different
   times? Or, w.r.t. theta sequences, are theta sequences misaligned for different
   subsets of CA1 place cells?
 - **Despite time offsets in underlying excitation, place encoding is synchronized 
   to better than 10 ms over the 3 mm of hippocampal tissue recorded**

## Results

### Theta phase spatial properties and timing offsets

 - Theta oscillation recorded from LFP, phase offsets correlated w/ 
   medial-lateral electrode location
 - Describe traveling-wave model fit to multi-tetrode array phase offset pattern
 - Repeat above using multiunit spiking as the measure of theta rhythm,
   comparison to findings with LFP
 - From traveling wave parameters, estimate the timing offset per unit anatomical
   distance in CA1 (20 ms/mm)

### Ensemble theta sequence decoding and timing

 - Subdivide tetrodes according to anatomical location, three groups 1mm wide
 - Decode position independently in each group at fine timescale
 - Theta sequences in most medial group line up with those in most lateral group
   to better within 10 ms (expected 40 ms if timing follows theta verbatim)

### Place cell pair timing relationships

 - Considering the distance between two tuning curves (e.g. 0 meters) and the
   anatomical distance between the two place cells (e.g. 1 mm), what is the
   observed timing difference between their spikes? 
 - Repeat for all pairs of place cells, measure timing offset as a function
   of place field distance and anatomical distance
 - Measured 15 ms per environmental meter (expected from theta sequences)
 - Measure ~3 ms per anatomical mm (lower than predicted from theta time offsets)

### Place cell properties correlate with anatomical location

 - Lateral CA1 units tend to be longer
 - No significant correlation between anatomical location and field skewness

### Theta sequences and place cell pairs are synchronized between CA3 and CA1

 - Repeat theta-sequence timing and place-cell pair timing, but comparing CA3
   to CA1
 - Observe that CA3 and CA1 theta sequences are tightly synchronized, despite
   literature theta timing differences ~25 ms.

## Discussion

- Recap CA1 theta phase offsets imply a 20ms delay for every 1mm lateral travel
- 