module Spreader (spreadBalanced, spreadByGroups, Group) where

type Count = Int
type Diff = Int
data Group = Group Count Diff

spreadBalanced :: Int -> [Int]
spreadBalanced count
    | count < 1 = []
    | otherwise = balancedList 100 count

spreadByGroups :: [Group] -> [[Int]]
spreadByGroups [] = [[]]
spreadByGroups gs = init percents ++ [lastGroupFixed]
    where
        count = foldr (\(Group x _) acc -> x + acc) 0 gs
        (base, _) = quotRem 100 count
        percents = map (\(Group c d) -> replicate c $ base + d) gs
        redundant = 100 - sum (concat percents)
        lastGroupFixed = spreadRedundant (last percents) redundant

balancedList :: Int -> Int -> [Int]
balancedList _ 0 = []
balancedList d c = addedList ++ baseList
    where
        (base, r) = quotRem d c
        addedList = replicate r (base + 1)
        baseList = replicate (c - r) base

spreadRedundant :: [Int] -> Int -> [Int]
spreadRedundant xs d = zipWith (+) xs $ balancedList d $ length xs

