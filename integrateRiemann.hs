integrateRiemann :: (Double -> Double) 
                   -> Double          -- t0
                   -> Double          -- t
                   -> Int             -- N
                   -> Double          -- Riemann Sum Estimate
integrateRiemann f t0 t n = dx * sum (map f xs)
  where
      dx = (t-t0) / (fromIntegral n)
      xs = [t0 + fromIntegral i * dx | i <- [0..n]]
