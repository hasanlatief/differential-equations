ghci> print ((picardIterate ( \x t -> x * cos t ) 1 0 100 1 ) 1)
1.8491654840673433
ghci> print ((picardIterate ( \x t -> x * cos t ) 1 0 100 2 ) 1)
2.2088934108797633
ghci> print ((picardIterate ( \x t -> x * cos t ) 1 0 100 3 ) 1)
2.3109556520360153
ghci> print ((picardIterate ( \x t -> x * cos t ) 1 0 100 4 ) 1)
2.332767052266379
