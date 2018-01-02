# Laura In Love

LAURA = Lua-based Advance Utility for Role-Play and Adventuring

"In love" refers to the fact that it needs the LÖVE engine to run.
I refuse to call this LAURA III, even though this is the 3rd instalment of LAURA, because LAURA I and II were fully independent engines not requiring a full engine executable file as a dependency (aside from the Launcher requirement in LAURA II). LAURA in Love requires a 3rd-party executable file.

My plan is though to make LAURA in Love is able to handle great RPG games as its two predecessors could.
Like LAURA II it will be based on the Kthura map engine (although the Kthura for Love will require Kthura maps to be converted to Lua scripts rather than true-Kthura files. This just saves me the trouble of needing an extra parser which will only increase loading times, and give me a lot more work), and it will use a A* style pathfinder just as its two predecessors, allowing me to make my games fully mouse controlled, and maybe even touchscreen controlled.

I must note that I do not seriously consider mobile devices, at the present time. I need to focus on working at all. Mobile devices have too much trouble in storage capacity and performance. Yes even in 2018. Some people appear to think that mobile technology has already reached the level we may expect in 2040 or something, but we are not there yet :P

Since this is the first LAURA version not written in BlitzMax, I hope for better compatibility with Linux, but we'll have to see.

This library has been set up for the Ryanna building system. I must stress on that! Just dumping it into your project will NOT work at all. It needs dependencies which Ryanna can all collect into the project, and has also been set up to do business with the Pre-Processor Ryanna includes in all projects.

![](https://github.com/TrickyGameTools/LAURA2/blob/master/Source/inc/Witch.png?raw=true)
