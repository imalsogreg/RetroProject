% Thesis Outline: Hippocampal coding and time constraints
% Gregory Hale

Overview
========

Three chapters about populations of neurons in the hippocampus coordinating their activity on very fine timescales, and how that coordination relates to the larger context of hippocampal inputs, outputs, and experimental measurements. In the first chapter, explore the lack of synchrony in timing of the brain rhythms underlying excitatory drive in hippocampal place cells, and the impact of those differences on the ability of distant place cells to coordinate reliably during population-wide coding events. In the second chapter, describe the development of a tool for detecting place cell population coding events and using the information they contain to manipulate brain activity in an experimental way. In the third chapter, describe the unexpected transition of retrosplenial cortex into a slow-wave-sleep like state during reward consumption, and the timing relationship between hippocampal activity and retrosplenial cortex during these events. Conclude with a discussion about coordinated encoding that ties the three chapters together - how does the sequential nature of coding in hippocampus relate to afferents and efferents - do they also encode information in spike sequences? What experiments using real-time ensemble decoding would help answer those?

\pagebreak

General Background
==================

## Hippocampal anatomy and physiology relevant to information coding

 - Hippocampal anatomy: cell layer and dendritic layer
 - Hippocampal laminar anatomy: CA1, CA3, entorhinal cortex; their connectivity
 - Hippocampal place cells
 - Theta oscillations and multiunit spike phase
 - Theta phase precession & theta sequences

## Sleep states, cortical rhythms, hippocampal-cortical interactions

 - Sleep stages, cortical EEG correlates (spindles, delta, theta)
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

\pagebreak

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
 - Model 1: Spatially graded, temporally constant additional excitation 
   compensates for delayed theta in more lateral locations.
     - Predictions for place field size match data
     - Prediction for skewness don't
 - Model 2: Afferents don't have traveling waves, but CA3 (main input 1) is 
   uniformly different phase from entorhinal cortex (main input 2), and 
   CA1 phase is inherited from a mixture of these two, according to the 
   proportional strength of the inputs at that point. Medial CA1 gets more
   heavy EC input and is excited earlier , lateral CA1 more heavy CA3 input 
   and is excited later. Phase precessing from individual CA1 cells is
   inherited directly from one input area or the other.
      - Possibly more parsimonious than graded excitation model
      - Requires CA1 phase to be between CA3 and EC phases, but this isn't the case
 - Limitations of this study
      - Too few units, had to collapse data over time, or average over cells
      - Not sensitive to cycle-by-cycle variations in theta wave parameters.
 - New questions
      - Is theta desynchronized, traveling,  within CA3, EC, others? 
      - Which model (1,2, or another) accounts for greater synchrony in information
        content than in underlying excitation?
      - EC layer 3 grid cells do not phase precess. Do they contribute to CA1 timing?
      - 'Medial' and 'lateral' CA1 carry preferentially early and late stages of
        theta sequences, but we only looked at the most medial 1/3 of CA1 - does this
        trend continue as you proceed laterally, with very lateral place cells
        prospectively coding far ahead of the rat?
      - 'Traveling wave' model often a poor fit to individual cycles. Can larger
        grids of electrodes find a more accurate structure, more whole picture
      - Is the synchrony of place cell coding used downstream? Actively maintained 
        in CA1?

\pagebreak

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

### Backend signal acquisition and networking

 - Compatible with existing recording system, runs side by side with shared timestamps
 - NiDAQ cards, 64 channels at 32 kHz
 - Software spike filtering, software LFP filtering
 - Software grouping of channels into tetrodes, spike detection
 - Publish spikes and LFP to the network for other programs to process

### Offline position reconstruction

 - Manually sort spikes from many cells on single tetrode into groups, recover
   single-cell spike trains
 - Turn rat location on curved track into simple stimulus for prediction
      - Distance along track
      - 'Outbound' or 'inbound' running direction
 - Compute likelihood of spike rate given stimulus, using data from whole session
 - For a given ~15ms time window, use spikes in that time window and matching
   spike rate likelihood functions (place fields) to predict stimulus (track pos)
   by Bayesian inference

