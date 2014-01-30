Experience Report: Real-time brain decoding with Haskell

+ Abstract

Points to hit:
  + Scientist programmers write bad code! How will I do with Haskell?
  + Pure functions really were reusable.  Took MWL file parser, repurposed to cut out spikes before 'start time' - for quick debugging by streaming-to-file-from-point-in-time.
  + Expected difficulty vs. actual difficulty.  Getting rid of for loops: hard
    Using arrays: hard.  Using monads: easy.
  + Project goal, reason for the software
  + Mid-sized ecosystem of custom programs & formats; multiple processing stages
  + Old code written in c, hard to extend
  + Speed in prototyping / experimenting
  + Application in not-very-Haskellish domain (realtime data analysis)
  + Ability to self-teach, given state of tutorials and documentation
  + Ease of concurrency (as opposed to the c code, which stalled the project)
  + Haskell gives exposure to deeper ideas in CS
  + Occasional difficulty with out-dated documentation, brocken Haddocks in hackagedb, and frustration over GUI support.

+ Intro
  + Science background
    + Place cells fire spikes in particular parts of the track, sequence of
      places visited -> sequence of place cells activated
    + During pauses on track, sequences activated again
    + Reactivation during sleep, too
  + Project goal: 
    + Record many neurons in learning & sleeping rat
    + Analyze firing properties and behavior in realtime
    + Use this information to change rat's environment

+ Challenges
  + Low latency
  + A lot of IO.  Networking
           
  + Scientists' requirements: visualization, ease of getting started, libraries,    specific examples
  + This specific problem - realtime requirements, networking, visualization, 
    update of a complicated data structure