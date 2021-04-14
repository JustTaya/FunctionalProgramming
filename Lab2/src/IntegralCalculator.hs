module IntegralCalculator where

import Data.List.Split
import Control.Parallel

generateFunctionInputs :: Double -> Double -> Double -> [Double]
generateFunctionInputs left right epsilon = [min (left + fromIntegral i*epsilon) right | i <- [0..(round((right - left)/epsilon))]]

calculateRectangle :: Double -> Double -> (Double -> Double) -> Double
calculateRectangle x1 x2 func = (x2 - x1) * func ((x1 + x2) / 2.0)

calculateSumRectangles :: [Double] -> (Double -> Double) -> Double
calculateSumRectangles [ ] _ = 0.0
calculateSumRectangles [x] _ = 0.0
calculateSumRectangles list func = calculateRectangle (head list) (list !! 1) func + calculateSumRectangles (tail list) func


parallelCalculus :: [[Double]] -> Double -> (Double -> Double) -> Double
parallelCalculus [] lst func = 0
parallelCalculus (x:xs) lst func = par n1 (pseq n2 (n1 + n2))
                              where n1 = calculateSumRectangles ([lst] ++ x) func
                                    n2 = parallelCalculus xs (last x) func

findIntegral :: Double -> Double -> Double -> Int -> (Double -> Double) -> IO Double
findIntegral _left _right _eps _threadCount _func = do
    let inputs = generateFunctionInputs _left _right _eps
    let threadCount = min _threadCount (length inputs)
    let setOfInputs = chunksOf ( truncate ( fromIntegral (length inputs) / fromIntegral threadCount ) ) inputs
    return (parallelCalculus setOfInputs (head inputs) _func)

