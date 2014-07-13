{-# LANGUAGE RecordWildCards #-}

module Model.Gloss where

import Control.Applicative
import Control.Monad
import Data.List
import Graphics.Gloss

import Model
import Model.ModelTypes


drawInhib :: DrawParams -> HippoParams -> Picture
drawInhib d h = plotToPath d $ plotInhib d h

drawField :: DrawParams -> HippoParams -> CellParams -> Picture
drawField d h c = plotToPath d $ plotField d h c

pipGroup :: DrawParams -> (XVal,Double) -> (XVal,Double) -> Bool
pipGroup d a b = pointInPlot d a == pointInPlot d b

checkedSegToPath :: [(XVal,Double)] -> Picture
checkedSegToPath = Line . map (\(x,y) -> (realToFrac x, realToFrac y))

plotToPath :: DrawParams -> [(XVal,Double)] -> Picture
plotToPath d = Pictures . map checkedSegToPath
               . filter (all (pointInPlot d)) . groupBy (pipGroup d)

pointInPlot :: DrawParams -> (XVal,Double) -> Bool
pointInPlot DrawParams{..} (x,y) =
     x >= fst xRange
  && x <= snd xRange
  && y >= fst yRange
  && y <= snd yRange


------------------------------------------------------------------------------
drawSpikes :: DrawParams -> HippoParams -> CellParams -> [XVal] -> IO Picture
drawSpikes d h c spikeVals = do
  let xs = spikeVals
      ys = map (fieldAt d h c) xs
      rasterDash x y = Line [(realToFrac x ,realToFrac y),
                             (realToFrac x, realToFrac $ y + 0.1)]
  return . Pictures $ zipWith rasterDash xs ys
