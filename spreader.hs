module Spreader where

type Count = Int
type Diff = Int
data Group = Group Count Diff

basePercent :: Int -> (Int, Int)
basePercent = quotRem 100

spreadBalanced :: Int -> [Int]
spreadBalanced count
    | count < 1 = []
    | otherwise = addedList ++ baseList
    where
        (base, r) = basePercent count
        addedList = replicate r (base + 1)
        baseList = replicate (count - r) base

spreadByGroups :: [Group] -> [[Int]]
spreadByGroups [] = [[]]
spreadByGroups gs = initGroups ++ [lastGroupFixed]
    where
        count = foldr (\(Group x _) acc -> x + acc) 0 gs
        (base, _) = basePercent count
        percents = map (\(Group c d) -> replicate c $ base + d) gs
        redundant = 100 - sum (concat percents)
        initGroups = init percents
        lastGroup = last percents
        lastGroupLength = length lastGroup
        (redundantBase, r) = quotRem redundant lastGroupLength
        lastGroupFixed = zipWith (\i x -> x + if i < lastGroupLength then redundantBase else redundantBase + r) [1..] lastGroup
        

