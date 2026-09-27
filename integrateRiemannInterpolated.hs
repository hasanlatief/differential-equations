-- Makes n linearly spaced points between t0 and tF
linspace :: Double           -- t0
         -> Double        -- tF
         -> Int           -- N
         -> [Double]      -- List of Tn's
linspace t0 tF n = [t0 + fromIntegral i * dt | i <- [0..n]]
  where dt = (tF - t0) / fromIntegral n

integrateRiemannInterpolated :: (Double -> Double -> Double) -- v(x,t)
                                -> [Double]                  -- Y
                                -> [Double]                  -- T
                                -> Double                    -- t0
                                -> Double                    -- t
                                -> Int                       -- N
                                -> Double                    -- Output
integrateRiemannInterpolated v ys ts t0 t n = dx * sum ( zipWith v (map x tList) tList)
  where x t = interpolate t ys ts
        dx = (t-t0) / fromIntegral n
        tList = init (linspace t0 t n)
