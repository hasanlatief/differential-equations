module Picard where

import IntegrateRiemann (integrateRiemann)

-- Calculates 1 picard iteration
picard :: (Double -> Double -> Double) -- v(x,t)
          -> (Double -> Double)        -- xj(t)
          -> Double                    -- x0
          -> Double                    -- t0
          -> Int                       -- Riemann steps (n)
          -> ( Double -> Double )      -- xj+1(t)
picard v xj x0 t0 n = \t -> x0 + integrateRiemann expr t0 t n
  where expr :: Double -> Double
        expr s = v (xj s) s
