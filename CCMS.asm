include irvine32.inc

.data

; welcome page----/
one byte "-------------------------------------------------------------------------------------------------",0
two byte "|                 WELCOME TO                                                                    |",0
three byte "|                            CYBER CAFE                                                         |",0
four byte "|                                       MANAGEMENT                                              |",0
five byte "|                                                 SYSTEM                                        |",0
six byte "-------------------------------------------------------------------------------------------------",0
seven byte "                   PLEASE REGISTER YOURSELF FIRST!",0



; menu page-----/
line byte  "                     +-----------------------------------+",0
menu1 byte "                     |  1. Register Customer.            |",0
menu2 byte "                     |  2. Add New Computer in Record.   |",0
menu5 byte "                     |  3. Display Customer Inventory    |",0
menu6 byte "                     |  4. Display Computer Inventory    |",0
menu7 byte "                     |  5. Exit                          |" ,0
choice byte "                          Enter your choice: ",0


; second menu page
menu3 byte "                     |  1. Start Session.                |",0
menu4 byte "                     |  2. End Session.                  |",0
menu8 byte "                     |  3. Exit.                         |",0
sorry byte "                 No computer available, sorry for inconvience :(",0


; customer information----/
format byte "-------------------------------------------------------------------------------------------------",0
info byte "|                  PLEASE ENTER YOUR INFORMATION TO REGISTER :)                                  |",0
format1 byte "-------------------------------------------------------------------------------------------------",0
requiredline byte "                ---------------------------------------------------",0
requiredname byte "                      FULL NAME : ",0
requiredcontact byte "                     CONTACT NUMBER : ",0
requiredspace byte "                                       |,0"
customername byte 30 DUP(?)
customercontact byte 15 DUP(?)
success byte "|                  REGISTERATION SUCCESSFUL!!                                                   |",0

customerNames byte 100 * 30 DUP(?)
customerContacts byte 100 * 15 DUP(?)
customerCount DWORD 0 
nameformat byte "            Customer Name : ",0
phoneformat byte "      |    Customer Contact : ",0
space byte "  ",0



; computer information-----/
compinfo byte "|                  PLEASE ENTER INFORMATION TO STORE NEW COMPUTER ENTRY:)                         |",0
compid byte "                        ASSIGN COMPUTER ID : ",0
computerData byte 100*10 DUP(?)
computer byte 10 DUP(?)
successcomp byte "|                  COMPUTER ENTRY SUCCESSFUL!!                                                  |",0

computerCount DWORD 0 
computerStore byte "                          Computer  : ",0
empty byte "                  The  inventory is empty :(                                                     |",0


; Session information-----/
startTime SYSTEMTIME <>
endTime SYSTEMTIME <>
sessionStart dword ?
sessionEnd dword ?
sessionDuration dword ?
sessionCharge dword ?
start byte "Session Started at: ",0
se byte "Session Ended at: ",0
sd byte "Your Session Duration was : ",0
sc byte "Your Total Bill is Rs. ",0
colon byte ":",0
started byte "|                  YOUR SESSION HAS STARTED                                                     |",0
ended byte "|                  YOUR SESSION HAS ENDED                                                        |",0
secs byte "secs",0



; exit----/
exiting byte "|                  YOU ARE EXISTING THE SYSTEM                                                  |",0



;------------------------------------------------------------------------------------------------------------------------------------------



.code
main PROC

call welcome

main_loop:

    call displaymenu

    call readint

    cmp eax, 1
    je registerCustomer
    cmp eax, 2
    je registerComputer
    cmp eax, 3
    mov ecx, customerCount 
    mov esi, 0 
    je display_loop
    cmp eax, 4
    mov ecx, computerCount    
    mov esi, 0 
    je displayComputers
    cmp eax , 5
    je exitProgram

jmp main_loop


                                  ;---------------------------------------------------------------;

