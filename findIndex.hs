findIndex :: Ord a => a         -- t
             -> [a]             -- Tn's
             -> Int             -- Index
findIndex t tns = index 0 tns
  where 
  index n (x:y:xs)
      | t>=x && t<y = n
      | otherwise = index (n+1) (y:xs)
