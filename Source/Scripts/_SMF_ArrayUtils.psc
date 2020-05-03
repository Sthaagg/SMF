Scriptname _SMF_ArrayUtils Hidden
{Function to manipulate arrays easily}

;/ Function dedicated to manipulate fom type array (form[]) 
Source Creation Kit Wiki: The following functions were created by Chesko. I added them to SMF as it is not easy to found them and set them gloabl to be easily used} /;


bool function ArrayAddForm(Form[] akMyArray, Form akMyForm) global
    ;Adds a form to the first available element in the array.
     
    ;-----------\
    ;Description \	Author: Chesko
    ;----------------------------------------------------------------
    ;Adds a form to the first available element in the array.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		false		=		Error (array full)
    ;		true		=		Success
     
    int i = 0
    ;notification("akMyArray.Length = " + akMyArray.Length)
    while i < akMyArray.Length
        if akMyArray[i] == none
            akMyArray[i] = akMyForm
            ;notification("Adding " + akMyForm + " to the array.")
            return true
        else
            i += 1
        endif
    endWhile
     
    return false
endFunction
     
bool function ArrayRemoveForm(Form[] akMyArray, Form akMyForm, bool abSort = false) global
;Removes a form from the array, if found. Sorts the array using ArraySortForm() if abSort is true.
     
    ;-----------\
    ;Description \	Author: Chesko
    ;----------------------------------------------------------------
    ;Removes a form from the array, if found. Sorts the array using ArraySortForm() if abSort is true.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		false		=		Error (Form not found)
    ;		true		=		Success
    int i = 0
    while i < akMyArray.Length
        if akMyArray[i] == akMyForm
            akMyArray[i] = none
            ;notification("Removing element " + i)
            if abSort == true
                ArraySortForm(akMyArray)
            endif
            return true
        else
            i += 1
        endif
    endWhile	
    return false
    endFunction
     
bool function ArraySortForm(Form[] akMyArray, int akI = 0) global
;Removes blank elements by shifting all elements down.
    ;-----------\
    ;Description \  Author: Chesko
    ;----------------------------------------------------------------
    ;Removes blank elements by shifting all elements down.
    ;Optionally starts sorting from element akI.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		   false		   =			   No sorting required
    ;		   true			=			   Success
    bool bFirstNoneFound = false
    int iFirstNonePos = akI
    while akI < akMyArray.Length
        if akMyArray[akI] == none
            if bFirstNoneFound == false
                bFirstNoneFound = true
                iFirstNonePos = akI
                akI += 1
            else
                akI += 1
            endif
        else
            if bFirstNoneFound == true
                ;check to see if it's a couple of blank entries in a row
                if !(akMyArray[akI] == none)
                    ;notification("Moving element " + i + " to index " + iFirstNonePos)
                    akMyArray[iFirstNonePos] = akMyArray[akI]
                    akMyArray[akI] = none
                    ;Call this function recursively until it returns
                    ArraySortForm(akMyArray, iFirstNonePos + 1)
                    return true
                else
                    akI += 1
                endif
            else
                akI += 1
            endif
        endif
    endWhile
    return false
endFunction
     
function ArrayClearForm(Form[] akMyArray) global
    ;Deletes the contents of this array.
    ;-----------\
    ;Description \	Author: Chesko
    ;----------------------------------------------------------------
    ;Deletes the contents of this array.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		none
    int i = 0
    while i < akMyArray.Length
        akMyArray[i] = none
        i += 1
    endWhile
endFunction
     
     
int function ArrayTotalCountForm(Form[] akMyArray) global
    ;Counts the number of indices in this array that do not have a "none" type.
    ;-----------\
    ;Description \	Author: Chesko
    ;----------------------------------------------------------------
    ;Counts the number of indices in this array that do not have a "none" type.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		int myCount = number of indicies that are not "none"
    int i = 0
    int myCount = 0
    while i < akMyArray.Length
        if akMyArray[i] != none
            myCount += 1
            i += 1
        else
            i += 1
        endif
    endWhile
    ;notification("MyCount = " + myCount)	
    return myCount