registerCustomer:

    call crlf
    lea edx, format
    call writestring
    call crlf

    lea edx, info
    call writestring
    call crlf

    lea edx, format
    call writestring
    call crlf

    lea edx, requiredline
    call writestring 
    call crlf

    mov edx, offset requiredname
    call writestring
    mov edx, offset customername
    mov ecx, SIZEOF customername
    call readstring

 
    mov edx, offset requiredcontact
    call writestring
    mov edx, offset customercontact
    mov ecx, SIZEOF customercontact
    call readstring

  
    lea edx, requiredline
    call writestring 
    call crlf

    mov eax, customerCount 
    mov ebx, 30
    mul ebx
    lea edi, customerNames
    add edi, eax
    mov esi, offset customername
    mov ecx, 30
    rep movsb

    mov eax, customerCount
    mov ebx, 15
    mul ebx
    lea edi, customerContacts
    add edi, eax
    mov esi, offset customercontact
    mov ecx, 15
    rep movsb

    inc customerCount

    call crlf
    lea edx, format
    call writestring
    call crlf

    lea edx, success
    call writestring
    call crlf

    lea edx, format1
    call writestring
    call crlf
    call crlf
    
    second_loop:
    call secondmenu

    call readint

     cmp eax, 1
     je startSession
     cmp eax, 2
    je endSession
    cmp eax, 3
    je main_loop
          
    jmp second_loop
                                     ;---------------------------------------------------------------------------------;

registerComputer:

    call crlf
    lea edx, format
    call writestring
    call crlf

    lea edx, compinfo
    call writestring
    call crlf

    lea edx, format1
    call writestring
    call crlf

    lea edx, requiredline
    call writestring 
    call crlf

     mov edx, offset compid
    call writestring
    mov edx, offset computer
    mov ecx, SIZEOF computer
    call readstring

    lea edx, requiredline
    call writestring 
    call crlf

    mov eax, computerCount
    mov ebx, 10
    mul ebx
    lea edi, computerData
    add edi, eax
    mov esi, offset computer
    mov ecx, 10
    rep movsb

    inc computerCount

    call crlf
    lea edx, format
    call writestring
    call crlf

    lea edx, successcomp
    call writestring
    call crlf

    lea edx, format1
    call writestring
    call crlf
    call crlf

    jmp main_loop

                                 ;--------------------------------------------------------------------;

startSession:


    cmp computerCount, 0
    je exitingg

    call crlf
    invoke GetSystemTime, ADDR startTime

    lea edx, start
    call writestring

    ; Display the time in hours:minutes:seconds format

    movzx eax, startTime.wHour    
    call WriteDec            
    lea edx, colon
    call writestring         

    movzx eax, startTime.wMinute  
    call WriteDec            
    lea edx, colon
    call writestring

    movzx eax, startTime.wSecond  
    call WriteDec            

   
    call CrLf
    lea edx, format
    call writestring
    call crlf

    lea edx, started
    call writestring
    call crlf

    lea edx, format1
    call writestring
    call crlf
    call crlf

    jmp second_loop

                                 ;--------------------------------------------------------------------------;

endSession:

    call crlf
    invoke GetSystemTime, ADDR endTime

    lea edx, se
    call writestring
   
    movzx eax, endTime.wHour    
    call WriteDec            
    lea edx, colon
    call writestring         

    movzx eax, endTime.wMinute  
    call WriteDec            
    lea edx, colon
    call writestring

    movzx eax, endTime.wSecond  
    call WriteDec            

    
    call CrLf
    lea edx, format
    call writestring
    call crlf

    lea edx, ended
    call writestring
    call crlf

    lea edx, format1
    call writestring
    call crlf

    mov ax, word ptr [endTime.wSecond]
    sub ax, word ptr [startTime.wSecond]
    mov sessionDuration, eax

    lea edx, sd
    call writestring
    call writedec
    lea edx, secs
    call writestring
    call crlf

    call displaySession

    jmp second_loop


