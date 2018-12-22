Custom MATLAB workflow for processing QSMs with TreeQSM and piping to R-based analysis
(Raumonen et al 2013)

tl;dr - Temperate species seem to excel under this fitting method, and that's probably why the data is published and freely available. Need to reveal the assumptions behind this work

Issues:
-Trees are sometimes fit along the surface with a network of small cylinders, rather than cylinders fitting the area inside of branches. Maybe be a consequence of not downsampling. We can attribute extremely long computation times to these degenerate cases

The following trees cast serious doubt on the overall efficacy of this method for many types of trees, especially extremely 'leggy' tropical trees
Examples:
12_sans_feuilles, 70_sans_feuilles - Both highly 'reticulated' with cylinders covering surface
2_sans_feuilles
31_sans_feuilles - branch junctions are fragmented
3_sans_feuilles
55_sans_feuilles - extremely long stems can mess with how tapering is accounted for
57_sans_feuilles - an intermediate case - how to automatically remove erroneous branches?

5_sans_feuilles - cosmetically decent, but look at trunk cylinders - having to sum this many 	fits will incorporate tons of error. Algorithm should attempt to fit larger cylinders

64_sans_feuilles - interestingly, high amounts of asymmetry may be at the root of the difficult. Extreme changes in cylinder size at junctions may not be properly accounted for
66_sans_feuilles - Actually a difficult circumstance that was handled rather well
67_sans - Just... yeah
85_sans_feuilles
89_sans_feuilles
91_sans_feuilles - Again observe how trunk cylinders iteratively fit. Overlapping shapes and summed dimensions can lead to overprediction
97sans_feuilles - Stem triangulation may be necessary to prevent certain errors like here
99_sans_feuilles - One wonders if the algorithm is actually fitting lianes...
No04 - Minimal networks cause problems
No06 - Who's to say?
No08 - Some trees just don't deserve to be fit
No09 - *ahem*
No10 - I bet it actually looks like that
No13 - Is there easy way to automatically prune 'obviously bad' data points like these?
Pinus11 - It gets very hard to tell whether this is doing a good job for finer branches
Tectona1_gray_1 - Potential failure to de-noise clouds prior to fitting
Tectona3_gray_1 - Either: fitting noise, or reaching the limits of the LiDAR's return distance
strom_2 - More meshwork
strom_10 - Just weird. Under what conditions do we get long, straight cylinders like these?
strom_12 - Yea its just hard to know. Will our input to R always be 'well-formed'?
strom_17 - Again some data just needs to be thrown out. This fit still isn't what we'd expect

This is an issue Yadvinder mentioned. Optimization can result in fitting many small cylinders
to an area better fit by one large one. Therefore, the optimization criteria of TreeQSM and opt-qsm are probably not to be trusted for our purposes. We'll need to understand these algorithms to decide how to change them -- met with Kobus and mention how junctions are the primary concern in fitting accuracy