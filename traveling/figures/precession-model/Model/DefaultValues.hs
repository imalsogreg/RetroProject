module Model.DefaultValues where

import Model.ModelTypes

------------------------------------------------------------------------------
defaultHippo :: HippoParams
defaultHippo = HippoParams {
    runMetersPerSecond    = 1
  , thetaFreqHz           = 8
  , staticPhaseOffset     = 0
  , phaseOffsetPerMM      = pi/8
  , excitationOffsetPerMM = 0.2
  , placeCellMaxHeight    = 1
  , inhibMin              = 0
  , inhibMax              = 1
  , probCrossingSpike     = 0.0
  , rateVsExcitation      = \e d (Time t) -> if (d) < 0
                                             then 0
                                             else
                                               if t < 0.02 * e
                                               then 250 
                                               else 0
  }


------------------------------------------------------------------------------
defaultCell :: Pos -> Double -> CellParams
defaultCell p anatomyPos = CellParams {
    fieldPeak  = p
  , fieldStart = p - 1
  , fieldStop  = p + 0.05
  , anatomy    = anatomyPos
  }


------------------------------------------------------------------------------
defaultDraw :: DrawParams
defaultDraw = DrawParams {
    xRange = (0,4)
  , xRes   = 0.002
  , yRange = (0,1.5)
  }