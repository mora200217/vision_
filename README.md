# vision_
Computer Vision system for Mathworks-Robocup-2021. 

Uses the RGB-D sensor raw data, collected by G3NOVA Manipulator, to estimate the position of EOI (Elements of Interest). 


## Example
Call the function `` GetCollisionBoxesFromRGBD(img, I)`` to get a CollisionBox array, which encloses the closest cans/bottles in the image. 
