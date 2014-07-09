{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module ModelTypes where

data CellParams = CellParams {
    fieldPeak  :: Pos
  , fieldStart :: Pos
  , fieldStop  :: Pos
  , pctRound   :: Double
  , anatomy    :: Double
  } deriving (Eq, Ord, Show)

data HippoParams = HippoParams {
    runMetersPerSecond    :: Double
  , thetaFreqHz           :: Double
  , staticPhaseOffset     :: Double
  , phaseOffsetPerMM      :: Double
  , excitationOffsetPerMM :: Double
  , placeCellMaxHeight    :: Double
  , inhibMin              :: Double
  , inhibMax              :: Double
  , probCrossingSpike     :: Double
  , rateVsExcitation      :: Double -> Double
  }

data DrawParams = DrawParams {
    xRange :: (XVal, XVal)
  , xRes  :: XVal
  , yRange :: (Double, Double)
  } deriving (Eq, Ord, Show)

newtype Phase = Phase {unPhase :: Double}
              deriving (Eq, Ord, Num, Real, Fractional, Show)
newtype XVal  = XVal  {unXVal  :: Double}
              deriving (Eq, Ord, Num, Real, Fractional, Show)
newtype Pos   = Pos   {unPos   :: Double}
              deriving (Eq, Ord, Num, Real, Fractional, Show)
newtype Time  = Time  {unTime  :: Double}
              deriving (Eq, Ord, Num, Real, Fractional, Show)