endFunction
     
     
int function ArrayHasForm(Form[] akMyArray, Form akMyForm) global
    ;Attempts to find the given form in the given array, and returns the index of the form if found.
    ;-----------\
    ;Description \	Author: Chesko
    ;----------------------------------------------------------------
    ;Attempts to find the given form in the given array, and returns the index of the form if found.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		-1		  =		Form not found
    ;		int i		  =		Location of the form
    int i = 0
    while i < akMyArray.Length
        if akMyArray[i] == akMyForm
            return i
        else
            i += 1
        endif
    endWhile
    return -1
endFunction
     
     
int function ArrayCountForm(Form[] akMyArray, Form akMyForm) global
    ;Attempts to count the number of times the given form appears in this array.
    ;-----------\
    ;Description \	Author: Chesko
    ;----------------------------------------------------------------
    ;Attempts to count the number of times the given form appears in this array.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		0					= 		Form not found
    ;		int i		 		=		Number of times form appears in array
    int i = 0
    int iCount = 0
    while i < akMyArray.Length
        if akMyArray[i] == akMyForm
            iCount += 1
            i += 1
        else
            i += 1
        endif
    endWhile
    return iCount
endFunction

;/ Function dedicated to manipulate Int type array (Int[]) /;

bool function ArrayAddInt(Int[] akMyArray, Int aiMyInt) global
    ;Adds a form to the first available element in the array.
     
    ;-----------\
    ;Description \
    ;----------------------------------------------------------------
    ;Adds a form to the first available element in the array.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		false		=		Error (array full)
    ;		true		=		Success
     
    int i = 0
    ;notification("akMyArray.Length = " + akMyArray.Length)
    while i < akMyArray.Length
        if akMyArray[i] == 0
            akMyArray[i] = aiMyInt
            ;notification("Adding " + aiMyInt + " to the array.")
            return true
        else
            i += 1
        endif
    endWhile
     
    return false
endFunction
     
bool function ArrayRemoveInt(Int[] akMyArray, Int aiMyInt, bool abSort = false) global
;Removes a form from the array, if found. Sorts the array using ArraySortForm() if abSort is true.
     
    ;-----------\
    ;Description \
    ;----------------------------------------------------------------
    ;Removes a form from the array, if found. Sorts the array using ArraySortForm() if abSort is true.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		false		=		Error (Form not found)
    ;		true		=		Success
    int i = 0
    while i < akMyArray.Length
        if akMyArray[i] == aiMyInt
            akMyArray[i] = 0
            ;notification("Removing element " + i)
            if abSort == true
                ArraySortInt(akMyArray)
            endif
            return true
        else
            i += 1
        endif
    endWhile	
    return false
    endFunction
     
bool function ArraySortInt(Int[] akMyArray, int akI = 0) global
;Removes blank elements by shifting all elements down.
    ;-----------\
    ;Description \
    ;----------------------------------------------------------------
    ;Removes blank elements by shifting all elements down.
    ;Optionally starts sorting from element i.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		   false		   =			   No sorting required
    ;		   true			=			   Success
    bool bFirstNoneFound = false
    int iFirstNonePos = akI
    while akI < akMyArray.Length
        if akMyArray[akI] == 0
            if bFirstNoneFound == false
                bFirstNoneFound = true
                iFirstNonePos = akI
                akI += 1
            else
                akI += 1
            endif
        else
            if bFirstNoneFound == true
                ;check to see if it's a couple of blank entries in a row
                if !(akMyArray[akI] == 0)
                    ;notification("Moving element " + i + " to index " + iFirstNonePos)
                    akMyArray[iFirstNonePos] = akMyArray[akI]
                    akMyArray[akI] = 0
                    ;Call this function recursively until it returns
                    ArraySortInt(akMyArray, iFirstNonePos + 1)
                    return true
                else
                    akI += 1
                endif
            else
                akI += 1
            endif
        endif
    endWhile
    return false
endFunction
     
function ArrayClearInt(Int[] akMyArray) global
    ;Deletes the contents of this array.
    ;-----------\
    ;Description \
    ;----------------------------------------------------------------
    ;Deletes the contents of this array.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		none
    int i = 0
    while i < akMyArray.Length
        akMyArray[i] = 0
        i += 1
    endWhile
