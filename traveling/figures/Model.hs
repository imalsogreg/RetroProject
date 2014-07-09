{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE RecordWildCards #-}

module Main where

import Control.Monad
import Data.List
import System.Random.MWC
import System.Random.MWC.Distributions
import ModelTypes

------------------------------------------------------------------------------
-- |Place field excitation level vs. track position
field :: HippoParams -> CellParams -> Pos -> Double
field HippoParams{..} CellParams{..} p
  | p <= fieldPeak  = placeCellMaxHeight * (realToFrac $ fieldPeak - p)
  | p >  fieldPeak  =
    placeCellMaxHeight *
    (realToFrac((p - fieldPeak)/(fieldStop - fieldPeak))) ^ (2::Int)
field _ _ _ = error "Impossible case"

-- Throughout: XValue will be Time (sec)
posAtXVal :: HippoParams -> XVal -> Pos
posAtXVal HippoParams{..} (XVal t) = Pos (t * runMetersPerSecond)

timeAtXVal :: HippoParams -> XVal -> Time
timeAtXVal _ (XVal x) = Time x

xValAtTime :: HippoParams -> Time -> XVal
xValAtTime _ (Time t) = XVal t

phaseAtXVal :: HippoParams -> XVal -> Phase
phaseAtXVal h@HippoParams{..} x =
  Phase $ 2*pi * thetaFreqHz * realToFrac (timeAtXVal h x) + staticPhaseOffset

inhibAtXVal :: HippoParams -> XVal -> Double
inhibAtXVal h@HippoParams{..} x =
  (+ inhibMin) . (*(inhibMax - inhibMin)) . (* 0.5) . (+ 1) . sin .
  realToFrac . phaseAtXVal h $ x

plotXs :: DrawParams -> [XVal]
plotXs DrawParams{..} = [fst xRange, fst xRange + xRes, snd xRange]

plotField :: DrawParams -> HippoParams -> CellParams -> [(XVal,Double)]
plotField d@DrawParams{..} h@HippoParams{..} c@CellParams{..} =
  map (\x -> (x, fieldAt x)) (plotXs d)

fieldAt :: DrawParams -> HippoParams -> CellParams -> XVal -> Double
fieldAt d h c x = field h c . posAtXVal h $ x

plotInhib :: DrawParams -> HippoParams -> [(XVal, Double)]
plotInhib d@DrawParams{..} h@HippoParams{..} =
  map (\x -> (x, plotAt x)) (plotXs d)
  where
    plotAt x = inhibAtXVal h x

homogeneousPoissonProcess :: Double -> Time -> Time -> IO [Time]
homogeneousPoissonProcess rate tStart tStop = do
  let nEventsSafetyBuffer = ceiling $ realToFrac (tStop - tStart) * rate * 10
  isi <- withSystemRandom $ \gen ->
         replicateM nEventsSafetyBuffer $ exponential (1/rate) gen
  return . filter (<= tStop) . map Time . scanl (+) (unTime tStart) $ isi

inhomogeneousPoissonProcess :: Double -> (Time -> Double) -> Time -> Time
                            -> IO [Time]
inhomogeneousPoissonProcess pMax pAtTime tStart tStop = do
  hTimes <- homogeneousPoissonProcess pMax tStart tStop
  keep   <- withSystemRandom $ \gen ->
    forM hTimes $ \t -> do
      c <- uniformR (0,pMax) gen
      return $ pAtTime t > c
  return $ map fst . filter snd $ zip hTimes keep

------------------------------------------------------------------------------
spikeTimesOneLap :: DrawParams -> HippoParams -> CellParams -> Int
                 -> IO [Time]
spikeTimesOneLap d h@HippoParams{..} c@CellParams{..} nLaps = 
  inhomogeneousPoissonProcess maxRateAtX spikeRateAtT
  where
    xs = plotXs d
    spikeRateAtX = rateVsExcitation . fieldAt d h c
    spikeRateAtT = rateVsExcitation . posAtXVal . xValAtTime
    spikeRateAtXs = plotField d h c
    maxRateAtX = maximum . map snd $ spikeRateAtXs
