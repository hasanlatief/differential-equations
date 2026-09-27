picardInterpolated :: (Double -> Double -> Double) -- v(x,t)
                      -> [Double]                  -- Y
                      -> [Double]                  -- T
                      -> Double                    -- x0
                      -> Double                    -- t0
                      -> Int                       -- N
                      -> [Double]                  -- X
picardInterpolated v ys ts x0 t0 n = [x0 + integrateRiemannInterpolated v ys ts t0 t n | t <- ts ]
