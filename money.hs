module Money where

percentsToMoney :: (Integral a, Fractional b) => b -> [a] -> [b]
percentsToMoney total = map (\x -> fromIntegral x * total / 100)
