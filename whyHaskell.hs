integrateRiemann :: (Double -> Double)
                   -> Double          -- t0
                   -> Double          -- t
                   -> Int             -- N
                   -> Double          -- Riemann Sum Estimate
integrateRiemann f t0 t n = dx * sum (map f xs)
  where
      dx = (t-t0) / (fromIntegral n)
      xs = [t0 + fromIntegral i * dx | i <- [0..n]]


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

-- Returns the index where Tn<=t<Tn+1
findInterval :: [Double] -> Double -> Int -> Int -> Int
findInterval ts t low high
    | low > high = error "No interval found"
    | t < ts!!mid = findInterval ts t low (mid - 1)
    | t >= ts!!(mid+1) = findInterval ts t (mid + 1) high
    | otherwise = mid
  where
    mid = (low + high) `div` 2

interpolate :: Double           -- t
               -> [Double]      -- Y
               -> [Double]      -- T
               -> Double        -- Interpolated Value
interpolate t ys ts
  | t == last ts = last ys      -- If t = Tn then findIndex will cause a crash because TN is not in any [Tn,Tn+1)
  | otherwise = ys!!n + (t-ts!!n)/(ts!!(n+1)-ts!!(n))*(ys!!(n+1)-ys!!n)
    where n = findInterval ts t 0 (length ts)

-- Makes n linearly spaced points between t0 and tF
linspace :: Double           -- t0
         -> Double        -- tF
         -> Int           -- N
         -> [Double]      -- List of Tn's
linspace t0 tF n = [t0 + fromIntegral i * dx | i <- [0..n]]
  where dx = (tF - t0) / fromIntegral n

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


v :: Double -> Double -> Double
v x t = x * cos t

main :: IO()
main = print (picardInterpolatedIterated v 1 0 ( linspace 0 (2*pi) 1000 ) 1000 10)