endFunction
     
     
int function ArrayTotalCountInt(Int[] akMyArray) global
    ;Counts the number of indices in this array that do not have a "none" type.
    ;-----------\
    ;Description \	Author: Chesko
    ;----------------------------------------------------------------
    ;Counts the number of indices in this array that do not have a "none" type.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		int myCount = number of indicies that are not "none"
    int i = 0
    int myCount = 0
    while i < akMyArray.Length
        if akMyArray[i] != 0
            myCount += 1
            i += 1
        else
            i += 1
        endif
    endWhile
    ;notification("MyCount = " + myCount)	
    return myCount
endFunction
     
     
int function ArrayHasInt(Int[] akMyArray, Int aiMyInt) global
    ;Attempts to find the given form in the given array, and returns the index of the form if found.
    ;-----------\
    ;Description \
    ;----------------------------------------------------------------
    ;Attempts to find the given form in the given array, and returns the index of the form if found.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		-1		  =		Form not found
    ;		int i		  =		Location of the form
    int i = 0
    while i < akMyArray.Length
        if akMyArray[i] == aiMyInt
            return i
        else
            i += 1
        endif
    endWhile
    return -1
endFunction
     
     
int function ArrayCountInt(Int[] akMyArray, Int aiMyInt) global
    ;Attempts to count the number of times the given form appears in this array.
    ;-----------\
    ;Description \
    ;----------------------------------------------------------------
    ;Attempts to count the number of times the given form appears in this array.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		0					= 		Form not found
    ;		int i		 		=		Number of times form appears in array
    int i = 0
    int iCount = 0
    while i < akMyArray.Length
        if akMyArray[i] == aiMyInt
            iCount += 1
            i += 1
        else
            i += 1
        endif
    endWhile
    return iCount
endFunction

;/ Function dedicated to manipulate Int type array (Float[]) /;

bool function ArrayAddFloat(Float[] akMyArray, Float afMyFloat) global
    ;Adds a form to the first available element in the array.
     
    ;-----------\
    ;Description \
    ;----------------------------------------------------------------
    ;Adds a form to the first available element in the array.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		false		=		Error (array full)
    ;		true		=		Success
     
    int i = 0
    ;notification("akMyArray.Length = " + akMyArray.Length)
    while i < akMyArray.Length
        if akMyArray[i] == 0
            akMyArray[i] = afMyFloat
            ;notification("Adding " + aiMyInt + " to the array.")
            return true
        else
            i += 1
        endif
    endWhile
     
    return false
endFunction
     
bool function ArrayRemoveFloat(Float[] akMyArray, Float afMyFloat, bool abSort = false) global
;Removes a form from the array, if found. Sorts the array using ArraySortForm() if abSort is true.
     
    ;-----------\
    ;Description \
    ;----------------------------------------------------------------
    ;Removes a form from the array, if found. Sorts the array using ArraySortForm() if abSort is true.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		false		=		Error (Form not found)
    ;		true		=		Success
    int i = 0
    while i < akMyArray.Length
        if akMyArray[i] == afMyFloat
            akMyArray[i] = 0
            ;notification("Removing element " + i)
            if abSort == true
                ArraySortFloat(akMyArray)
            endif
            return true
        else
            i += 1
        endif
    endWhile	
    return false
endFunction
     
bool function ArraySortFloat(Float[] akMyArray, int akI = 0) global
;Removes blank elements by shifting all elements down.
    ;-----------\
    ;Description \
    ;----------------------------------------------------------------
    ;Removes blank elements by shifting all elements down.
    ;Optionally starts sorting from element i.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		   false		   =			   No sorting required
    ;		   true			=			   Success
    bool bFirstNoneFound = false
    int iFirstNonePos = akI
    while akI < akMyArray.Length
        if akMyArray[akI] == 0
            if bFirstNoneFound == false
                bFirstNoneFound = true
                iFirstNonePos = akI
                akI += 1
            else
                akI += 1
            endif
        else
            if bFirstNoneFound == true
                ;check to see if it's a couple of blank entries in a row
                if !(akMyArray[akI] == 0)
                    ;notification("Moving element " + akI + " to index " + iFirstNonePos)
                    akMyArray[iFirstNonePos] = akMyArray[akI]
                    akMyArray[akI] = 0
                    ;Call this function recursively until it returns
                    ArraySortFloat(akMyArray, iFirstNonePos + 1)
                    return true
                else
                    akI += 1
                endif
            else
                akI += 1
            endif
        endif
    endWhile
    return false
endFunction
     
