import System.Environment (getArgs)
import System.IO (readFile)

data Pixel = Pixel {
                    x :: Float,
                    y :: Float,
                    value :: Float
                    } deriving (Show)
type Image = [Pixel]

sourceFilename :: IO String
sourceFilename = do
    args <- getArgs
    return $ head args

wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p s = case dropWhile p s of
    "" -> []
    s' -> w : wordsWhen p s''
        where (w, s'') = break p s'

getFileLines :: FilePath -> IO [String]
getFileLines f = do
    text <- readFile f
    return $ wordsWhen (=='\n') text

readImage :: FilePath -> IO Image
readImage f = do
    text <- getFileLines f
    return $ map parseLine text

parseLine :: String -> Pixel
parseLine s = Pixel { x=x, y=y, value=value }
    where [x, y, value] = map read $ words s

performAperturePhotometry :: Image -> IO ()
performAperturePhotometry image = undefined

main :: IO ()
main = sourceFilename >>= readImage >>= performAperturePhotometry
