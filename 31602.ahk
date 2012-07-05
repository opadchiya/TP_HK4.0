DetectHiddenWindows, On

SPI_SETDEFAULTINPUTLANG = 0x5A ; команда назначения языка по умолчанию
LangRU = 419 ; константа для русского языка
LangEN = 409 ; константа для английского языка

RegRead, Preload_Lang_1, HKEY_CURRENT_USER, Keyboard Layout\Preload, 1 ; прочитать какая первая раскладка (по умолчанию)
If Preload_Lang_1 = %LangRU% ; если русская, то...
{
    MsgBox, 0, Внимание., Текущий язык ввода по умолчанию - русский.`n Для корректной работы необходимо сменить на английский.
;    DllCall( "SystemParametersInfo", UInt, SPI_SETDEFAULTINPUTLANG, UInt, 0, UInt, 4090 . LangEN, UInt, 4)
;    RegWrite, REG_SZ, HKCU, Keyboard Layout\Preload , 1, 00000%LangEN% ; пишем английскую раскладку в реестр
;    RegWrite, REG_SZ, HKCU, Keyboard Layout\Preload , 2, 00000%LangRU% ; пишем русскую раскладку в реестр
}


;  DEFINED
file=Logs_TT.txt
IniRead, file, conf.ini, section_0, Logs_TT
FileHdOut=hd.txt
PasswordPost=
PasswordTkd=
PasswordCisco=
space=
default=0
var=0
NoTT=5
Cli1=section_5.dlink_CLI
Cli2=section_5.alcatel_CLI
SetWinDelay, 200
SetKeyDelay, 10,10
SetMouseDelay, 10, Play
FormatTime, CurrentDateTime,, M/d/yyyy h:mm tt
Process, Priority, , High
;FileAppend, `n%CurrentDateTime%`n, %file%
FileAppend, `n, %file%
Menu, HelpMenu, Add, &Справка HotKey	F1, MyL02
Menu, HelpMenu, Add, &О программе, MenuHandler
Menu, MyMenuBar, Add, &Настройки, SettingMenu
Menu, MyMenuBar, Add, &Справка, :HelpMenu
Menu, MyMenuBar2, Add, &Открыть, FileOpen
Menu, MyMenuBar2, Add, &Настройки, SettingMenu
Menu, MyMenuBar2, Add, &Справка, :HelpMenu

TrayTip, ,Для начала работы нажмите F9
SetTimer, RemoveTrayTip, 20000

help=
(
F9	    Открытие заявки

F8	    Открытие списка заявок

Ctrl+s	    Сохранение номера заявки с комментарием в файле

Ctrl+p	    Вход в почту

Ctrl+f	    Поиск в cmd и в crt

Alt+b	    Вход на брабус

Ctrl+1	    Вставка логин/пароль на оборудование Alcatel, Dlink(в консоли, SecureCRT)

Ctrl+2	    Вставка логин/пароль на оборудование Cisco(в консоли, SecureCRT)

Alt+m	    Запуск выполнения команд на d-linkе, alcatel(в консоли, SecureCRT)

Ctrl+v	    В активном окне оранджа - преобразование адреса клиента с hlpdeska в формат оранджа(в поиске оранджа).
	    (Нужно предварительно скопировать адрес c hlpdeska)

Alt+r	    Отправка письма для использования программ удаленного доступа. 
		(Предварительно надо скопировать номер заявки.)
		
Alt+l	    Поиск в логах авторизации. Необходимо быть залогиненым на брабус. 
		(Предварительно надо скопировать логин клиента.)
		
Alt+Enter	    В активном окне helpdesk, ums - добавление тега <br> в конце каждой строки

		

	      Перед нажатием следующих комбинации необходимо скопировать ip адрес:

Alt+t	    Трассировка до узла

Alt+p	    Пинг до узла

F2	    Телнет к свитчам Совинтела(на 172..)

F12	    Telnet к ткд, брасу и т.д.

F7	    Автозаполнение полей страницы создания ГП масштабом в дом, сегмент. 
	    Необходимо поставить курсор на первое поле даты
		
)

Hotkey, IfWinActive, Helpdesk Corbina telecom
Hotkey, F7, MyL04
Hotkey, ^Sc01F, MyL03
Hotkey, !Sc01C , AnL35	;Enter в хелпдеске(добавление тега <br>)


Hotkey, IfWinActive, Utilization Management System
Hotkey, !Sc01C , AnL35	;Enter в UMS(Добавление тега <br>)

Hotkey, IfWinActive, Hlpdesk HotKey
Hotkey, F1, MyL02

Hotkey,IfWinActive, Поиск (F3 - найти далее)
Hotkey, ^Sc02F, MyL21

Hotkey, IfWinActive, ahk_class VanDyke Software - SecureCRT
Hotkey, !Sc032, MyL12
Hotkey, ^Sc021, MyL11
Hotkey, ^2, MyL13
Hotkey, ^1, MyL14

Hotkey, IfWinActive, ahk_class ConsoleWindowClass
Hotkey, !Sc032, MyL12
Hotkey, ^Sc021, MyL115
Hotkey, ^Sc01E, MyL116
Hotkey, ^2, MyL13
Hotkey, ^1, MyL14
return

;=======================================

RemoveTrayTip:
SetTimer, RemoveTrayTip, off
TrayTip
return

;=======================================
MyL11:
SendMessage, 0x50,, 0x4090409,, A
Send,  !ef
return

MyL115:
Send,  {AltDown}{Space}{AltUp}{Up 3}{Right}{Up}{Enter}
return

MyL116:
Send,  {AltDown}{Space}{AltUp}{Up 3}{Right}{Enter}
return

MenuHandler:
Gui, 10:font,Normal s8, Verdana
Gui, 10:Add, Text,x10 y10,Hlpdesk HotKey
Gui, 10:Add, Text,, версия 3.16
Gui, 10:Add, Text,, © Виталий Петров, Андрей Герасимович, 2012. Все права защищены.
Gui, 10:Add, Picture, ym x+10 w100 h-1, smile.jpg
Gui, 10:Add, Button, xm+150 ym+80  w60 Default, OK
Gui, 10:Show, , Hlpdesk HotKey
return

10ButtonOk:
10GuiClose:
10GuiEscape:
  Gui, 10:Destroy
return



MyL12:
Gui, 2:Destroy
WinGetActiveTitle, OutputVar
SendMessage, 0x50,, 0x4090409,, A
Gui, 2:font,Normal s8, Verdana
Menu, HelpMenu, Add, &Справка HotKey	F1, MyL02
Menu, HelpMenu, Add, &О программе, MenuHandler
Menu, MyMenuBar, Add, &Справка, :HelpMenu
Gui, 2:Menu, MyMenuBar
Gui, 2:Add, Text,xm+50,Укажите номер порта:
Gui, 2:Add, Edit, w50 ym limit5 vinp_port
Gui, 2:Add, Button, x20  w60 default, Dlink
Gui, 2:Add, Button, x+20 w60 , Alcatel
Gui, 2:Add, Button, x+40 w60, Cancel
Gui, 2:Show, w270, Hlpdesk HotKey
return

2ButtonDlink:
  Gui, 2:Submit
  Cli=%Cli1%
  IfWinActive, ahk_class VanDyke Software - SecureCRT
	GoSub MyL16
  else
  	GoSub MyL15
  SetKeyDelay, 10,10
  Gui, 2:Destroy
return

2ButtonAlcatel:
  Gui, 2:Submit
  Cli=%Cli2%
  IfWinActive, ahk_class VanDyke Software - SecureCRT
	GoSub MyL16
  else
  	GoSub MyL15
  SetKeyDelay, 10,10
  Gui, 2:Destroy
return

2GuiClose:
2GuiEscape:
2ButtonCancel:
  Gui, 2:Destroy
return


MyL15:
SetKeyDelay, 0,10
i=0
loop 10
{
 ControlSend,  ,{ESC}, %OutputVar%
; ControlSend,  ,{Sc010}, %OutputVar%
 IniRead, cmd, conf.ini, %Cli%, cmd%i%
 if cmd=ERROR
  return
 if cmd=
  return
StringReplace, cmd, cmd, <port>, %inp_port%,
ControlSendRaw,  ,%A_SPACE%%cmd%, %OutputVar%
ControlSend,  ,{Enter}, %OutputVar%
Sleep 500
StringReplace, cmd, cmd, test,,
if ErrorLevel=0
 sleep 3000
i++
}
return


MyL16:
SetKeyDelay, 0,10
i=0
loop 10
{
 WinWaitActive, %OutputVar%,,10
 If ErrorLevel=1
  break

 Send {ESC}
 IniRead, cmd, conf.ini, %Cli%, cmd%i%
 if cmd=ERROR
  return
 if cmd=
  return
 StringReplace, cmd, cmd, <port>, %inp_port%,
 WinWaitActive, %OutputVar%,,10
 If ErrorLevel=1
  break

 SendInput %A_SPACE%%cmd%
 WinWaitActive, %OutputVar%,,10
 If ErrorLevel=1
  break

 SendInput {Enter}
 Sleep 500
 StringReplace, cmd, cmd, test,test,
 if ErrorLevel=0
  sleep 3000
i++
}
return

MyL13:
  SendMessage, 0x50,, 0x4090409,, A
  IniRead, Login, conf.ini, section_2.cisco, login
  IniRead, Password, conf.ini, section_2.cisco, pass
  sleep 300
  GoSub MyL30
return

MyL14:
  SendMessage, 0x50,, 0x4090409,, A
  IniRead, Login, conf.ini, section_1.dlink, login
  IniRead, Password, conf.ini, section_1.dlink, pass
  sleep 300
  GoSub MyL30
return

;=======================================
MyL02:
gui, 6:font,Bold s8, Verdana
Gui, 6:Add, Text,x170 y10,Горячие клавиши
gui, 6:font,Normal s8, Verdana
Gui, 6:Add, Text,x10,%help%
Gui, 6:Add, Button,  x240 y+10  w60 Default, OK
Gui, 6:Show, , Hlpdesk HotKey
return

6ButtonOk:   
6GuiClose:
6GuiEscape:
  Gui, 6:Destroy
return
;=======================================
;Запись в файл номера тикета и примечания к нему
MyL03:
  SetKeyDelay, ,100
 IniRead, FileHdOut, conf.ini, section_0, Save_TT
 if FileHdOut=ERROR
 {
  TrayTip, ,Возникла проблема чтения файла конфигурации conf.ini
  SetTimer, RemoveTrayTip, 1000
 }
  Send, ^{Home}
  sleep 100
  MouseClick, Left, 620, 200, 2
  Send ^{Insert}

  if (Clipboard < 100000000) or (Clipboard > 999999999)
  {
    TrayTip, ,Возникла ошибка копирования номера заявки
    SetTimer, RemoveTrayTip, 5000
    Sleep 1000
    InputBox, Coment, Вставте номер заявки с коментарием:
    FileAppend, `n%Coment%, %FileHdOut%
    return
  }
  InputBox, Coment, Примечание к заявке #%Clipboard%:
  if ErrorLevel=1
    return
  Send ^{F4}
  FileAppend, `n%Clipboard%` %Coment%, %FileHdOut%
return

;=======================================
MyL04:
Gui, Menu, MyMenuBar
Gui, font,Normal s8, Verdana
Gui, Add, Text,, Выберите тип проблемы:
Gui, Add, Button, x20 w60 default, Дом
Gui, Add, Button, x+20 w60, Сегмент
Gui, Add, Button, x+40 w60, Cancel
TrayTip, ` ` Необходимо:, 1. Открыть страницу создания ГП`n2. Поставить курсор на поле даты
SetTimer, RemoveTrayTip, 5000
Gui, show, w270, Hlpdesk HotKey
return

ButtonДом:
  Gui, Submit
    WinActivate, Helpdesk Corbina telecom
    sleep 200
  SendMessage, 0x50,, 0x4190419,, A

  FormatTime, CurrentDateTime,,yyyyMMddHHmm
  var1 = 26
  EnvAdd, CurrentDateTime, %var1%, Hours

  FormatTime, CuDaTi,%CurrentDateTime%, dd
  SendInput, %CuDaTi%
  Send,  {Tab}

  FormatTime, CuDaTi,%CurrentDateTime%, MM
  SendInput, %CuDaTi%
  Send,  {Tab}

  FormatTime, CuDaTi,%CurrentDateTime%, yyyy
  SendInput, %CuDaTi%
  Send,  {Tab}

  FormatTime, CuDaTi,%CurrentDateTime%, HH
  SendInput, %CuDaTi%
  Send,  {Tab}

  FormatTime, CuDaTi,%CurrentDateTime%, mm
  SendInput, %CuDaTi%
  Send,  {Tab}
  Send,  {Ctrldown}ф{Ctrldown}
  Send, {Delete}
  Sleep 50
  IniRead, VarFind, conf.ini, section_4, dom

if VarFind=ERROR
{
  TrayTip, ,Возникла проблема чтения файла conf.ini
  SetTimer, RemoveTrayTip, 5000
  return
}

  StringReplace, VarFind, VarFind, VarIP, %Clipboard%, All
  SendInput {Raw}%VarFind%
  Send,  {Tab}
  SendInput, а
  Send,  {Tab}
  SendInput, а
  Send {Tab 2}
return

ButtonСегмент:
  Gui, Submit
    WinActivate, Helpdesk Corbina telecom
    sleep 200
  SendMessage, 0x50,, 0x4190419,, A

  FormatTime, CurrentDateTime,,yyyyMMddHHmm
  var1 = 4
  EnvAdd, CurrentDateTime, %var1%, Hours

  FormatTime, CuDaTi,%CurrentDateTime%, dd
  SendInput, %CuDaTi%
  Send,  {Tab}

  FormatTime, CuDaTi,%CurrentDateTime%, MM
  SendInput, %CuDaTi%
  Send,  {Tab}

  FormatTime, CuDaTi,%CurrentDateTime%, yyyy
  SendInput, %CuDaTi%
  Send,  {Tab}

  FormatTime, CuDaTi,%CurrentDateTime%, HH
  SendInput, %CuDaTi%
  Send,  {Tab}

  FormatTime, CuDaTi,%CurrentDateTime%, mm
  SendInput, %CuDaTi%
  Send,  {Tab}
  Send,  {Ctrldown}ф{Ctrldown}
  IniRead, VarFind, conf.ini, section_4, segment
if VarFind=ERROR
{
  TrayTip, ,Возникла проблема чтения файла conf.ini
  SetTimer, RemoveTrayTip, 5000
  return
}
  StringReplace, VarFind, VarFind, VarIP, %Clipboard%, All
  Send, {Delete}
  Sleep 100
  SendInput {Raw}%VarFind%
  Send,  {Tab}
  SendInput, а
  Send,  {Tab}
  SendInput, а
  Send,  {Tab 2}
return


GuiClose:
GuiEscape:
ButtonCancel:
  Gui, Submit
return

;=======================================
MyL21:
IfExist, test1.txt
  FileDelete, test1.txt

FileIn=test1.txt
line1=
line2=
line3=
line4=
line5=
line21=
StringReplace, Vibor, Clipboard, `,, `n, All
StringReplace, Vibor, Vibor, %A_Tab%, , All
;StringReplace, Vibor, Vibor, %A_SPACE%, , All
FileAppend, %Vibor%`n, %FileIn%
FileReadLine, line1, %FileIn%, 1
FileReadLine, lineR, %FileIn%, 2
FileReadLine, line2, %FileIn%, 3
FileReadLine, line3, %FileIn%, 4
FileReadLine, line4, %FileIn%, 5
FileReadLine, line5, %FileIn%, 6

StringReplace, line3, line3, д.,,
if ErrorLevel=0
{
 GoSub MyL211
 StringReplace, line2, line2, %A_SPACE%,,
 StringReplace, line4, line4, %A_SPACE%,,
 
 StringGetPos, OutputVar, line4, кв
 ;Проверка - есть ли в линии квартира
 if errorlevel=0
 ;Если она есть, то линия отбрасывается
 {
 line4=
 }
 else
 {
 StringReplace, line4, line4, к, корп.` ,
 }
}
else
{
  StringReplace, line4, line4, д.,,
  StringReplace, line5, line5, %A_SPACE%,,
  StringGetPos, OutputVar, line5, кв
  ;Проверка - есть ли в линии квартира
  if errorlevel=0
  ;Если она есть, то линия отбрасывается
  {
  line5=
  }
  else
  {
  StringReplace, line5, line5, к,корп.` ,
  }
  if ErrorLevel=0
  {
    line1=%line1%,%lineR%
    line2=%line3%
    line3=%line4%
	line4=%line5%
    GoSub MyL211
  }
  else
  {
    Send ^{Sc02F}
    IfExist, test1.txt
      FileDelete, test1.txt
    return
  }
}
StringReplace, line3, line3, %A_SPACE%,,

if line21=
  Send ^{Sc02F}
else
{
 line2=%line21%` %line2%
 GoSub MyL212
}
IfExist, test1.txt
  FileDelete, test1.txt
return

MyL211:
StringReplace, line2, line2, улица,,
if ErrorLevel=0
  line21=улица

StringReplace, line2, line2, бульвар,,
if ErrorLevel=0
 line21=бульвар

StringReplace, line2, line2, проспект,,
if ErrorLevel=0
 line21=проспект

StringReplace, line2, line2, переулок,,
if ErrorLevel=0
 line21=переулок

StringReplace, line2, line2, набережная,,
if ErrorLevel=0
 line21=набережная

StringReplace, line2, line2, площадь,,
if ErrorLevel=0
 line21=площадь

StringReplace, line2, line2, проезд,,
if ErrorLevel=0
 line21=проезд
return

MyL212:
IfWinActive Поиск (F3 - найти далее)
 {
  SendMessage, 0x50,, 0x4190419,, %A_ScriptFullPath%
  Clipboard=%line1%` %line2%` %line3%` %line4%
 }
Send ^{Sc02F}
IfExist, test1.txt
  FileDelete, test1.txt
return


;=======================================
F9::
SetKeyDelay, ,50
SetWinDelay, 100
IniRead, hd_tt, conf.ini, section_0, Ticket
sleep 100
if hd_tt=ERROR
{
 TrayTip, ,Возникла проблема чтения файла конфигурации conf.ini
 SetTimer, RemoveTrayTip, 10000
}
Gui, 3:Destroy
Gui, 3:font,Normal s8, Verdana
Gui, 3:Menu, MyMenuBar
Gui, 3:Add, Text,, Введите номер заявки:
Gui, 3:Add, Edit, w90 ym number limit9 vUserInput, %hd_tt%
Gui, 3:Add, Button, x100  w60 Default, OK
Gui, 3:Add, Button, x+40   w60, Cancel
Gui, 3:Show, w270, Hlpdesk HotKey
Send {Right}
return

3ButtonOk:
  Gui, 3:Submit
if (UserInput > 100000000) and (UserInput < 999999999)
{
  Run, http://hlpdesk.corbina.net/findticket.pl?TT=%UserInput%
  sleep 500
  WinWaitActive, Helpdesk Corbina telecom,,15
  If ErrorLevel=1
    return
  IniRead, VarFind, conf.ini, section_0, finding
if VarFind=ERROR
{
  TrayTip, ,Возникла проблема чтения файла conf.ini
  SetTimer, RemoveTrayTip, 5000
}
  sleep 500
  SendMessage, 0x50,, 0x4190419,, Helpdesk Corbina telecom
  Send ^а
  SendInput %VarFind%
  Send {Enter}
 IniRead, file, conf.ini, section_0, Logs_TT
 if FileHdOut=ERROR
 {
  TrayTip, ,Возникла проблема чтения файла конфигурации conf.ini
  SetTimer, RemoveTrayTip, 500
 }

  hd_tt = %UserInput%
  hd_tt /= 1000

  FileAppend,  %UserInput%`n,  %file%
  IniWrite, %hd_tt%, conf.ini, section_0, ticket
  Gui, 3:Destroy
}
Return

3GuiClose:
3GuiEscape:
3ButtonCancel:
  Gui, 3:Destroy
return


;=======================================
;
F8::
SetKeyDelay, ,50
SetWinDelay, 100
if var=1
{
MsgBox, 4,, Продолжить?
IfMsgBox, Yes
{
  GoSub MyL40
  return
}
IfMsgBox, No
{
var=0
default=0
}
}
Gui, 4:Destroy
Gui, 4:font,Normal s8, Verdana
Gui, 4:Menu, MyMenuBar2
Gui, 4:Add, Text,, Введите список заявок:
Gui, 4:Add, Edit, w100 r20 ym number vUserInput, %EditControl%
Gui, 4:Add, Button, x110  w60 Default, OK
Gui, 4:Add, Button, x+30 w60, Cancel
Gui, 4:Show, , Hlpdesk HotKey	;Русская буква е в словек kеy
return

FileOpen:
FileSelectFile, c3,, %A_WorkingDir%, Укажите файл с заявками, *.txt
if ErrorLevel=1
  return
FileRead, FileContents, %c3%
GuiControl,, UserInput, %FileContents%
return

4GuiClose:
4GuiEscape:
4ButtonCancel:
  Gui, 4:Destroy
return


4ButtonOK:
 Gui, 4:Submit
 FileHdIn=hd_in.txt
 FileDelete, %FileHdIn%
 FileAppend,%UserInput%, %FileHdIn%
 Sleep 500
 GoSub MyL40
 Gui, 4:Destroy
return

MyL40:
IniRead, NoTT, conf.ini, section_0, NofTab
sleep 100
if NoTT=ERROR
{
 TrayTip, ,Возникла проблема чтения файла конфигурации conf.ini
 SetTimer, RemoveTrayTip, 1000
}
var=1

TrayTip, ,Дождитесь завершения работы скрипта`, будет открыто %NoTT% заявок
SetTimer, RemoveTrayTip, 10000

Loop
{
  varid=%A_index%
  varid+=%default%
  FileReadLine, line, %FileHdIn%, %varid%
  sleep 200
  if ErrorLevel
  {
    default=%varid%
    TrayTip, ,Возникла проблема чтения
    SetTimer, RemoveTrayTip, 3000
    break
  }
  if (line < 100000000) or (line > 999999999)
  {
    default=%varid%
    TrayTip, ,Возникла проблема чтения No
    SetTimer, RemoveTrayTip, 3000
    break
  }
  Run, http://hlpdesk.corbina.net/findticket.pl?TT=%line%,, Min
  sleep 200
  var++

  if var > %NoTT%
  {
    WinWaitActive, Helpdesk Corbina telecom,,10
    If ErrorLevel=1
      return

    sleep 1000
    SendMessage, 0x50,, 0x4190419,, A
    IniRead, VarFind, conf.ini, section_0, finding
 if VarFind=ERROR
 {
   TrayTip, ,Возникла проблема чтения файла conf.ini
   SetTimer, RemoveTrayTip, 500
 }
    Send ^а
    SendInput %VarFind%
    Send {Enter}
    var-=2
    loop %var%
    {
	Send ^+{Tab}
	WinWaitActive, Helpdesk Corbina telecom,,5
	Send ^а
	Send {Enter}
    }
    var=1
    default=%varid%
    return
  }
}
WinWaitActive, Helpdesk Corbina telecom,,10
If ErrorLevel=1
  return
sleep 1000
SendMessage, 0x50,, 0x4190419,, A
IniRead, VarFind, conf.ini, section_0, finding
if VarFind=ERROR
{
  TrayTip, ,Возникла проблема чтения файла conf.ini
  SetTimer, RemoveTrayTip, 2000
}
var-=1
loop %var%
{
	WinWaitActive, Helpdesk Corbina telecom,,5
	Send ^а
	SendInput %VarFind%
	Send {Enter}
	Send ^+{Tab}
}
Send ^{Tab}
MsgBox, Достигнут конец файла
default=0
var=0
Return


;=======================================
!SC019::
  Run, cmd /k ping %Clipboard% -t
  Sleep 1000
;  SendInput, exit
;  Send, {Enter}
return

;=======================================
!SC014::
  Run, cmd /k tracert %Clipboard%
return


;=======================================
^SC019::
AnL20:
  Run, http://post.ru
  sleep 200
  WinWait, Вход в post.ru
AnL21:
  IniRead, Login, conf.ini, section_3.post, login
  IniRead, Password, conf.ini, section_3.post, pass
if Login=ERROR
{
  TrayTip, ,Возникла проблема чтения файла conf.ini
  SetTimer, RemoveTrayTip, 5000
  return
}
if Password=ERROR
{
  TrayTip, ,Возникла проблема чтения файла conf.ini
  SetTimer, RemoveTrayTip, 5000
  return
}
if Login=
{
  TrayTip, ,Возникла проблема чтения логина из файла conf.ini
  SetTimer, RemoveTrayTip, 5000
  return
}
if Password=
{
  TrayTip, ,Возникла проблема чтения пароля из файла conf.ini
  SetTimer, RemoveTrayTip, 5000
  return
}

  SendMessage, 0x50,, 0x4090409,, A
   Send {Tab}
Sendinput  %Login%
   Send {Tab 2}
Sendinput  {Raw}%Password%
   Send {Tab 3}
Send {Enter}

return

;=======================================


F12::
SetKeyDelay, ,50
StringReplace, Clipboard, Clipboard, `r`n,, All
StringReplace, Clipboard, Clipboard, %A_Tab%,, All
IniRead, Client, conf.ini, section_0, CRTClient
if Client=ERROR
 GoSub MyL32
else
 if Client=
  GoSub MyL32
 else
  GoSub MyL33
If ErrorLevel=1
  return

SendMessage, 0x50,, 0x4090409,, %A_ScriptFullPath%
ipmod=%Clipboard%
ipmod++
ipmod--
if (ipmod < 11) && (ipmod > 9)
{
  sleep 100
  IniRead, Login, conf.ini, section_1.dlink, login
  IniRead, Password, conf.ini, section_1.dlink, pass
;  sleep 300
  GoSub MyL30
}
else
{
  IniRead, Login, conf.ini, section_2.cisco, login
  IniRead, Password, conf.ini, section_2.cisco, pass
;  sleep 300
  GoSub MyL30
}
return

MyL32:
Run, cmd /k telnet %Clipboard%
WinWaitActive, Telnet,,10
return

MyL33:
Run, %Client% /telnet /t %Clipboard%	
WinWaitActive, ahk_class VanDyke Software - SecureCRT,,10
return

MyL30:
vError=0
if Login=ERROR
{
  TrayTip, ,Возникла проблема чтения файла conf.ini
  SetTimer, RemoveTrayTip, 5000
  vError=1
}
if Password=ERROR
{
  TrayTip, ,Возникла проблема чтения файла conf.ini
  SetTimer, RemoveTrayTip, 5000
  vError=1
}
if Login=
{
  TrayTip, ,Возникла проблема чтения логина из файла conf.ini
  SetTimer, RemoveTrayTip, 5000
  vError=1
}
if Password=
{
  TrayTip, ,Возникла проблема чтения пароля из файла conf.ini
  SetTimer, RemoveTrayTip, 5000
  vError=1
}
  If vError=1
    return
  vError=0
Sleep 100
  SendMessage, 0x50,, 0x4090409,, A
  Sendinput  %Login%
  Send {Enter}
  sleep 100
  Sendinput  {Raw}%Password%
  Send {Enter}
  sleep 100
return

;=======================================
MyL31:
if Login=ERROR
{
  TrayTip, ,Возникла проблема чтения файла conf.ini
  SetTimer, RemoveTrayTip, 5000
  return
}
if Password=ERROR
{
  TrayTip, ,Возникла проблема чтения файла conf.ini
  SetTimer, RemoveTrayTip, 5000
  return
}
if Login=
{
  TrayTip, ,Возникла проблема чтения логина из файла conf.ini
  SetTimer, RemoveTrayTip, 5000
  return
}
if Password=
{
  TrayTip, ,Возникла проблема чтения пароля из файла conf.ini
  SetTimer, RemoveTrayTip, 5000
  return
}

  StringReplace, Town, Town%j%, %A_Tab%,,
  SendMessage, 0x50,, 0x4090409,, A
  sleep 1500
  if Town=Белгород
  {
  Sendinput  manager
  Send {Enter}
  sleep 100
  Sendinput  friend
  Send {Enter}
  }
  else
  {
  Sendinput  %Login%
  If Town=Красноярск
    Sendinput  @krsk
  If Town=Нижний Новгород
    Sendinput  @nizhny_hn
  Send {Enter}
  Sendinput  {Raw}%Password%
  Send {Enter}
  Sleep 200
  }
return

;=======================================


F2::
j=1
loop
{
 IniRead, Town%j%, conf.ini, section_7, Town%j%
 if Town%j%=ERROR
 {
  NoCycle=%j%
  NoCycle--
  break
 }
 j++
}

Gui, 9:Destroy
Gui, 9:font,Normal s8, Verdana
Menu, MyMenuBar, Add, &Справка, :HelpMenu
Gui, 9:Menu, MyMenuBar
Gui, 9:Add, Text,, Выберите город:
Gui, 9:Add, ListBox, vMyListBox2 gMyListBox2 ym w180 r27
Gui, 9:Add, Button, Default x110 w60, OK
Gui, 9:Add, Button, x+30 w60, Cancell
Gui, 9:Add, Button, x+60 w90, Brabus_login
j=1
loop %NoCycle%
{
 StringReplace, Town, Town%j%, %A_Tab%,,
 GuiControl,9:, MyListBox2, %Town%
 j++
}
Gui, 9:Show, w270, Hlpdesk HotKey
return

MyListBox2:
if A_GuiControlEvent <> DoubleClick
return

9ButtonOK:
SendMessage, 0x50,, 0x4190419,, %A_ScriptFullPath%
GuiControlGet, MyListBox2
j=1
loop %NoCycle%
{
 if Town%j%=%MyListBox2%
 {
  IniRead, Address%j%, conf.ini, section_7, Address%j%
  StringReplace, Address, Address%j%, %A_Tab%,,

 IniRead, Client, conf.ini, section_0, CRTClient
 if Client=ERROR
  GoSub MyL325
 else
  if Client=
   GoSub MyL325
  else
   GoSub MyL335
 If ErrorLevel=1
  return
  IniRead, Login, conf.ini, section_2.cisco, login
  IniRead, Password, conf.ini, section_2.cisco, pass
  GoSub MyL30
  If vError=1
  { Gui, Destroy
    return 
  }
  StringReplace, Clipboard, Clipboard, `r`n, , All
  StringReplace, Clipboard, Clipboard, %A_Tab%, , All
  sleep 500
  StringReplace, Town, Town%j%, %A_Tab%,,
  if Town=Тюмень
  {
  IniRead, Login, conf.ini, section_1.dlink, login
  IniRead, Password, conf.ini, section_1.dlink, pass
  Sendinput  telnet 192.168.193.11
  Send {Enter}
  sleep 400
  Sendinput  %Login%
  Send {Enter}
  sleep 400
  Sendinput  {Raw}%Password%
  Send {Enter}
  sleep 400
  }
  Sendinput  telnet %Clipboard%{Enter}
  IniRead, Login, conf.ini, section_1.dlink, login
  IniRead, Password, conf.ini, section_1.dlink, pass
  GoSub MyL31
 }
 j++
}

Gui, Destroy
return

9ButtonCancel:
9GuiClose:
9GuiEscape:
Gui, 9:Destroy
return
return

MyL325:
Run, cmd /k telnet %Address%
WinWaitActive, Telnet,,10
return

MyL335:
Run, %Client%  /telnet /t  %Address%
WinWaitActive, ahk_class VanDyke Software - SecureCRT,,10
return

;=======================================


SettingMenu:
IniRead, s0k0, conf.ini, section_0, CRTClient
IniRead, s0k2, conf.ini, section_0, Finding
IniRead, s0k3, conf.ini, section_0, Logs_TT
IniRead, s0k4, conf.ini, section_0, Save_TT
IniRead, s0k5, conf.ini, section_0, NofTab
IniRead, s0k6, conf.ini, section_0, putty, 0
IniRead, s0k7, conf.ini, section_0, PuttyClient
IniRead, s0k8, conf.ini, section_0, mailtext

IniRead, s1k1, conf.ini, section_1.dlink, login
IniRead, s1k2, conf.ini, section_1.dlink, pass
IniRead, s2k1, conf.ini, section_2.cisco, login
IniRead, s2k2, conf.ini, section_2.cisco, pass
IniRead, s3k1, conf.ini, section_3.post, login
IniRead, s3k2, conf.ini, section_3.post, pass
IniRead, s8k1, conf.ini, section_8.brabus, login
IniRead, s8k2, conf.ini, section_8.brabus, gvjpass
IniRead, s8k3, conf.ini, section_8.brabus, brabuspass

IniRead, s4k1, conf.ini, section_4, dom
IniRead, s4k2, conf.ini, section_4, segment

IniRead, s5d1, conf.ini, section_5.dlink_Cli, cmd0
IniRead, s5d2, conf.ini, section_5.dlink_Cli, cmd1
IniRead, s5d3, conf.ini, section_5.dlink_Cli, cmd2
IniRead, s5d4, conf.ini, section_5.dlink_Cli, cmd3
IniRead, s5d5, conf.ini, section_5.dlink_Cli, cmd4
IniRead, s5d6, conf.ini, section_5.dlink_Cli, cmd5
IniRead, s5d7, conf.ini, section_5.dlink_Cli, cmd6
IniRead, s5d8, conf.ini, section_5.dlink_Cli, cmd7
IniRead, s5d9, conf.ini, section_5.dlink_Cli, cmd8
IniRead, s5d10, conf.ini, section_5.dlink_Cli, cmd9

IniRead, s5a1, conf.ini, section_5.alcatel_Cli, cmd0
IniRead, s5a2, conf.ini, section_5.alcatel_Cli, cmd1
IniRead, s5a3, conf.ini, section_5.alcatel_Cli, cmd2
IniRead, s5a4, conf.ini, section_5.alcatel_Cli, cmd3
IniRead, s5a5, conf.ini, section_5.alcatel_Cli, cmd4
IniRead, s5a6, conf.ini, section_5.alcatel_Cli, cmd5
IniRead, s5a7, conf.ini, section_5.alcatel_Cli, cmd6
IniRead, s5a8, conf.ini, section_5.alcatel_Cli, cmd7
IniRead, s5a9, conf.ini, section_5.alcatel_Cli, cmd8
IniRead, s5a10, conf.ini, section_5.alcatel_Cli, cmd9

j=1
loop 26
{
 IniRead, Town%j%, conf.ini, section_7, Town%j%
 IniRead, Address%j%, conf.ini, section_7, Address%j%
 if Town%j%=ERROR
 {
  NoCycle=%j%
  NoCycle--
  TrayTip, ,%NoCycle%
  SetTimer, RemoveTrayTip, 5000
  break
 }
 NoCycle=%j%
 j++
}


Gui, 5:font,Normal s8, Verdana
Gui, 5:Add, Tab,-Wrap w550 h450, Основные|Тексты|CLI|Брасы Совинтела 1|Брасы Совинтела 2
Gui, 5:Tab, 1
Gui, 5:Add, Text, section,
Gui, 5:Add, Text,, Login:
Gui, 5:Add, Text,, Password:

Gui, 5:Add, Text, ys cBlue,D-link
Gui, 5:Add, Edit, r1 y+10 w100 vs1k1,%s1k1%
Gui, 5:Add, Edit, r1 password w100 vs1k2,%s1k2%

Gui, 5:Add, Text, ys cBlue,Cisco
Gui, 5:Add, Edit, r1 y+10 w100 vs2k1,%s2k1%
Gui, 5:Add, Edit, r1 password w100 vs2k2,%s2k2%

Gui, 5:Add, Text, ys cBlue,Post.ru
Gui, 5:Add, Edit, r1 y+10 w100 vs3k1,%s3k1%
Gui, 5:Add, Edit, r1 password w100 vs3k2,%s3k2%
Gui, 5:Add, Text, y+13, Gvj password:
Gui, 5:Add, Text,, Use Putty(1/0)?

Gui, 5:Add, Text, ys cBlue,Brabus
Gui, 5:Add, Edit, r1 y+10 w100 vs8k1,%s8k1%
Gui, 5:Add, Edit, r1 password w100 vs8k3,%s8k3%
Gui, 5:Add, Edit, r1 y+10 password w100 vs8k2,%s8k2%
Gui, 5:Add, Edit, r1 y+10 w100 vs0k6,%s0k6%

Gui, 5:Add, Text, y+46 xm+10 section, Кол-во вкладок:
Gui, 5:Add, Text,, Слово для поиска:
Gui, 5:Add, Text,, Файл для логов:
Gui, 5:Add, Text,, Файл для сейвов:

Gui, 5:Add, Edit, r1 w160 ys vs0k5,%s0k5%
Gui, 5:Add, Edit, r1 w160 vs0k2,%s0k2%
Gui, 5:Add, Edit, r1 w160 vs0k3,%s0k3%
Gui, 5:Add, Edit, r1 w160 vs0k4,%s0k4%

Gui, 5:Add, Text,y+20 xm+10 , SecureCRT:
Gui, 5:Add, Edit, section r1 w400 vs0k0,%s0k0%
Gui, 5:Add, Button, ys w60  x+20 Default, Open

Gui, 5:Add, Text,y+12 xm+10 , Putty:
Gui, 5:Add, Edit, section r1 w400 vs0k7,%s0k7%
Gui, 5:Add, Button, ys w60  x+20, Opеn

Gui, 5:Tab, 2
Gui, 5:Add, Text,Bold cBlue, ГП на дом:
Gui, 5:Add, Edit, r4 w500 vs4k1,%s4k1%
Gui, 5:Add, Text,Bold cBlue, ГП на сегмент:
Gui, 5:Add, Edit, r4 w500 vs4k2,%s4k2%
Gui, 5:Add, Text,Bold cBlue, Письмо на удалённый доступ:
Gui, 5:Add, Edit, r4 w500 vs0k8,%s0k8%

Gui, 5:Tab, 3
Gui, 5:Add, Text,section x+10 cBlue, D-link:
Gui, 5:Add, Edit, r1 w220 vs5d1,%s5d1%
Gui, 5:Add, Edit, r1 w220 vs5d2,%s5d2%
Gui, 5:Add, Edit, r1 w220 vs5d3,%s5d3%
Gui, 5:Add, Edit, r1 w220 vs5d4,%s5d4%
Gui, 5:Add, Edit, r1 w220 vs5d5,%s5d5%
Gui, 5:Add, Edit, r1 w220 vs5d6,%s5d6%
Gui, 5:Add, Edit, r1 w220 vs5d7,%s5d7%
Gui, 5:Add, Edit, r1 w220 vs5d8,%s5d8%
Gui, 5:Add, Edit, r1 w220 vs5d9,%s5d9%
Gui, 5:Add, Edit, r1 w220 vs5d10,%s5d10%

Gui, 5:Add, Text, ys x+10 cBlue, Alcatel:
Gui, 5:Add, Edit, r1 w280 vs5a1,%s5a1%
Gui, 5:Add, Edit, r1 w280 vs5a2,%s5a2%
Gui, 5:Add, Edit, r1 w280 vs5a3,%s5a3%
Gui, 5:Add, Edit, r1 w280 vs5a4,%s5a4%
Gui, 5:Add, Edit, r1 w280 vs5a5,%s5a5%
Gui, 5:Add, Edit, r1 w280 vs5a6,%s5a6%
Gui, 5:Add, Edit, r1 w280 vs5a7,%s5a7%
Gui, 5:Add, Edit, r1 w280 vs5a8,%s5a8%
Gui, 5:Add, Edit, r1 w280 vs5a9,%s5a9%
Gui, 5:Add, Edit, r1 w280 vs5a10,%s5a10%



Gui, 5:Tab, 4
Gui, 5:Add, Text, ys x+30 cBlue, Город:
j=1
loop 13 {
 Gui, 5:Add, Edit, r1 w180 vTown%j%,
 j++
}

Gui, 5:Add, Text, ys x+30 cBlue, Адрес:
j=1
loop 13 {
 Gui, 5:Add, Edit, r1 w280 vAddress%j%,
 j++
}

j=14
Gui, 5:Tab, 5
Gui, 5:Add, Text, ys x+30 cBlue, Город:
loop 13 {
 Gui, 5:Add, Edit, r1 w180 vTown%j%,
 j++
}

Gui, 5:Add, Text, ys x+30 cBlue, Адрес:
j=14
loop 13 {
 Gui, 5:Add, Edit, r1 w280 vAddress%j%,
 j++
}

;--------------SHOW----------------------

Gui, 5:Tab
Gui, 5:Add, Button, xm+240 w60 Default, OK
Gui, 5:Add, Button, x+180 w60, Cancel
Gui, 5:Show,, Hlpdesk HotKey
j=1
loop %NoCycle%
{
 StringReplace, Town, Town%j%, %A_Tab%,,
 StringReplace, Address, Address%j%, %A_Tab%,,
 GuiControl,5:, Town%j%, %Town%
 GuiControl,5:, Address%j%, %Address%
 j++
}

return


5ButtonOpen:
FileSelectFile, VarSecure,, %A_WorkingDir%, Укажите файл CRT, *.exe
if ErrorLevel=1
  return
GuiControl,, s0k0, %VarSecure%
return

5ButtonOpеn:
FileSelectFile, VarSecure,, %A_WorkingDir%, Укажите файл Putty, *.exe
if ErrorLevel=1
  return
GuiControl,, s0k7, %VarSecure%
return


5GuiClose:
5GuiEscape:
5ButtonCancel:
  Gui, 5:Destroy
return


5ButtonOK:
 Gui, 5:Submit
 IniWrite, %s0k0%, conf.ini, section_0, CRTClient
 IniWrite, %s0k5%, conf.ini, section_0, NofTab
 IniWrite, %s0k2%, conf.ini, section_0, Finding
 IniWrite, %s0k3%, conf.ini, section_0, Logs_TT
 IniWrite, %s0k4%, conf.ini, section_0, Save_TT
 IniWrite, %s0k6%, conf.ini, section_0, putty
 IniWrite, %s0k7%, conf.ini, section_0, PuttyClient
 IniWrite, %s0k8%, conf.ini, section_0, mailtext

 IniWrite, %s1k1%, conf.ini, section_1.dlink, login
 IniWrite, %s1k2%, conf.ini, section_1.dlink, pass
 IniWrite, %s2k1%, conf.ini, section_2.cisco, login
 IniWrite, %s2k2%, conf.ini, section_2.cisco, pass
 IniWrite, %s3k1%, conf.ini, section_3.post, login
 IniWrite, %s3k2%, conf.ini, section_3.post, pass
 IniWrite, %s8k1%, conf.ini, section_8.brabus, login
 IniWrite, %s8k2%, conf.ini, section_8.brabus, gvjpass
 IniWrite, %s8k3%, conf.ini, section_8.brabus, brabuspass
  
 IniWrite, %s4k1%, conf.ini, section_4, dom
 IniWrite, %s4k2%, conf.ini, section_4, segment

 IniWrite, %s5d1%, conf.ini, section_5.dlink_Cli, cmd0
 IniWrite, %s5d2%, conf.ini, section_5.dlink_Cli, cmd1
 IniWrite, %s5d3%, conf.ini, section_5.dlink_Cli, cmd2
 IniWrite, %s5d4%, conf.ini, section_5.dlink_Cli, cmd3
 IniWrite, %s5d5%, conf.ini, section_5.dlink_Cli, cmd4
 IniWrite, %s5d6%, conf.ini, section_5.dlink_Cli, cmd5
 IniWrite, %s5d7%, conf.ini, section_5.dlink_Cli, cmd6
 IniWrite, %s5d8%, conf.ini, section_5.dlink_Cli, cmd7
 IniWrite, %s5d9%, conf.ini, section_5.dlink_Cli, cmd8
 IniWrite, %s5d10%, conf.ini, section_5.dlink_Cli, cmd9

 IniWrite, %s5a1%, conf.ini, section_5.alcatel_Cli, cmd0
 IniWrite, %s5a2%, conf.ini, section_5.alcatel_Cli, cmd1
 IniWrite, %s5a3%, conf.ini, section_5.alcatel_Cli, cmd2
 IniWrite, %s5a4%, conf.ini, section_5.alcatel_Cli, cmd3
 IniWrite, %s5a5%, conf.ini, section_5.alcatel_Cli, cmd4
 IniWrite, %s5a6%, conf.ini, section_5.alcatel_Cli, cmd5
 IniWrite, %s5a7%, conf.ini, section_5.alcatel_Cli, cmd6
 IniWrite, %s5a8%, conf.ini, section_5.alcatel_Cli, cmd7
 IniWrite, %s5a9%, conf.ini, section_5.alcatel_Cli, cmd8
 IniWrite, %s5a10%, conf.ini, section_5.alcatel_Cli, cmd9
j=1
loop 26
{
 StringReplace, Town, Town%j%, %A_Tab%,,
 StringReplace, Address, Address%j%, %A_Tab%,,
 IniWrite, %Town%, conf.ini, section_7, Town%j%
 IniWrite, %Address%, conf.ini, section_7, Address%j%
 j++
}

 Gui, 5:Destroy
return

;=======================================


pause::pause
LAlt & WheelDown::AltTab
LAlt & WheelUp::ShiftAltTab

/*
LAlt & WheelDown::
ControlClick, , Helpdesk Corbina, , WheelDown
return

LAlt & WheelUp::
ControlClick, , Helpdesk Corbina, , WheelUp
return

LAlt & WheelUp::ShiftAltTab
*/

!^+SC01E::
TrayTip, ,Author: Vitalij Petrov`nRelease 2.98 Signing 2011
SetTimer, RemoveTrayTip, 10000
return

;=======================================
;Вход на брабус

!b::
IniRead, brabuslogin, conf.ini, section_8.brabus, login
IniRead, gvjpass, conf.ini, section_8.brabus, gvjpass
IniRead, brabuspass, conf.ini, section_8.brabus, brabuspass
IniRead, isputty, conf.ini, section_0, putty
if isputty
{
gosub AnL15
}
else
{
gosub AnL2
}
Sendinput  {Raw}%brabuslogin%
Sleep, 500
Send, {ENTER}
Sleep, 500
Sendinput  {Raw}%gvjpass%
Sleep, 500
Send, {ENTER}
Sleep, 500
Send, ssh{SPACE}brabus{ENTER}
Sleep, 500
Sendinput  {Raw}%brabuspass%
Sleep, 500
Send, {ENTER}
return

AnL15:
IniRead, PuttyClient, conf.ini, section_0, PuttyClient
Run, %PuttyClient%
Sleep, 100
Sendinput , gvj.corbina.net
Send, {ENTER}
Sleep, 500
WinWait, ahk_class PuTTY
IfWinNotActive, ahk_class PuTTY, , WinActivate, ahk_class PuTTY
WinWaitActive, ahk_class PuTTY, 
return

AnL2:
Run, %client% /ssh2 gvj.corbina.net
return

;======================================================================
;========Отправка письма
!r::
IniRead, mailtext, conf.ini, section_0, mailtext
IniRead, sit, conf.ini, section_0, sit, 00
Gui, 11:Destroy
Gui, 11:Menu, MyMenuBar
Gui, 11:font,Normal s8, Verdana
Gui, 11:Add, Text,,  Место:
Gui, 11:Add, Edit, ys vsit, %sit%
Gui, 11:Add, Button, x20 w60 default, Ok
TrayTip, ` ` Необходимо:, 1. Скопировать в буфер обмена номер заявки`n2. Введите номер вашего места `n3. Откройте новое письмо на post.ru и вставьте курсор на поле "Кому"`n4. После того как письмо будет готово, нажмите "Отправить"
SetTimer, RemoveTrayTip, 5000
Gui, 11:show, w270, Hlpdesk HotKey
return

11GuiClose:
11GuiEscape:
11ButtonCancel:
  Gui, 11:Destroy
return

11ButtonOk:
  Gui, Submit
  StringReplace, mailtext, mailtext, (comp), %sit%,
  StringReplace, mailtext, mailtext, (TT), %Clipboard%,
  IniWrite, %sit%, conf.ini, section_0, sit
  
SetTitleMatchMode 2
Sleep, 300
WinWait, @post.ru, 
IfWinNotActive, @post.ru , , WinActivate, @post.ru, 
WinWaitActive, @post.ru, 
Sleep, 500
Sendinput , soc@beeline.ru
Send, {TAB}{TAB}{TAB}{TAB}{TAB}
Sendinput , teamviewer
Send, {TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}
SendMessage, 0x50,, 0x4190419,, A
Sendinput  {Raw}%mailtext%
Send, {ENTER}{ENTER}
Gui, Destroy
Return

;=================================================================
;===============Поиск в логах авторизации
!l::

IniRead, isputty, conf.ini, section_0, putty
TrayTip, ` ` Необходимо:, Скопировать в буфер обмена логин клиента
sleep 100
Gui, 7:Destroy
Gui, 7:font,Normal s8, Verdana
Gui, 7:Menu, MyMenuBar
Gui, 7:Add, Text,, Выберите город
Gui, 7:Add, Button, x20  w60 , МСК
Gui, 7:Add, Button, x+40   w60 Default, РЕГ
Gui, 7:show, w270, Hlpdesk HotKey
return

7GuiClose:
7GuiEscape:
7ButtonCancel:
  Gui, 7:Destroy
return

7ButtonМСК:
  Gui, Submit
  patchlog=tail -f /var/log/aaa/msk*.log | grep
  Gui, Destroy
  GoSub AnL33
  return
  
7ButtonРЕГ:
  Gui, Submit
  patchlog=tail -f /var/log/aaa/reg*.log | grep
  Gui, Destroy
  GoSub AnL33
  return
  
AnL33:
if isputty=1 
{
GoSub AnL30
}
Else 
{
Gosub AnL31
}
return

AnL30:
WinWait, ahk_class PuTTY
IfWinNotActive, ahk_class PuTTY, , WinActivate, ahk_class PuTTY
WinWaitActive, ahk_class PuTTY, 
 Gosub AnL32
 return
 
 AnL31:
 WinWait, ahk_class PuTTY
IfWinNotActive, ahk_class PuTTY, , WinActivate, ahk_class PuTTY
WinWaitActive, ahk_class PuTTY, 
 Gosub AnL32
 return
 
 AnL32:
 StringReplace, clipboard, clipboard, %A_SPACE%, ,All
 Sendinput, %patchlog% %clipboard%
 Send, {ENTER}
 return
 
 ;==================================================================
 ;<br> в хелпдеске, ums
 AnL35:
 SendMessage, 0x50,, 0x4190419,, A
 Send, ^{Sc01E}
 
 ClipSaved := ClipboardAll ; Сохраняет клипборд полностью в указанной переменной.
    ; ... здесь можно временно использовать клипборд, например,
    ; для сохранения текста Unicode с помощью Transform Unicode...
	
 ;temp = %ClipboardAll%
 ;Чтобы не потерять содержимое буфера
 Send, ^{Sc02E}
 StringReplace, clipboard, clipboard, `r`n, <br>`n,All
 StringReplace, clipboard, clipboard, <br><br>, <br>,All
 Sendinput, %clipboard%
 
Clipboard := ClipSaved ; Восстанавливает клипборд.
    ; Заметьте - использован Clipboard (а не ClipboardAll).
ClipSaved = ; Освобождает память, когда клипборд громоздок.

 ;ClipboardAll=%temp%
 SendInput, ^{end}
 sleep 50
 SendInput, {Control Up}
 return
 
 ;===================================================================
  ;Тесты
 ;Тесты
 ;!e::
 ;sendinput, show lldp remote_ports 25-26 mode detailed
 ;send, {enter}
 ;send, a 
 ;VarSetCapacity(buffer, 1000)
 ;Rect=1123
 ;FileDelete fff.txt
 ;WinGet, active_id, ID, A
 ;DllCall("ReadConsole", Ptr, active_id, ptr, Rect, UInt, 500, Ptr, xx, Int, 0)
 ;FileAppend, %Rect%`n, fff.txt
 ;FileAppend, %active_id%`n, fff.txt
 ;FileAppend, %ErrorLevel%`n, fff.txt
 ;return