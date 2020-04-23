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
     
bool function ArrayRemoveForm(Form[] akMyArray, Form akMyForm, bool akSort = false) global
;Removes a form from the array, if found. Sorts the array using ArraySortForm() if akSort is true.
     
    ;-----------\
    ;Description \	Author: Chesko
    ;----------------------------------------------------------------
    ;Removes a form from the array, if found. Sorts the array using ArraySortForm() if akSort is true.
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
            if akSort == true
                ArraySortForm(akMyArray)
            endif
            return true
        else
            i += 1
        endif
    endWhile	
    return false
    endFunction
     
bool function ArraySortForm(Form[] akMyArray, int i = 0) global
;Removes blank elements by shifting all elements down.
    ;-----------\
    ;Description \  Author: Chesko
    ;----------------------------------------------------------------
    ;Removes blank elements by shifting all elements down.
    ;Optionally starts sorting from element i.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		   false		   =			   No sorting required
    ;		   true			=			   Success
    bool bFirstNoneFound = false
    int iFirstNonePos = i
    while i < akMyArray.Length
        if akMyArray[i] == none
            if bFirstNoneFound == false
                bFirstNoneFound = true
                iFirstNonePos = i
                i += 1
            else
                i += 1
            endif
        else
            if bFirstNoneFound == true
                ;check to see if it's a couple of blank entries in a row
                if !(akMyArray[i] == none)
                    ;notification("Moving element " + i + " to index " + iFirstNonePos)
                    akMyArray[iFirstNonePos] = akMyArray[i]
                    akMyArray[i] = none
                    ;Call this function recursively until it returns
                    ArraySortForm(akMyArray, iFirstNonePos + 1)
                    return true
                else
                    i += 1
                endif
            else
                i += 1
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

bool function ArrayAddInt(Int[] akMyArray, Int akMyInt) global
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
            akMyArray[i] = akMyInt
            ;notification("Adding " + akMyInt + " to the array.")
            return true
        else
            i += 1
        endif
    endWhile
     
    return false
endFunction
     
bool function ArrayRemoveInt(Int[] akMyArray, Int akMyInt, bool akSort = false) global
;Removes a form from the array, if found. Sorts the array using ArraySortForm() if akSort is true.
     
    ;-----------\
    ;Description \
    ;----------------------------------------------------------------
    ;Removes a form from the array, if found. Sorts the array using ArraySortForm() if akSort is true.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		false		=		Error (Form not found)
    ;		true		=		Success
    int i = 0
    while i < akMyArray.Length
        if akMyArray[i] == akMyInt
            akMyArray[i] = 0
            ;notification("Removing element " + i)
            if akSort == true
                ArraySortInt(akMyArray)
            endif
            return true
        else
            i += 1
        endif
    endWhile	
    return false
    endFunction
     
bool function ArraySortInt(Int[] akMyArray, int i = 0) global
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
    int iFirstNonePos = i
    while i < akMyArray.Length
        if akMyArray[i] == 0
            if bFirstNoneFound == false
                bFirstNoneFound = true
                iFirstNonePos = i
                i += 1
            else
                i += 1
            endif
        else
            if bFirstNoneFound == true
                ;check to see if it's a couple of blank entries in a row
                if !(akMyArray[i] == 0)
                    ;notification("Moving element " + i + " to index " + iFirstNonePos)
                    akMyArray[iFirstNonePos] = akMyArray[i]
                    akMyArray[i] = 0
                    ;Call this function recursively until it returns
                    ArraySortInt(akMyArray, iFirstNonePos + 1)
                    return true
                else
                    i += 1
                endif
            else
                i += 1
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
     
     
int function ArrayHasInt(Int[] akMyArray, Int akMyInt) global
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
        if akMyArray[i] == akMyInt
            return i
        else
            i += 1
        endif
    endWhile
    return -1
endFunction
     
     
int function ArrayCountInt(Int[] akMyArray, Int akMyInt) global
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
        if akMyArray[i] == akMyInt
            iCount += 1
            i += 1
        else
            i += 1
        endif
    endWhile
    return iCount
endFunction

;/ Function dedicated to manipulate Int type array (Float[]) /;

bool function ArrayAddFloat(Float[] akMyArray, Float akMyFloat) global
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
            akMyArray[i] = akMyFloat
            ;notification("Adding " + akMyInt + " to the array.")
            return true
        else
            i += 1
        endif
    endWhile
     
    return false
endFunction
     
bool function ArrayRemoveFloat(Float[] akMyArray, Float akMyFloat, bool akSort = false) global
;Removes a form from the array, if found. Sorts the array using ArraySortForm() if akSort is true.
     
    ;-----------\
    ;Description \
    ;----------------------------------------------------------------
    ;Removes a form from the array, if found. Sorts the array using ArraySortForm() if akSort is true.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		false		=		Error (Form not found)
    ;		true		=		Success
    int i = 0
    while i < akMyArray.Length
        if akMyArray[i] == akMyFloat
            akMyArray[i] = 0
            ;notification("Removing element " + i)
            if akSort == true
                ArraySortFloat(akMyArray)
            endif
            return true
        else
            i += 1
        endif
    endWhile	
    return false
endFunction
     
bool function ArraySortFloat(Float[] akMyArray, int i = 0) global
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
    int iFirstNonePos = i
    while i < akMyArray.Length
        if akMyArray[i] == 0
            if bFirstNoneFound == false
                bFirstNoneFound = true
                iFirstNonePos = i
                i += 1
            else
                i += 1
            endif
        else
            if bFirstNoneFound == true
                ;check to see if it's a couple of blank entries in a row
                if !(akMyArray[i] == 0)
                    ;notification("Moving element " + i + " to index " + iFirstNonePos)
                    akMyArray[iFirstNonePos] = akMyArray[i]
                    akMyArray[i] = 0
                    ;Call this function recursively until it returns
                    ArraySortFloat(akMyArray, iFirstNonePos + 1)
                    return true
                else
                    i += 1
                endif
            else
                i += 1
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
     
     
int function ArrayHasFloat(Float[] akMyArray, Float akMyFloat) global
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
        if akMyArray[i] == akMyFloat
            return i
        else
            i += 1
        endif
    endWhile
    return -1
endFunction
     
     
int function ArrayCountFloat(Float[] akMyArray, Float akMyFloat) global
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
        if akMyArray[i] == akMyFloat
            iCount += 1
            i += 1
        else
            i += 1
        endif
    endWhile
    return iCount
endFunction