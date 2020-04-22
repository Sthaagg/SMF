Scriptname _SMF_ArrayUtils Hidden
{Function to manipulate arrays easily}

;/ Function dedicated to manipulate fom type array (form[]) 
Source Creation Kit Wiki: The following functions were created by Chesko. I added them to SMF as it is not easy to found them and set them gloabl to be easily used} /;


bool function ArrayAddForm(Form[] myArray, Form myForm) global
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
    ;notification("myArray.Length = " + myArray.Length)
    while i < myArray.Length
        if myArray[i] == none
            myArray[i] = myForm
            ;notification("Adding " + myForm + " to the array.")
            return true
        else
            i += 1
        endif
    endWhile
     
    return false
endFunction
     
bool function ArrayRemoveForm(Form[] myArray, Form myForm, bool bSort = false) global
;Removes a form from the array, if found. Sorts the array using ArraySortForm() if bSort is true.
     
    ;-----------\
    ;Description \	Author: Chesko
    ;----------------------------------------------------------------
    ;Removes a form from the array, if found. Sorts the array using ArraySortForm() if bSort is true.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		false		=		Error (Form not found)
    ;		true		=		Success
    int i = 0
    while i < myArray.Length
        if myArray[i] == myForm
            myArray[i] = none
            ;notification("Removing element " + i)
            if bSort == true
                ArraySortForm(myArray)
            endif
            return true
        else
            i += 1
        endif
    endWhile	
    return false
    endFunction
     
bool function ArraySortForm(Form[] myArray, int i = 0) global
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
    while i < myArray.Length
        if myArray[i] == none
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
                if !(myArray[i] == none)
                    ;notification("Moving element " + i + " to index " + iFirstNonePos)
                    myArray[iFirstNonePos] = myArray[i]
                    myArray[i] = none
                    ;Call this function recursively until it returns
                    ArraySortForm(myArray, iFirstNonePos + 1)
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
     
function ArrayClearForm(Form[] myArray) global
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
    while i < myArray.Length
        myArray[i] = none
        i += 1
    endWhile
endFunction
     
     
int function ArrayTotalCountForm(Form[] myArray) global
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
    while i < myArray.Length
        if myArray[i] != none
            myCount += 1
            i += 1
        else
            i += 1
        endif
    endWhile
    ;notification("MyCount = " + myCount)	
    return myCount
endFunction
     
     
int function ArrayHasForm(Form[] myArray, Form myForm) global
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
    while i < myArray.Length
        if myArray[i] == myForm
            return i
        else
            i += 1
        endif
    endWhile
    return -1
endFunction
     
     
int function ArrayCountForm(Form[] myArray, Form myForm) global
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
    while i < myArray.Length
        if myArray[i] == myForm
            iCount += 1
            i += 1
        else
            i += 1
        endif
    endWhile
    return iCount
endFunction

;/ Function dedicated to manipulate Int type array (Int[]) /;

bool function ArrayAddInt(Int[] myArray, Int myInt) global
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
    ;notification("myArray.Length = " + myArray.Length)
    while i < myArray.Length
        if myArray[i] == 0
            myArray[i] = myInt
            ;notification("Adding " + myInt + " to the array.")
            return true
        else
            i += 1
        endif
    endWhile
     
    return false
endFunction
     
bool function ArrayRemoveInt(Int[] myArray, Int myInt, bool bSort = false) global
;Removes a form from the array, if found. Sorts the array using ArraySortForm() if bSort is true.
     
    ;-----------\
    ;Description \	Author: Chesko
    ;----------------------------------------------------------------
    ;Removes a form from the array, if found. Sorts the array using ArraySortForm() if bSort is true.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		false		=		Error (Form not found)
    ;		true		=		Success
    int i = 0
    while i < myArray.Length
        if myArray[i] == myInt
            myArray[i] = 0
            ;notification("Removing element " + i)
            if bSort == true
                ArraySortInt(myArray)
            endif
            return true
        else
            i += 1
        endif
    endWhile	
    return false
    endFunction
     
