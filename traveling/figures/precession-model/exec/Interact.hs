{-# LANGUAGE RecordWildCards #-}

module Main where

import Control.Applicative
import Control.Monad
import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Game

import Model
import Model.DefaultValues
import Model.Gloss
import Model.ModelTypes


------------------------------------------------------------------------------
picWidth, picHeight :: Int
picWidth  = 800
picHeight = 800


------------------------------------------------------------------------------
data World = World {
    dParams     :: DrawParams
  , hParams     :: HippoParams
  , cells       :: [CellParams]
  , spikeVals   :: [[XVal]]
  , spikePhases :: [[Phase]]
  , nLaps       :: Int
  , selection   :: Int
  }


------------------------------------------------------------------------------
w0 :: IO World
w0 = updateW $ World {
    dParams     = defaultDraw
  , hParams     = defaultHippo
  , cells       = [defaultCell 3 0]
  , spikeVals   = []
  , spikePhases = []
  , nLaps       = 1
  , selection   = 0
  }


------------------------------------------------------------------------------
updateW :: World -> IO World
updateW w = do
  spikes <- forM (cells w) $ \c ->
    spikesNLaps (dParams w) (hParams w) c (nLaps w)
  return $ w { spikeVals   = (map . map) fst spikes
             , spikePhases = (map . map) snd spikes
             }


------------------------------------------------------------------------------
draw :: World -> IO Picture
draw w@World{..} = do
  scale 250 250
    . translate
    (-1 * ((realToFrac . snd . xRange $ dParams) - (realToFrac . fst . xRange $ dParams))/2)
    (-1 * ((realToFrac . snd . yRange $ dParams) - (realToFrac . fst . yRange $ dParams))/2)
    . Pictures <$> sequence
    [ return . Color blue $ drawInhib dParams hParams
    , return . Pictures $ map (drawField dParams hParams) cells
    , Pictures <$> zipWithM (\c s -> drawSpikes dParams hParams c s) cells spikeVals
    , drawPhasePrecession w 0
    , return $ drawBounds w
    ]


------------------------------------------------------------------------------
drawFields :: World -> Picture
drawFields World{..} = Pictures $ zipWith
                       (\i c -> Color (iToColor i) $ drawField dParams hParams c)
                       [(0::Int)..] cells
  where iToColor i = let frac = fromIntegral i / fromIntegral (length cells)
                     in makeColor frac (1-frac) 0 1


------------------------------------------------------------------------------
drawBounds :: World -> Picture
drawBounds World{..} =
  let wid     = realToFrac $ snd xr - fst xr
      hei     = realToFrac $ snd yr - fst yr
      (xr,yr) = (xRange dParams, yRange dParams)
  in translate (wid/2) (hei/2) $ rectangleWire wid hei 


------------------------------------------------------------------------------
drawPhasePrecession :: World -> Int -> IO Picture
drawPhasePrecession w cellInd = do
  return $ Pictures $ map f points
    where 
    f (x',phase') =
      let x     = realToFrac x'
          phase = realToFrac phase'
      in  Pictures $ [translate x (phase/(2*pi)) $ circle 0.01
                     ,translate x ((phase + 2*pi)/(2*pi)) $ circle 0.01]
    h  = hParams w
    sx = spikeVals w !! cellInd :: [XVal]
    sp = map ( posAtXVal h ) sx :: [Pos]
    points = zip sx (map (\p -> atan2 (sin p) (cos p)) (spikePhases w !! cellInd)) :: [(XVal,Phase)]

------------------------------------------------------------------------------
respond :: Event -> World -> IO World
respond (EventKey k Down _ _) w
  | k == MouseButton LeftButton = updateW w
  | k == (SpecialKey KeyUp)     = updateW $ w {cells = bumpCell (selection w) 0.1    (cells w)}
  | k == (SpecialKey KeyDown)   = updateW $ w {cells = bumpCell (selection w) (-0.1) (cells w)}
  | k == (Char 'l')             = updateW $ w {nLaps = nLaps w + 1}
  | k == (Char 'L')             = updateW $ w {nLaps = max (nLaps w - 1) 0}
respond _ w = return $ w

bumpCell :: Int -> Double -> [CellParams] -> [CellParams]
bumpCell ind amt cells = zipWith f [0..] cells 
  where f i c = if i == ind
                then c {anatomy = anatomy c + amt}
                else c

------------------------------------------------------------------------------
main :: IO ()
main = w0 >>= \w -> playIO
       (InWindow "Phase Precession Model" (picWidth,picHeight) (10,10))
       white
       30
       w
       draw
       respond
       (\t w -> return w)