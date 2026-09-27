module PicardIterate where

import Picard (picard)

-- Calcualtes j picard iterations
picardIterate :: (Double -> Double -> Double)  -- v(x,t)
                 -> Double                     -- x0
                 -> Double                     -- t0
                 -> Int                        -- Riemann steps (n)
                 -> Int                        -- Picard iterations (j)
                 -> (Double -> Double)         -- xj(t)
picardIterate v x0 t0 n j
    | j == 0    = const x0                     --  x0(t) = x0
    | otherwise = picard v xPrev x0 t0 n
        where xPrev = picardIterate v x0 t0 n (j - 1)