### Online position reconstruction

 - Manual spike sorting probably far too slow, use semi-automated or clusterless
 - Choosing data structure for spike sorting & decoding with bounded memory & time use
 - Likelihood functions have to be updated during experiment
      - By a lot of threads (~ 32 tetrodes * spike rate, plus current position)
      - Decoder also writes to likelihood function
 - Use Haskell's concurrency library to coordinate many writing/reading threads

## Results

 - Decoding quality
      - Offline position reconstruction compared to online with clusters, online
        clusterless
      - Tracking of rat's position
      - Appearance of theta sequences
      - Appearance of replay
 - Decoding speed w.r.t. real time requirements
 - Incidence of bugs, deadlocks; experience with refactoring & adding features

## Discussion


 - Recap: designed tool for decoding streaming place cell data
 - Remaining components needed to run experiments:
      - Networked rat tracker and track linearizer
      - Online line-finding algorithm
      - Combining estimates from multiple computers (for > 16 tetrode case)

\pagebreak

Retrosplenial slow-wave wake and interaction with hippocampus
=============================================================

## Intro

### Cortico-hippocampal interactions during sleep thought to be important for memory

 - Two phase consolidation model: encode at wake, burn-in during sleep
 - HPC ripples correlated w/ sleep CTX sleep spindles - communication signature?
 - Regular interval between hippocampal frame onset and cortical frame onset

## Materials & Methods

 - 10 tetrodes in HPC, 10 tetrodes split between retrosplenial, 
   somatosensory, motor, posterior parietal cortex
 - Trained rats to run circular track for reward every 270 degrees CCW

## Results

### Characterizing slow-wave sleep (SWS) in cortex

 - Examples of light sleep, spindles, frames and K-complexes in LFP, spiking
 - Examples of deep sleep, frames and K-complexes in LFP, spiking
 - Distribution of activity over all cortical electrodes
 - Average up-state length, down-state length

### Retrosplenial cortex enters SWS-like state during novelty / large rewards

 - Examples
 - Average up-state length, down-state length

### RSC awake slow waves coordinate with hippocampal ripples

 - 5-second window showing co-transition into SWS-like state 
   (RSC frames, HPC ripples & replay)
 - 200-second window showing behavioral-timescale relationship
 - Cross-correlation of ripples & RSC frames similar between wake and SWS

### RSC awake slow waves, evolution over training
 
 - Occur at most stopping points early in training
 - After ~1 week, spontaneous frames & small-reward frames stop, but large-reward frames persist (for at least a month)

### Anatomical restriction

 - Simultaneously recorded somatosensory, motor, posterior parietal cortex have no frame-like activity (noticeable changes in spike rate or LFP) during RSC awake frames


### Slow-wave wake not limited to times of sleepiness

 - Awake SWS-like activity continues in both light and dark phases of light cycle
 - Many SW's are flanked by fast running and chewing

## Discussion

 - Recap: Awake slow-waves in RSC, coordinated with HPC, fully awake
 - Recap: Spontaneous SW's decrease w/ training, can always be brought back with large rewards
 - Online (running) vs. Offline (reflecting or sleeping) may be a better dichotomy for brain
   states than the wake vs. sleep dichotomy
 - The hypothesized roles for HPC-CTX interaction during sleep may apply during wake too
 - Wake SW's have similar properties to sleep SW's
      - Multi-tetrode coordinated gaps in spiking
      - Multi-tetrode coordinated K-complexes in LFP
      - Timing relationship to HPC ripples
 - Wake SW's differ from sleep
      - Wake limited to a few frames. Sleep, continuous SW's for minutes
      - Wake restricted to RSC, sleep is all-cortex
 - New questions:
      - What other brain areas have SWWake? Papez circuit?
      - What's the mechanism for the switch from awake-aroused to SWW cortex?
      - What causes Slow Waves to traverse all of cortex during sleep, and not wake?
      - Is there information content in slow-wave frame spikes? Is it bounded by
        slow wave boundaries in an interesting way?

\pagebreak

Conclusion / Wrap-up
====================

Brief summary of the role of populations of neurons in hippocampal spatial coding. Much more reliability in the timing of place cell spike sequences than there is in single cell measures like phase precession. We want to know if population sequences are an essential feature of coding, or just a means of denoising, and answering that question will involve manipulations that account for information content in and react to it in real time, as well as studies of how population sequences are interpreted by downstream cortical areas.