module UnitTest where

import Test.HUnit
import IntegralCalculator

launchAllTests :: IO Counts
launchAllTests = do
 runTestTT tests


tests :: Test
tests = TestList [TestLabel "integralTest" integralTest]


integralTest :: Test
integralTest = TestCase ( do
    putStrLn ""

    let _EPS = 0.1
    let testFunc x = 3*x + 2
    let leftBorder = -1.0
    let rightBorder = 10.0
    let epsilon = 0.01
    let threadCount = 3

    result <- findIntegral leftBorder rightBorder epsilon threadCount testFunc
    let expected = 170.5

    assertBool ("Results are not matched. Given result = " ++ show result ++ " expected result = " ++ show expected) (abs (result - expected) < _EPS)

    putStrLn "" )
