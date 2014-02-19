Thesis timeline
===============

Intro
-----


ArtE
----

Ready to write: describe the rationale (more tetrodes, free customization, real-time experiments), prior art (AD, neuralynx, open ephys, TDT, plexon), implementation (c/c++ backend, networking, haskell for concurrency and nice types in position reconstruction), and status (working alongside AD for more TT's, some acquisition bugs remaining, proof of concept for real-time decoding).

Write it up (1 month)


Traveling wave
--------------

Need to do more analysis: repeat pairwise regression on more rats.
Do another regression with main factors (CA1 vs. CA3), (place field position)
(1 month)

Do a better job of quantifying head-only fields in Septal vs. long-tail cells it temporal.  (1 month)
Is the same split seen in CA1 vs. CA3? (1 month)

Impression so far and main punchline of story: theta has phase offsets along M-L axis, and there are phase differences between CA1 and CA3 (perhaps bring both of these phase offset stories together?).  However, spatial information across CA1, and between CA1 and CA3 is strictly coordinated.  Two possible explanations: (1) While phase advancement encourages earlier spiking, those same phase-advanced cells have a constant compensating force that delays spikes, or (2) the prediction that traveling waves would cause theta sequence time offsets came from a too-strict definition of phase precession that prematurely linked phase coding to the local phase measured at the same electrode tip measuring that cell, but there is no evidence in favor of such local coupling, because the notion that theta itself could be local or not is new.  There is some support for (1) in the observed changes in place field shape along the ST axis.

Write it (2 months)


Slow-wave wake
--------------

More analysis to do: look for correlation between ripple frequency and type-of-sleep, ripple frequency and proximity-to-downstate, stuff like that (open-ended, ugh). (0.5 month?)

Wait for Hector on forward/reverse replay as a function of proximity-to-downstate. (1 month)

Write up. (1 month)