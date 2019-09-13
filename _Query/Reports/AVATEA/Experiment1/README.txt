--------------------+
Experiment details: |
--------------------+

MACHINE: Dell Inspiron 15 5000 Series

IMPLEMENTATION: PEC-ASP on the full domain description (optimization for each query: OFF)

COMMENTS:

In this experiment, we show how a simple domain description can be used to estimate two parameters which concern with the user's behavior and mental state. These two parameters are thought to be somewhat correlated in the example. However, the "taskCorrect" parameter decays more quickly than the "engagement" parameter as different activities are detected. Therefore, the only parameter to cross the pre-defined threshold (0.3) is "taskCorrect" at instant 4.

DOMAIN DESCRIPTION:

	// AVATEA
	// Preliminary experiments
	// 
	// +----------------+
	// | Experiment n.1 |
	// +----------------+

	// Activities to detect:
	engagement takes-values {true, false}
	taskCorrect takes-values {true, false}

	// The subject is thought to be initially engaged
	// and carrying out the task correctly:
	initially-one-of { ({engagement=true,taskCorrect=true},1) }

	// Activities received from the classifier are:
	// 1. (Camera ->) Eyes not following target
	// 2. (EEG ->) Low level of attention
	// 3. (Motion sensor & Camera ->) Bad posture
	{ eyesNotFollowingTarget=false, lowAttention=false, badPosture=false }
		causes-one-of
		        { ({taskCorrect=true,engagement=true},4/10),
		          ({},6/10) }

	{ eyesNotFollowingTarget=true, lowAttention=false, badPosture=false, engagement=true }
		causes-one-of
		        { ({taskCorrect=false,engagement=false},1/10),
		          ({taskCorrect=false},1/10),
		          ({},8/10) }

	{ eyesNotFollowingTarget=true, lowAttention=false, badPosture=false, engagement=false }
		causes-one-of
			{ ({taskCorrect=false},3/10),
			  ({},7/10) }

	{ eyesNotFollowingTarget=false, lowAttention=true, badPosture=false }
		causes-one-of
			{ ({engagement=false,taskCorrect=true},1/10),
			  ({},9/10) }

	{ eyesNotFollowingTarget=true, lowAttention=true, badPosture=false }
		causes-one-of
			{ ({taskCorrect=false,engagement=false},2/10),
			  ({},8/10) }

	{ eyesNotFollowingTarget=false, lowAttention=false, badPosture=true }
		causes-one-of
			{ ({taskCorrect=false,engagement=false},1/10),
			  ({taskCorrect=false},1/10),
			  ({},8/10) }

	{ eyesNotFollowingTarget=true, lowAttention=false, badPosture=true }
		causes-one-of
			{ ({taskCorrect=false,engagement=false},1/10),
			  ({taskCorrect=false},2/10),
			  ({},7/10) }

	{ eyesNotFollowingTarget=true, lowAttention=true, badPosture=true }
		causes-one-of
			{ ({taskCorrect=false,engagement=false},2/10),
			  ({taskCorrect=false},2/10),
			  ({},6/10) }

	// Sequence of events:
	lowAttention performed-at 0
	eyesNotFollowingTarget performed-at 0
	badPosture performed-at 0
	lowAttention performed-at 1
	eyesNotFollowingTarget performed-at 1
	badPosture performed-at 1
	eyesNotFollowingTarget performed-at 2 with-prob 76/100
	lowAttention performed-at 2 with-prob 87/100
	lowAttention performed-at 3
	eyesNotFollowingTarget performed-at 3
	badPosture performed-at 3
	eyesNotFollowingTarget performed-at 7 with-prob 7/100
	eyesNotFollowingTarget performed-at 8 with-prob 89/100
	eyesNotFollowingTarget performed-at 9 with-prob 74/100
	eyesNotFollowingTarget performed-at 11
	//eyesNotFollowingTarget performed-at 12 with-prob 66/100
	//eyesNotFollowingTarget performed-at 13 with-prob 43/100
	//badPosture performed-at 13
	//eyesNotFollowingTarget performed-at 14 with-prob 88/100
