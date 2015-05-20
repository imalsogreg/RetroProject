Experience Report: Real-time brain decoding with Haskell


Main points to hit:
  + Haskell is known for good batch processing or DSL's compiling to something faster; but how does the runtime fare for real time scientific application?
  + Project goal, reason for the software
  + Mid-sized ecosystem of custom programs & formats; multiple processing stages
  + Comparison of experience against published claims (claims in STM paper, MIO)

+ Intro
  + Science background - Place cells and replay, quick explanation
  + Go over real-time analog stuff, and realtime brain-machine interfaces (related work)
  + Project goal: 
    + Analyze place cells in realtime to make new experiments possible
  + Contribution: Non trivial signal processing in real time implemented in off-the-shelf Haskell, scientists come join in!

+ Challenges
  + Low latency
  + A lot of IO.  Networking
  + Type system too restrictive? (answer: no. most pain came from partial fn's or deadlocks. moving toward stronger types generally made progress faster)
  + Actual memory leaks
  + Opaque capabilities when we push too hard on STM
  + Never really got around to unit or integration tests...
