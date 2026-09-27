-- Returns the index where Tn<=t<Tn+1
findInterval :: [Double] -> Double -> Int -> Int -> Int
findInterval ts t low high
    | low > high = error "No interval found"
    | t < ts!!mid = findInterval ts t low (mid - 1)
    | t >= ts!!(mid+1) = findInterval ts t (mid + 1) high
    | otherwise = mid
  where
    mid = (low + high) `div` 2