function ArrayClearFloat(float[] akMyArray) global
    ;Deletes the contents of this array.
    ;-----------\
    ;Description \
    ;----------------------------------------------------------------
    ;Deletes the contents of this array.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		none
    int i = 0
    while i < akMyArray.Length
        akMyArray[i] = 0
        i += 1
    endWhile
endFunction
     
     
int function ArrayTotalCountFloat(Float[] akMyArray) global
    ;Counts the number of indices in this array that do not have a "none" type.
    ;-----------\
    ;Description \	Author: Chesko
    ;----------------------------------------------------------------
    ;Counts the number of indices in this array that do not have a "none" type.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		int myCount = number of indicies that are not "none"
    int i = 0
    int myCount = 0
    while i < akMyArray.Length
        if akMyArray[i] != 0
            myCount += 1
            i += 1
        else
            i += 1
        endif
    endWhile
    ;notification("MyCount = " + myCount)	
    return myCount
endFunction
     
     
int function ArrayHasFloat(Float[] akMyArray, Float afMyFloat) global
    ;Attempts to find the given form in the given array, and returns the index of the form if found.
    ;-----------\
    ;Description \	
    ;----------------------------------------------------------------
    ;Attempts to find the given form in the given array, and returns the index of the form if found.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		-1		  =		Form not found
    ;		int i		  =		Location of the form
    int i = 0
    while i < akMyArray.Length
        if akMyArray[i] == afMyFloat
            return i
        else
            i += 1
        endif
    endWhile
    return -1
endFunction
     
     
int function ArrayCountFloat(Float[] akMyArray, Float afMyFloat) global
    ;Attempts to count the number of times the given form appears in this array.
    ;-----------\
    ;Description \
    ;----------------------------------------------------------------
    ;Attempts to count the number of times the given form appears in this array.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		0					= 		Form not found
    ;		int i		 		=		Number of times form appears in array
    int i = 0
    int iCount = 0
    while i < akMyArray.Length
        if akMyArray[i] == afMyFloat
            iCount += 1
            i += 1
        else
            i += 1
        endif
    endWhile
    return iCount
endFunction


bool function ArrayAddKeyWord(Keyword[] akMyArray, keyword akMykeyword) global
    ;Adds a form to the first available element in the array.
     
    ;-----------\
    ;Description \	Author: Chesko
    ;----------------------------------------------------------------
    ;Adds a form to the first available element in the array.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		false		=		Error (array full)
    ;		true		=		Success
     
    int i = 0
    ;notification("akMyArray.Length = " + akMyArray.Length)
    while i < akMyArray.Length
        if akMyArray[i] == none
            akMyArray[i] = akMykeyword
            ;notification("Adding " + akMyForm + " to the array.")
            return true
        else
            i += 1
        endif
    endWhile
     
    return false
endFunction

function ArrayClearKeyWord(KeyWord[] akMyArray) global
    ;Deletes the contents of this array.
    ;-----------\
    ;Description \
    ;----------------------------------------------------------------
    ;Deletes the contents of this array.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		none
    int i = 0
    while i < akMyArray.Length
        akMyArray[i] = none
        i += 1
    endWhile
endFunction

int function ArrayHasKeyWord(KeyWord[] akMyArray, KeyWord afMyKeyWord) global
    ;Attempts to find the given form in the given array, and returns the index of the form if found.
    ;-----------\
    ;Description \	
    ;----------------------------------------------------------------
    ;Attempts to find the given form in the given array, and returns the index of the form if found.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		-1		  =		Form not found
    ;		int i		  =		Location of the form
    int i = 0
    while i < akMyArray.Length
        if akMyArray[i] == afMyKeyWord
            return i
        else
            i += 1
        endif
    endWhile
    return -1
endFunction

int function ArrayTotalCountKeyword(Keyword[] akMyKeyword) global
    ;Counts the number of indices in this array that do not have a "none" type.
    ;-----------\
    ;Description \	Author: Chesko
    ;----------------------------------------------------------------
    ;Counts the number of indices in this array that do not have a "none" type.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		int myCount = number of indicies that are not "none"
    int i = 0
    int myCount = 0
    while i < akMyKeyword.Length
        if akMyKeyword[i] != none
            myCount += 1
            i += 1
        else
            i += 1
        endif
    endWhile
    ;notification("MyCount = " + myCount)	
    return myCount
endFunction