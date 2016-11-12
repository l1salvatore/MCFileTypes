


import MCGeneralized
import Data.List 
data PngImageType =
      PngGreyscale
    | PngTrueColour
    | PngIndexedColor
    | PngGreyscaleWithAlpha
    | PngTrueColourWithAlpha
    deriving (Show,Ord,Eq)

data PngInterlaceMethod =
      -- | No interlacing, basic data ordering, line by line
      -- from left to right.
      PngNoInterlace

      -- | Use the Adam7 ordering, see `adam7Reordering`
    | PngInterlaceAdam7
    deriving (Enum, Show,Eq)
-- Por ahora los campos son independientes entre si
-- Png Header

pngHeaderInts = [32,32,16,0,0,
                 32,32,8,0,0,
                 32,32,2,0,0,
                 32,32,16,0,0,
                 256,256,8,0,0,
                 32,32,8,0,0,
                 32,32,16,0,0,
                 32,32,8,0,0,
                 32,32,16,0,0,
                 32,32,8,0,0,
                 32,32,8,0,0,
                 32,32,4,0,0,
                 3,3,1,0,0,
                 34,34,4,0,0,
                 32,32,1,0,0,
                 32,32,2,0,0,
                 32,32,16,0,0,
                 38,38,4,0,0]


colourType = [PngGreyscale,PngTrueColour,PngIndexedColor,PngTrueColour,
              PngTrueColour,PngTrueColourWithAlpha,PngGreyscale,PngTrueColourWithAlpha, 
              PngTrueColour,PngIndexedColor,PngGreyscale,PngGreyscale,PngIndexedColor,
              PngIndexedColor,PngGreyscale, PngGreyscale,PngTrueColour, PngIndexedColor]


interlaceMethod = [PngNoInterlace,PngNoInterlace,PngNoInterlace,PngNoInterlace,
                   PngNoInterlace,PngNoInterlace,PngNoInterlace,PngNoInterlace,
                   PngNoInterlace,PngNoInterlace,PngNoInterlace,PngNoInterlace,
                   PngNoInterlace,PngInterlaceAdam7,PngInterlaceAdam7,PngNoInterlace,
                   PngNoInterlace,PngNoInterlace]


-- Chunks 

chunkType = intercalate "_" ["gAMA","IDAT","IEND","gAMA","IDAT","IEND","PLTE","tRNS","IDAT","IEND",
                             "gAMA","IDAT","IDAT","IEND","IDAT","hIST","IDAT","gAMA","IDAT","IEND","gAMA", 
                             "IDAT","IEND","gAMA","PLTE","IDAT","IEND","gAMA","tRNS","bKGD","IDAT","gAMA", 
                             "PLTE","tRNS","bKGD","IDAT","IEND","gAMA","IDAT","IEND","gAMA","tIME","IDAT",
                             "IEND","gAMA","sBIT","PLTE","IDAT","IEND","gAMA","sBIT","PLTE","IDAT","IEND",
                             "gAMA","IDAT","IEND","gAMA","IDAT","IEND","gAMA","IDAT","IDAT","IDAT","IDAT",
                             "IEND","gAMA","sBIT","PLTE","IDAT","IEND"]
{-




-}
