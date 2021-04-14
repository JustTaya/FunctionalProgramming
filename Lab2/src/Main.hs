module Main where

import IntegralCalculator
import UnitTest

functionToCalculate :: Double -> Double
functionToCalculate x = 3*x + 2

main :: IO()
main = do
    launchAllTests
  
    let leftBound = -1.0
    let rightBound = 10.0
  
    putStrLn ("Left = " ++ show leftBound)
    putStrLn ("Right = " ++ show rightBound)
    
    putStrLn "Enter EPS: "
    inputEPS <- getLine
    
    putStrLn "Enter threads count: "
    inputThreadCounts <- getLine
    
    let epsilon = (read inputEPS :: Double)
    let threadCount = (read inputThreadCounts :: Int)

    result <- findIntegral leftBound rightBound epsilon threadCount functionToCalculate
    print result
