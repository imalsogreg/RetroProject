% Outline: Hippocampal coding and time constraints
% Gregory Hale

Overview
========

Three chapters about populations of neurons in the hippocampus coordinating their activity on very fine timescales, and how that coordination relates to the larger context of inputs and readouts. In the first chapter, explore the lack of synchrony in timing of the brain rhythms underlying excitatory drive in hippocampal place cells, and the impact of those differences on the ability of distant place cells to coordinate reliably during population-wide coding events. In the second chapter, describe the development of a tool for detecting place cell population coding events and using the information they contain to manipulate brain activity in an experimental way. In the third chapter, describe the unexpected transition of retrosplenial cortex into a slow-wave-sleep like state during reward consumption, and the timing relationship between hippocampal activity and retrosplenial cortex during these events. Conclude with a discussion about coordinated encoding that ties the three chapters together - how does the sequential nature of coding in hippocampus relate to afferents and efferents - do they also encode information in spike sequences? What experiments using real-time ensemble decoding would help answer those?

General Background
==================

## Hippocampal anatomy and physiology relevant to information coding

 - Hippocampal anatomy: cell layer and derdritic layer
 - Hippocampal laminar anatomy: CA1, CA3, entorhinal cortex; their connectivity
 - Hippocampal place cells
 - Theta oscillations and multiunit spike phase
 - Theta phase precession & theta sequences

## Sleep states, cortical rhythms, hippocampal-cortical interactions

 - Sleep statges, cortical eeg correlates (spindles, delta, theta)
 - Up-down states in vitro, frames of cortical spikes during sleep in vivo
 - Hippocampal ripples and sleep replay, wake replay
 - Hippocampal-cortical coordination of ripples/spindles, spatial content in 
   CA1 and visual cortex

## Haskell

 - What is functional programming
 - What are types 
 - Avoiding bugs by lifting program logic into types, 
   compiler catches mistakes early
 - Avoiding bugs through declarative programming
 - Concurrency - difficulty of running multiple threads
   simultaneously, and how Haskell's type system makes it 
   tractable for very concurrent situations

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
 - **Take-home:** Despite timing differences in excitatory drive, information 
   coding is tightly synchronized
 - Information timing decoupled from bulk firing rate timing
 - Different parts of CA1 weakly preferentially carry most of the spike rate at 
   different times (this is how there is in fact an anatomical gradient in 
   spike rate timing)
 - Traveling wave parameters match those from other tetrode array study
 - Model 1: Spatially graded, temporalyl constant additional excitation 
   compensates for delayed theta in more lateral locations.
     - Predictions for place field size match data
     - Prediction for skewness don't
 - Model 2: Afferents don't have traveling waves, but CA3 (main input 1) is 
   uniformally different phase from entorhinal cortex (main input 2), and 
   CA1 phase is inherited from a mixture of these two, according to the 
   proportional strength of the inputs at that point. Medial CA1 gets more
   heavy EC input and is excited earlier , lateral CA1 more heavy CA3 input 
   and is excited later. Phase precessing from individual CA1 cells is
   inherrited directly from one input area or the other.
      - Possibly more parsimonious than graded excitation model
      - Requires CA1 phase to be between CA3 and EC phases, but this isn't the case
 - Limitations of this study
      - Too few units, had to collapse data over time, or average over cells
      - Not sensitive to cycle-by-cycle variations in theta wave parameters.
 - New questions
      - Is theta desynchronized, traveling,  within CA3, EC, others? 
      - Which model (1,2, or another) accounts for greater synchrony in infomation
        content than in underlying excitation?
      - EC layer 3 grid cells do not phase precess. Do they contribute to CA1 timing?
      - 'Medial' and 'lateral' CA1 carry preferentially early and late stages of
        theta sequences, but we only looked at the most medial 1/3 of CA1 - does this
        trend continue as you proceed laterally, with very lateral place cells
        prospectively coding far ahead of the rat?
      - 'Traveling wave' model often a poor fit to invididual cycles. Can larger
        grids of electrodes find a more accurate structure, more whole picture
      - Is the synchrony of place cell coding used downstream? Actively maintained 
        in CA1?

Real time position decoding from populations of place cells
===========================================================

## Intro

 - Theta sequences and sequence replay in place cells, phenomenology
      - Replay occurs during reward consumption & slow-wave sleep
      - Theta sequences always present during running
      - Both theta sequences and replay touch parts of the track in a way
        that isn't strictly tied to recency of experience or future goals
      - However there is a statistical bias during sleep for replay of
        maze experienced just prior to sleep, and statistical bias for
        awake replay to involve salient parts of a maze (start/reward location)
 - Disrupting all replay events (e.g. through electrical stimulation
   triggered by ripples detected in real time):
      - Disruption of all ripples in sleep slows learning of the more recently
        experienced track.
      - Disruption of all awake ripples in a working memory task interferes
        with decisions involving working memory, doesn't measurably interfere 
        with simpler decisions
 - For more concrete evidence of where replay comes from and what its functional
   role is, **need to condition our manipulations on the information encoded in 
   replay event**. Examples:
      - Is replay content in any way under rat's control?
           - Reward rat for replays that go West, punish for replays that go East
           - Do West-going replays then happen more often?
      - Are rats aware of their replay content?
           - Use most recent replay (West or East) to determine which arm of a maze
             will be rewarded
           - Can rat learn to use their own replay (or its correlates) to guide
             their behavior?
 - Decoding replay information in real time is difficult
      - Tracking rat, isolating units, computing place fields, and stimulus decoding
        all happen offline; need to happen online for streaming data
      - *Throughput requirements:* must decode at least as quickly as data comes in
      - *Latency requirements:* data -> decoding lag must be fast enough for 
        behavioral feedback, preferably fast enough to disrupt an ongoing replay
      - *Asymptotic requirements:* Decoding time must not increase with duration of
        experiment, or long experiments ruled out.
      - *Concurrency:* Many sources of data (32 tetrodes, tracker, user input) all
        updating a single model
 - Chose Haskell for implementing, lots of advantages mostly due to type system
      - Haskell types model domain very tightly, compiler checks program logic
      - Types let compiler check whole codebase during code rewrites / code experiments
      - Types tell runtime system which operations are pure (not-interacting),
        very nice property for concurrency
 - Minimizing human intervention: no time for manual spike sorting

## Materials and Methods
