module Interpolate where

import FindInterval (findInterval)

interpolate :: Double           -- t
               -> [Double]      -- Y
               -> [Double]      -- T
               -> Double        -- Interpolated Value
interpolate t ys ts
  | t == last ts = last ys      -- If t = Tn then findIndex will cause a crash because TN is not in any [Tn,Tn+1)
  | otherwise = ys!!n + (t-ts!!n)/(ts!!(n+1)-ts!!(n))*(ys!!(n+1)-ys!!n)
    where n = findInterval ts t 0 (length ts)
