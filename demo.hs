module Main where

import IntegrateRiemannInterpolated (linspace)
import PicardInterpolated (picardInterpolatedIterated)

v :: Double -> Double -> Double
v x t = x * cos t

main :: IO()
main = print (picardInterpolatedIterated v 1 0 ( linspace 0 (2*pi) 1000 ) 1000 10)