bool function ArraySortInt(Int[] myArray, int i = 0) global
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
    while i < myArray.Length
        if myArray[i] == 0
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
                if !(myArray[i] == 0)
                    ;notification("Moving element " + i + " to index " + iFirstNonePos)
                    myArray[iFirstNonePos] = myArray[i]
                    myArray[i] = 0
                    ;Call this function recursively until it returns
                    ArraySortInt(myArray, iFirstNonePos + 1)
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
     
function ArrayClearInt(Int[] myArray) global
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
    while i < myArray.Length
        myArray[i] = 0
        i += 1
    endWhile
endFunction
     
     
int function ArrayTotalCountInt(Int[] myArray) global
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
    while i < myArray.Length
        if myArray[i] != 0
            myCount += 1
            i += 1
        else
            i += 1
        endif
    endWhile
    ;notification("MyCount = " + myCount)	
    return myCount
endFunction
     
     
int function ArrayHasInt(Int[] myArray, Int myInt) global
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
    while i < myArray.Length
        if myArray[i] == myInt
            return i
        else
            i += 1
        endif
    endWhile
    return -1
endFunction
     
     
int function ArrayCountInt(Int[] myArray, Int myInt) global
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
    while i < myArray.Length
        if myArray[i] == myInt
            iCount += 1
            i += 1
        else
            i += 1
        endif
    endWhile
    return iCount
endFunction

;/ Function dedicated to manipulate Int type array (Float[]) /;

bool function ArrayAddFloat(Float[] myArray, Float myFloat) global
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
    ;notification("myArray.Length = " + myArray.Length)
    while i < myArray.Length
        if myArray[i] == 0
            myArray[i] = myFloat
            ;notification("Adding " + myInt + " to the array.")
            return true
        else
            i += 1
        endif
    endWhile
     
    return false
endFunction
     
bool function ArrayRemoveFloat(Float[] myArray, Float myFloat, bool bSort = false) global
;Removes a form from the array, if found. Sorts the array using ArraySortForm() if bSort is true.
     
    ;-----------\
    ;Description \	Author: Chesko
    ;----------------------------------------------------------------
    ;Removes a form from the array, if found. Sorts the array using ArraySortForm() if bSort is true.
    ;-------------\
    ;Return Values \
    ;----------------------------------------------------------------
    ;		false		=		Error (Form not found)
    ;		true		=		Success
    int i = 0
    while i < myArray.Length
        if myArray[i] == myFloat
            myArray[i] = 0
            ;notification("Removing element " + i)
            if bSort == true
                ArraySortFloat(myArray)
            endif
            return true
        else
            i += 1
        endif
    endWhile	
    return false
endFunction
     
bool function ArraySortFloat(Float[] myArray, int i = 0) global
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
    while i < myArray.Length
        if myArray[i] == 0
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
                if !(myArray[i] == 0)
                    ;notification("Moving element " + i + " to index " + iFirstNonePos)
                    myArray[iFirstNonePos] = myArray[i]
                    myArray[i] = 0
                    ;Call this function recursively until it returns
                    ArraySortFloat(myArray, iFirstNonePos + 1)
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
     
function ArrayClearFloat(float[] myArray) global
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
    while i < myArray.Length
        myArray[i] = 0
        i += 1
    endWhile
endFunction
     
     
int function ArrayTotalCountFloat(Float[] myArray) global
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
    while i < myArray.Length
        if myArray[i] != 0
            myCount += 1
            i += 1
        else
            i += 1
        endif
    endWhile
    ;notification("MyCount = " + myCount)	
    return myCount
endFunction
     
     
int function ArrayHasFloat(Float[] myArray, Float myFloat) global
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
    while i < myArray.Length
        if myArray[i] == myFloat
            return i
        else
            i += 1
        endif
    endWhile
    return -1
endFunction
     
     
int function ArrayCountFloat(Float[] myArray, Float myFloat) global
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
    while i < myArray.Length
        if myArray[i] == myFloat
            iCount += 1
            i += 1
        else
            i += 1
        endif
    endWhile
    return iCount
endFunction