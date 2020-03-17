## Update Patterns util for BeatSaber.jl

Main repo: https://github.com/lucienmaloney/BeatSaber.jl

Examples:

`julia updatepatterns.jl ../maps/Hardware Store/ExpertPlus.dat`

`julia updatepatterns.jl ~/mymapfolder/numb/Hard.dat`

`julia updatepatterns.jl /home/name/LittleSwing/Expert.dat`

Note that you can replace any value in any matrix to zero so that it will never increment. If you want to make sure a pattern never happens, that's how you can do it.

After updating patterns on whatever maps you like, feed them back into the main program by pasting the updated matrices here in the data.jl file of BeatSaber.jl
