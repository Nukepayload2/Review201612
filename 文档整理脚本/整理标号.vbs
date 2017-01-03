' 文件打开模式
const ForWriting = 2

' Char.IsLatin1
Function IsLatin1(ch)
    IsLatin1 = AscW(ch) <= &HFF
End Function

' 是不是空白拉丁1字符
Function IsWhiteSpaceLatin1(c)
    ch=ascw(c)
    ' .NET 源码的写法：
    ' return ch=32 orelse ch >= &H9 andalso ch <= &Hd orelse ch=&Ha0 orelse ch=&H85
    if ch=32 then
        IsWhiteSpaceLatin1=true
        exit Function
    elseif ch >= &H9 then
        if ch <= &Hd then
            IsWhiteSpaceLatin1=true
            exit Function
        end if
    elseif ch=&Ha0 then
        IsWhiteSpaceLatin1=true
        exit Function
    elseif ch=&H85 then
        IsWhiteSpaceLatin1=true
        exit Function
    end if
    IsWhiteSpaceLatin1=false
End Function

' 去除开始空白字符
Function TrimStart(strString)
    for i = 1 to len(strString)
        ch = mid(strString,i,1)
        if IsLatin1(ch) then
            if not IsWhiteSpaceLatin1(ch) then
                TrimStart = Mid(strString, i)
                exit Function
            end if
        elseif ch="　" then
        else
            exit for
        end if
    next
    TrimStart = strString
End Function

' 入口点
Sub Main(args)
    if args.length < 1 then
        msgbox "拖动至少一个文本文件到脚本",vbexclamation,"参数错误"
    	wscript.quit 1
    end if
    set fso = createobject("scripting.filesystemobject")
    set regex = new regexp
    with regex
        ' TODO: 升级到.NET版本后在表达式前添加这个再进行匹配：
        ' (?<=[^\d])
        .Pattern = ".{0}(?=(\d+[\.、，,]|[①②③④⑤⑥⑦⑧⑨⑩]))"
        .Global = true
    end with
    for each fn in args
        if fso.FileExists(fn) then
    	    set inStrm = fso.OpenTextFile(fn)
    	    if instr(fn,".")<=instr(fn,"\") then
    		    msgbox "拖动上来的不是文本文件或者没有在本地存储",vbCritical,"错误"
    		    wscript.quit 1
    	    end if
    	    newFileName = left(fn,instrrev(fn,"."))+"_proc.txt"
    	    set outStrm = fso.OpenTextFile(left(fn,instrrev(fn,"."))+"_proc.txt",ForWriting,true)
    	    inText = inStrm.ReadAll
    	    inStrm.Close
            ' TODO: 升级到.NET版本后不再需要剪裁起始处
    		outStrm.Write TrimStart(regex.Replace(inText, vbCrLf))
    	    outStrm.Close
        else
    	    msgbox "有一个或多个文件不是文本文件",vbexclamation,"参数错误"
    	    wscript.quit 1
        end if
    next
End Sub

Main wscript.arguments