const ForWriting = 2
fn = wscript.arguments(0)
set fso = createobject("scripting.filesystemobject")
if fso.FileExists(fn) then
    set inStrm = fso.OpenTextFile(fn)
    if instr(fn,".")<=instr(fn,"\") then
        msgbox "拖动上来的文件不是文本文件或者没有在本地存储",vbCritical,"错误"
        wscript.quit 1
    end if
    newFileName = left(fn,instrrev(fn,"."))+"_proc.txt"
    set outStrm = fso.OpenTextFile(left(fn,instrrev(fn,"."))+"_proc.txt",ForWriting,true)
    set regex = new regexp
    inText = inStrm.ReadAll
    inStrm.Close
    with regex
        ' TODO: 升级到.NET版本后使用这个表达式进行匹配：
        ' "(?<=[^\d]).{0}(?=\d+\.)"
        .Pattern = ".{0}(?=\d+\.)"
        .Global = true
        outStrm.Write .Replace(inText, vbCrLf)
    end with
    outStrm.Close
else
    msgbox "拖动一个文本文件到脚本",vbexclamation,"参数错误"
    wscript.quit 1
end if