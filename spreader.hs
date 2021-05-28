module Spreader where

spreadBalanced :: Int -> [Int]
spreadBalanced count = addedList ++ baseList
    where 
        (base, r) = quotRem 100 count
        addedList = replicate r (base + 1)
        baseList = replicate (count - r) base

