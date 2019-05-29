Custom MATLAB workflow for processing QSMs with TreeQSM and piping to R-based analysis
(Raumonen et al 2013)

Workflow commands:
-create_input
-tree_analysis("LiDAR/*") - can also specify a single tree - see function for parameters
-view_cylinder_model("
-Extract to the R-based analysis environment with extract_optimal_qsm.m
-optqsm workflow is in place but I don't know what kind of computer can run it, even for a single tree. Specify input
with the txt file 'included.txt'

TO-DO:
-Make sure that MATLAB can overwrite old QSM fits in the R project i.e. same trees
with different parameter fits will have different filenames

-Look for ways to prevent bad fits on trees with sparse patches. Changing (reduce? increase?) the size of the cover set patches 
might be what we need to span the gaps so that cylinders can properly fit sparse areas rather than triggering bifurcation,
which is what causes our reticulated fits. Check Allie's suggested parameters again.

DONE:
-Check whether stem triangulation will resolve the reticulated fits
    -Triangulation is failing, buttresses seem to be the root of the issue. Hollow buttresses can't be
	triangulated. Does buttress deletion resolve the issue?
-Find a way to catalog trees that you clean manually, and document exclusion of others

tl;dr - Temperate species seem to excel under this fitting method, and that's probably why the data is published and freely available. Need to reveal the assumptions behind this work

Issues:
-Trees are sometimes fit along the surface with a network of small cylinders, rather than cylinders fitting the area inside of branches. Maybe be a consequence of not downsampling. We can attribute extremely long computation times to these degenerate cases
This is an issue Yadvinder mentioned. Optimization can result in fitting many small cylinders
to an area better fit by one large one. Therefore, the optimization criteria of TreeQSM and opt-qsm are probably not to be trusted for our purposes. We'll need to understand these algorithms to decide how to change them -- met with Kobus and mention how junctions are the primary concern in fitting accuracy

So far, Manual editing has not improved any fitting procedures. Initial conditions are not the problem because of
how the cover sets make fitting a local issue. Bad fits come from locally sparse tree clouds. 