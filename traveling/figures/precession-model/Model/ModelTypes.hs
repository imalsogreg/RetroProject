{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE RecordWildCards            #-}

module Model.ModelTypes where

data CellParams = CellParams {
    fieldPeak  :: Pos
  , fieldStart :: Pos
  , fieldStop  :: Pos
  , midDroop   :: Double
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
  , rateVsExcitation      :: Double -> Double -> Time -> Double
  }

data DrawParams = DrawParams {
    xRange :: (XVal, XVal)
  , xRes  :: XVal
  , yRange :: (Double, Double)
  } deriving (Eq, Ord, Show)

newtype Phase = Phase {unPhase :: Double}
              deriving (Eq, Ord, Num, Real, Fractional, Floating, RealFrac, RealFloat, Show)
newtype XVal  = XVal  {unXVal  :: Double}
              deriving (Eq, Ord, Enum, Num, Real, Fractional, Show)
newtype Pos   = Pos   {unPos   :: Double}
              deriving (Eq, Ord, Enum, Num, Real, Fractional, Show)
newtype Time  = Time  {unTime  :: Double}
              deriving (Eq, Ord, Enum, Num, Real, Fractional, Show)


-------------------------------
-- Unit conversion functions --
-------------------------------

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

phaseAtTime :: HippoParams -> Time -> Phase
phaseAtTime h@HippoParams{..} = phaseAtXVal h . xValAtTime h
