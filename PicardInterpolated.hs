module PicardInterpolated where

import IntegrateRiemannInterpolated (integrateRiemannInterpolated)

picardInterpolated :: (Double -> Double -> Double) -- v(x,t)
                      -> [Double]                  -- Y
                      -> [Double]                  -- T
                      -> Double                    -- x0
                      -> Double                    -- t0
                      -> Int                       -- N
                      -> [Double]                  -- X
picardInterpolated v ys ts x0 t0 n = [x0 + integrateRiemannInterpolated v ys ts t0 t n | t <- ts ]

picardInterpolatedIterated :: (Double -> Double -> Double) -- v(x,t)
                              -> Double                    -- x0
                              -> Double                    -- t0
                              -> [Double]                  -- T
                              -> Int                       -- Riemann steps (n)
                              -> Int                       -- Picard iterations (j)
                              -> [Double]                  -- X (xj+1(t) values)
picardInterpolatedIterated v x0 t0 ts n j
    | j == 0    = replicate (length ts) x0
    | otherwise = picardInterpolated v prevYs ts x0 t0 n
        where prevYs = picardInterpolatedIterated v x0 t0 ts n (j - 1)
