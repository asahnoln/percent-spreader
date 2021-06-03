module Spreader ( spreadBalanced
                , spreadByGroups
                , spreadByNamedGroups
                , Group
                , NamedGroup) where

type Count = Int
type Diff = Int
type Name = String
data Group = Group Count Diff deriving Show
data NamedGroup = NamedGroup Name Count Diff deriving Show
data NamedList a = NamedList Name [a]

instance Show a => Show (NamedList a) where
    show (NamedList n xs) = concat [n, " ", show xs]

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

spreadByNamedGroups :: [NamedGroup] -> [NamedList Int]
spreadByNamedGroups [] = []
spreadByNamedGroups ngs = result
    where
        gs = map (\(NamedGroup _ c d) -> Group c d) ngs
        ps = spreadByGroups gs
        result = zipWith (\xs (NamedGroup n _ _) -> NamedList n xs) ps ngs