exitingg:
   ; No computer available, sorry for inconvience :(
   lea edx, sorry
   call writestring
   call crlf
   lea edx, format
   call writestring
   call crlf
   jmp main_loop

                              ;----------------------------------------------------------------------------------;

exitProgram:

    call crlf
    lea edx, format
    call writestring
    call crlf

    lea edx, exiting
    call writestring
    call crlf

    lea edx, format1
    call writestring
    call crlf

    exit

                                 ;----------------------------------------------------------------------------------;


display_loop:

    cmp customerCount, 0
    je emptyInventory

    cmp esi, ecx                
    jge done_displaying 
    
    call crlf
    
    lea edx, nameformat
    call writestring

    mov eax, esi
    mov ebx, 30
    mul ebx
    lea edx, customerNames[eax]
    call writestring
    
    lea edx, space
    call writestring
   
    lea edx, phoneformat
    call writestring
    mov eax, esi
    mov ebx, 15
    mul ebx
    lea edx, customerContacts[eax]
    call writestring
    call crlf
    call crlf

    inc esi                    
    jmp display_loop            

                                 ;----------------------------------------------------------------------------------;


done_displaying:
    jmp main_loop 
                                  ;----------------------------------------------------------------------------------;


displayComputers:

    cmp computerCount, 0
    je emptyInventory

    cmp esi, ecx
    jge done_comp

    call crlf
    lea edx, computerStore
    call writestring
    mov eax, esi
    mov ebx, 10
    mul ebx
    lea edx, computerData[eax]
    call writestring
    
    call crlf
    call crlf

   inc esi 
   jmp displayComputers
                                ;----------------------------------------------------------------------------------;


done_comp:

  jmp main_loop

emptyInventory:
  call crlf

  lea edx, format
  call writestring
  call crlf
  lea edx, empty
  call writestring
  call crlf
  lea edx, format
  call writestring
  call crlf
  call crlf
  jmp main_loop
     

main ENDP


;--------------------------------------------------------------------------------------------------------------------------------------------------;

welcome PROC
    lea edx, one
    call writestring
    call crlf
    lea edx, two
    call writestring
    call crlf
    lea edx, three
    call writestring
    call crlf
    lea edx, four
    call writestring
    call crlf
    lea edx, five
    call writestring
    call crlf
    lea edx, six
    call writestring
    call crlf
    call crlf
    lea edx, seven
    call writestring
    call crlf
    ret
welcome ENDP


;------------------------------------------------------------------------------------------------------------------------------------------

displaymenu PROC

    lea edx, line
    call writestring
    call crlf

    lea edx, menu1 
    call writestring
    call crlf

    lea edx, menu2
    call writestring
    call crlf


    lea edx, menu5
    call writestring
    call crlf

    lea edx, menu6
    call writestring
    call crlf

    lea edx, menu7
    call writestring
    call crlf

    lea edx, line
    call writestring
    call crlf

    lea edx, choice
    call writestring
    
    ret
displaymenu ENDP

;------------------------------------------------------------------------------------------------------------------------------------------

getTime PROC
    lea edx,start
    call writestring
    ret
getTime ENDP

;------------------------------------------------------------------------------------------------------------------------------------------

displaySession PROC
    mov edx, 0
    mov eax, sessionDuration
    mov ebx, 60 
    div ebx     
    mov sessionCharge, eax 
    lea edx, sc
    call writestring 
    call writedec
    call crlf
    call crlf
    ret
displaySession ENDP

secondmenu PROC
     call crlf
     lea edx, line
     call writestring
     call crlf
     lea edx, menu3
     call writestring
     call crlf
     lea edx, menu4
     call writestring
     call crlf
     lea edx, menu8
     call writestring
     call crlf
     lea edx, line
     call writestring
     call crlf
     lea edx, choice
    call writestring

    ret
secondmenu ENDP
END main
