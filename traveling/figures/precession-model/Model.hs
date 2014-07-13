{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE ScopedTypeVariables        #-}

module Model where

import Control.Applicative
import Control.Monad
import Data.List
import System.Random.MWC
import System.Random.MWC.Distributions
import Model.ModelTypes
import Model.DefaultValues

------------------------------------------------------------------------------
-- |Place field excitation level vs. track position
field :: HippoParams -> CellParams -> Pos -> Double
field HippoParams{..} CellParams{..} p
  | p <= fieldPeak  = placeCellMaxHeight - (realToFrac $ (fieldPeak - p) / (fieldPeak - fieldStart))
  | p >  fieldPeak  =
    placeCellMaxHeight * (1 - 
    (realToFrac((p - fieldPeak)/(fieldStop - fieldPeak))) ^ (2::Int))
field _ _ _ = error "Impossible case"

inhibAtXVal :: HippoParams -> XVal -> Double
inhibAtXVal h@HippoParams{..} x =
  (+ inhibMin) . (*(inhibMax - inhibMin)) . (* 0.5) . (+ 1) . sin .
  realToFrac . phaseAtXVal h $ x


------------------------------------------------------------------------------
plotXs :: DrawParams -> [XVal]
plotXs DrawParams{..} = [fst xRange, fst xRange + xRes .. snd xRange]


------------------------------------------------------------------------------
plotField :: DrawParams -> HippoParams -> CellParams -> [(XVal,Double)]
plotField d@DrawParams{..} h@HippoParams{..} c@CellParams{..} =
  map (\x -> (x, fieldAt d h c x)) (plotXs d)


------------------------------------------------------------------------------
fieldAt :: DrawParams -> HippoParams -> CellParams -> XVal -> Double
fieldAt d h c x = (field h c . posAtXVal h $ x) +
                  excitationOffsetPerMM h * anatomy c


------------------------------------------------------------------------------
plotInhib :: DrawParams -> HippoParams -> [(XVal, Double)]
plotInhib d@DrawParams{..} h@HippoParams{..} =
  map (\x -> (x, plotAt x)) (plotXs d)
  where
    plotAt x = inhibAtXVal h x


------------------------------------------------------------------------------
homogeneousPoissonProcess :: Double -> Time -> Time -> IO [Time]
homogeneousPoissonProcess rate tStart tStop = do
  let nEventsSafetyBuffer = ceiling $ realToFrac (tStop - tStart) * rate * 10
  isi <- withSystemRandom $ \gen ->
         replicateM nEventsSafetyBuffer $ exponential rate gen :: IO [Double]
  return . drop 1 . filter (<= tStop) . scanl (+) tStart . map Time $ isi


------------------------------------------------------------------------------
inhomogeneousPoissonProcess :: Double -> (Time -> Double) -> Time -> Time
                            -> IO [Time]
inhomogeneousPoissonProcess pMax pAtTime tStart tStop =
  withSystemRandom $ \gen -> do
    hTimes <- homogeneousPoissonProcess pMax tStart tStop
    filterM (f gen) $ hTimes
      where f gen t = do
              c <- uniformR (0,pMax) gen :: IO Double
              return $ pAtTime t > c


------------------------------------------------------------------------------
spikesOneLap :: DrawParams -> HippoParams -> CellParams -> IO [(XVal, Phase)]
spikesOneLap d h@HippoParams{..} c@CellParams{..} = do
  st <- inhomogeneousPoissonProcess maxRateAtX spikeRateAtT tStart tStop
  return $ zip (sx st) $ map (phaseAtTime h) st
  where
    xs = plotXs d
    sx st = map (xValAtTime h) st
    tStart = timeAtXVal h (minimum xs)
    tStop  = timeAtXVal h (maximum xs)
    spikeRateAtT :: Time -> Double
    spikeRateAtT t =
      let excitation = fieldAt d h c x
          dExcitation = excitation - inhibAtXVal h x
          x = xValAtTime h t
          sinceLastCross :: Time
          sinceLastCross = (t -) .  timeAtXVal h . foldl' max 0 .
                           filter (<= x) $ crossings d h c
      in rateVsExcitation excitation dExcitation sinceLastCross
    spikeRateAtXs = plotField d h c
    -- maxRateAtX = (*10) . maximum . map snd $ spikeRateAtXs :: Double
    maxRateAtX = 10000

------------------------------------------------------------------------------
spikesNLaps :: DrawParams -> HippoParams -> CellParams -> Int -> IO [(XVal,Phase)]
spikesNLaps d h c nLaps = do
  extPhases <- withSystemRandom $ \gen ->
    replicateM nLaps $ uniformR (0,2*pi) gen :: IO [Double]
  concat <$> (forM (0: drop 1 extPhases) $ \p ->
               let h' = h{staticPhaseOffset=p}
               in  (++) <$> spikesOneLap d h' c <*> crossingSpikes d h' c)


------------------------------------------------------------------------------
crossings :: DrawParams -> HippoParams -> CellParams -> [XVal]
crossings d@DrawParams{..} h@HippoParams{..} c@CellParams{..} =
  let xs            = plotXs d
      fs            = map snd $ plotField d h c
      is            = map snd $ plotInhib d h
      ds            = zipWith (>) fs is
      dSteps        = zip (zip ds (tail ds)) xs
      crossingXs    = map snd $ filter ( (== (False,True)) . fst ) dSteps
  in crossingXs


------------------------------------------------------------------------------
crossingSpikes :: DrawParams -> HippoParams -> CellParams -> IO [(XVal,Phase)]
crossingSpikes d h@HippoParams{..} c = withSystemRandom $ \gen -> do
  spikes <- spikeXs gen
  return $ zip spikes (map (phaseAtXVal h) spikes)
    where
      f g _     = ( < probCrossingSpike ) <$> uniformR (0,1) g
      spikeXs g = filterM (f g :: XVal -> IO Bool) $ crossings d h c