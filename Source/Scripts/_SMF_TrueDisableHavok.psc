Scriptname _SMF_TrueDisableHavok extends ObjectReference  
{Disable Physics properly}

EVENT onLoad()
    BlockActivation(true)
    setMotionType(Motion_Keyframed, FALSE)
endEVENT

EVENT onCellAttach()
    BlockActivation(true)
endEVENT

EVENT onLoadGame()
    BlockActivation(true)
    if (Self.Is3DLoaded())
        setMotionType(Motion_Keyframed, FALSE)
    Endif
endEVENT